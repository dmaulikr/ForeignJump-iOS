//
//  InGame.mm
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 25/07/13.
//  Copyright Epimac 2013. All rights reserved.
//
#import "InGame.h"
#import "CCTouchDispatcher.h"
#import "HUD.h"
#import "Background.h"
#import "MainMenu.h"
#import "Character.h"
#import "Ennemy.h"
#import "MenuPause.h"
#import "GameOver.h"
#import "Data.h"

#pragma mark - Constant declaration
static const int mapCols = 110;
static const int mapRows = 15;
static const float jumpintensity = 40;
static const float gravityconst = 28;
static const CGPoint heroPosition = ccp(290,280);
static const CGPoint ennemiPosition = ccp(10,280);

static b2World *worldInstance;
static float worldWidth;

@implementation InGame {
    CGPoint startTouch;
    CGPoint stopTouch;
    
    float dt;
    
    CGSize size;
    CGSize worldSize;
    
    CCParticleSystemQuad *smoke;
    CCParticleSystemQuad *sparkle;
    CCParticleSystemQuad *explosion;
    BOOL exploded;
    BOOL killed;
}

Background *background;
GameOver *gameOver;
MenuPause *menuPause;
HUD* hud;

#pragma mark - synthesize
@synthesize hero;
@synthesize ennemy;
@synthesize acdc = acdc;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
    // add background layer
    background = [Background node];
    [scene addChild: background z: 0];
    
	// add game layer
	InGame *layer = [InGame node];
	[scene addChild: layer z:1];
    
    hud = [HUD node];
    [scene addChild:hud z: 2];
    
    gameOver = [GameOver node];
    [scene addChild:gameOver z: 9999];
	
    menuPause = [MenuPause node];
    [menuPause setVisible:NO];
    [scene addChild:menuPause z: 4];
    
	// return the scene
	return scene;
}

+ (b2World *) getWorld {
    return worldInstance;
}

+ (float) getWorldWidth {
    return worldWidth;
}

+ (void) pauseAll {
    if ([[CCDirector sharedDirector] isPaused])
    {
        [[CCDirector sharedDirector] resume];
        [menuPause setVisible:NO];
        [menuPause.volumeSlider setHidden:YES];
        [menuPause unscheduleUpdate];
    }
    else
    {
        [[CCDirector sharedDirector] pause];
        [menuPause setVisible:YES];
        [menuPause.volumeSlider setHidden:NO];
        [menuPause scheduleUpdate];
    }
}

#pragma mark - Init Methods

-(id) init
{
	if( (self=[super init])) {
        
        [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
        
        size = [[CCDirector sharedDirector] winSize];
        
        worldSize = CGSizeMake(25 * mapCols, 25 * mapRows);
        
        exploded = NO;
        
        worldWidth = worldSize.width;
        
        //enable touch
        [self setTouchEnabled:YES];
        
        //init hero
        hero = [Hero heroWithPosition:heroPosition];
        [self addChild:hero z:0];
        
        //set hero instance
        [background setHero];
        
        //init ennemy
        ennemy = [Ennemy ennemyWithPosition:ennemiPosition];
        [self addChild:ennemy z:0];
        
        acdc = [ACDCHelp acdcWithPosition:ccp(heroPosition.x - 40, heroPosition.y)];
        [self addChild:acdc z:0];
        
        //init physics (hero, ennemy...)
        [self initPhysics];
        
        // add map layer from txt
        map = [Map mapWithFile:GetFullPath([Character map])];
        [self addChild: map z: 1];

        //follow the hero on the map
        [self runAction: [CCFollow actionWithTarget:hero.texture worldBoundary:CGRectMake(0, 0, worldSize.width, 290)]];
        
        //set up update method
        [self scheduleUpdate];
        
        //preload sounds
        [self preloadSounds];
        
        //load all particles systems (piece, smoke, eplosion)
        [self loadParticles];

    }
	return self;
}

-(void) initPhysics {
    
    [self createWorld:gravityconst]; //create the world
    
    [hero initPhysics]; //init hero's body

    [ennemy initPhysics]; //init ennemy's body
    
    [acdc initPhysics]; //init acdc's body
    
    [self initScreenEdges];

    //setup contactlistener
    contactListener = new ContactListener();
    world->SetContactListener(contactListener);
    
    [Data initDestroyArray]; //init the queue for destroying bodies
}

- (void) createWorld:(float)intensity {
    // Create a world
    b2Vec2 gravity = b2Vec2(0.0f, -intensity);
    world = new b2World(gravity);
    world->SetAllowSleeping(NO);
    world->SetContinuousPhysics(YES);
    
    worldInstance = world;
}

- (void) initScreenEdges {
    // Create edges around the entire screen
	b2BodyDef groundBodyDef;
	groundBodyDef.position.Set(0,0);
    
	b2Body *groundBody = world->CreateBody(&groundBodyDef);
	b2EdgeShape groundEdge;
	b2FixtureDef boxShapeDef;
	boxShapeDef.shape = &groundEdge;
    
    //left edge
    groundEdge.Set(b2Vec2(0,0), b2Vec2(0,size.height/PTM_RATIO));
    groundBody->CreateFixture(&boxShapeDef);
    
    //top edge
    groundEdge.Set(b2Vec2(0, size.height/PTM_RATIO),
                   b2Vec2(size.width/PTM_RATIO, size.height/PTM_RATIO));
    groundBody->CreateFixture(&boxShapeDef);
}

#pragma mark - Update

-(void) update: (ccTime) delta {
    
    world->Step(delta, 10, 10);
    for(b2Body *b = world->GetBodyList(); b; b=b->GetNext()) {
        if (b->GetUserData() != NULL && b->GetType() == b2_dynamicBody)
        {
            CCSprite *data = (CCSprite*)b->GetUserData();
            [data setPosition:ccp(b->GetPosition().x * PTM_RATIO, b->GetPosition().y * PTM_RATIO)];
        }
    }
    
    if ([Data isCoinTouched])
    {
        sparkle.position = [Data getCoinPoint];
        [sparkle resetSystem];
        [Data setCoinState:NO];
    }
    
    if ([Data isBombTouched] && !exploded)
    {
        [self stopAll];
        
        CCDelayTime *delay = [CCDelayTime actionWithDuration:0.2];
        
        CCCallFunc *explodeAction = [CCCallFunc actionWithTarget:self selector:@selector(releaseExplosion)];
        
        CCCallFunc *smokeAction = [CCCallFunc actionWithTarget:self selector:@selector(releaseSmoke)];
        
        CCSequence *bombsequence = [CCSequence actions:explodeAction, delay, smokeAction, nil];
        
        [self runAction:bombsequence];
        
        CCFadeOut *fadeOutEnnemy = [CCFadeOut actionWithDuration:1];
        
        [ennemy.texture runAction:fadeOutEnnemy];
    }

    if ([Data isKilledByEnnemy] && !killed)
    {
        [self stopAll];
        
        CCFadeOut *fadeOutEnnemy = [CCFadeOut actionWithDuration:1];
        
        [ennemy.texture runAction:fadeOutEnnemy];
    }
    
    
    if ([Data isDead])
    {
        CCCallFunc *dieAction = [CCCallFunc actionWithTarget:self selector:@selector(die)];
        
        CCDelayTime *delay = [CCDelayTime actionWithDuration:0.5];
        
        CCSequence *gameOverSequence = [CCSequence actions:delay, dieAction, nil];
        
        [self runAction:gameOverSequence];
    }
    
    NSString *str = [NSString stringWithFormat:@"%i", [[Data getToDestroyArray] count]];
    
    if ([Data isDestroyArrayFull])
    {
        [Data destroyAllBodies];
    }
 
}

- (void)releaseExplosion {
    [explosion setPosition:[Data getBombPoint]];
    [explosion resetSystem];
}

- (void)releaseSmoke {
    [smoke setPosition:[Data getBombPoint]];
    [smoke resetSystem];
}

- (void) die {

    CCFadeIn *fade = [CCFadeIn actionWithDuration:1];
    [gameOver.bg runAction:fade];
}

- (void) stopAll {
    
    hero.body->SetLinearVelocity(b2Vec2(0,0));
    
    killed = YES;
    [Data setDead:YES];
    
    [hero unscheduleAllSelectors];
    [hero stopAllActions];
    [ennemy unscheduleAllSelectors];
    [ennemy.texture stopAllActions];
    [ennemy stopAllActions];
    [self stopAllActions];
    [self unscheduleAllSelectors];
}

#pragma mark - Touch methods

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    startTouch = [touch locationInView: [touch view]];
    
    if ([Data isDead])
    {
        //if dead go to main menu
       [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0f scene:[MainMenu scene]]];
    }
    //NSLog(@"StartY : %f", startTouch.y);
    
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    
    stopTouch = [touch locationInView: [touch view]];
    //NSLog(@"StopY : %f", stopTouch.y);
    
    if (![Data isDead]) {
    
        if (startTouch.y > stopTouch.y)
        {
            [hero jump:jumpintensity];
        }
    
        if (startTouch.y < stopTouch.y)
        {
            [hero jump:-jumpintensity];
        }
    }
}

#pragma mark - Load methods

- (void) loadParticles {
    //particles init
    explosion = [CCParticleSystemQuad particleWithFile:@"Particle/fire.plist"];
    [explosion stopSystem];
    [self addChild:explosion z:99];
    
    //coin
    sparkle = [CCParticleSystemQuad particleWithFile:@"Particle/piece.plist"];
    [sparkle stopSystem];
    [self addChild:sparkle z:99];
    
    //bomb smoke
    smoke = [CCParticleSystemQuad particleWithFile:@"Particle/smoke.plist"];
    [smoke stopSystem];
    [self addChild:smoke z:98];
}

- (void) preloadSounds {
    //preload sound effects
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Sounds/coin.caf"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Sounds/bomb.caf"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Sounds/jump.caf"];
}

-(void) registerWithTouchDispatcher
{
	[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:1 swallowsTouches:YES];
}

#pragma mark - Dealloc

-(void) dealloc {
    
	delete world;
	world = NULL;
    
    delete contactListener;
    
	delete m_debugDraw;
	m_debugDraw = NULL;
    
    worldInstance = NULL;
    worldWidth = NULL;
    
    [self unscheduleAllSelectors];
    [self stopAllActions];
    
    [Data resetData];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFrames];
    [CCSpriteFrameCache purgeSharedSpriteFrameCache];
    
    [[SimpleAudioEngine sharedEngine] unloadEffect:@"Sounds/coin.caf"];
    [[SimpleAudioEngine sharedEngine] unloadEffect:@"Sounds/bomb.caf"];
    [[SimpleAudioEngine sharedEngine] unloadEffect:@"Sounds/jump.caf"];
    
	[super dealloc];
}

-(void) draw
{
    /*
	//
	// IMPORTANT:
	// This is only for debug purposes
	// It is recommend to disable it
	//
	[super draw];
	
	ccGLEnableVertexAttribs( kCCVertexAttribFlag_Position );
	
	kmGLPushMatrix();
	
	world->DrawDebugData();
	
	kmGLPopMatrix();
    
    //Initialize debug drawing
    m_debugDraw = new GLESDebugDraw( 32 );
    world->SetDebugDraw(m_debugDraw);
    uint32 flags = 0;
    flags += GLESDebugDraw::e_shapeBit;
    m_debugDraw->SetFlags(flags);
    */
}


@end
