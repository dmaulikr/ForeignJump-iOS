//
//  InGame.mm
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 25/07/13.
//  Copyright Epimac 2013. All rights reserved.
//

#import "InGame.h"
#import "CCTouchDispatcher.h"

#pragma mark - Constant declaration
static const int mapCols = 120;
static const int mapRows = 15;
static const float jumpintensity = 40;
static const float gravityconst = 28;
static const CGPoint heroPosition = ccp(90,280);
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
}

Map *map;
Background *background;

#pragma mark - synthesize
@synthesize hero;
@synthesize ennemy;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
    // add background layer
    background = [Background node];
    [scene addChild: background z: 0];
    
    // add map layer
    map = [Map node];
    
	// add game layer
	InGame *layer = [InGame node];
	[scene addChild: layer z:2];
    
    HUD* hud = [HUD node];
    [scene addChild:hud z: 3];
	
	// return the scene
	return scene;
}

+ (b2World *) getWorld {
    return worldInstance;
}

+ (float) getWorldWidth {
    return worldWidth;
}

#pragma mark - Init Methods

-(id) init
{
	if( (self=[super init])) {
        
        size = [[CCDirector sharedDirector] winSize];
        
        worldSize = CGSizeMake(25 * mapCols, 25 * mapRows);
        
        exploded = NO;
        
        worldWidth = worldSize.width;
        
        //init hero
        hero = [Hero heroWithPosition:heroPosition];
        [self addChild:hero];
        //end init hero
        
        //init ennemy
        ennemy = [Ennemy ennemyWithPosition:ennemiPosition];
        [self addChild:ennemy];
        
        //init physics
        [self initPhysics];
        
        //set up update
        [self scheduleUpdate];
        
        //enable touch
        [self setTouchEnabled:YES];
        [self setAccelerometerEnabled:YES];
		      
        //init map
        [self initMap];
        
        [self runAction: [CCFollow actionWithTarget:hero.texture worldBoundary:CGRectMake(0, 0, worldSize.width, 290)]];
        
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
	return self;
}

-(void) initPhysics {
    
    [self createWorld:gravityconst]; //create the world
    
    [hero initPhysics]; //init hero's body

    [ennemy initPhysics]; //init ennemy's body
    
    [self initScreenEdges];

    //setup contactlistener
    contactListener = new ContactListener();
    world->SetContactListener(contactListener);
}

-(void) initMap {
    
#define GetFullPath(_filePath_) [[NSBundle mainBundle] pathForResource:[_filePath_ lastPathComponent] ofType:nil inDirectory:[_filePath_ stringByDeletingLastPathComponent]]
    
    [map initWithFile:GetFullPath(@"Map/map.txt")];
    [map loadMap:world];

    [self addChild: map z: 1];
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
    
    
    if ([Data getDead] && !exploded)
    {
        
    }
    
    if ([Data isCoinTouched])
    {
        sparkle.position = [Data getCoinPoint];
        [sparkle resetSystem];
        [Data setCoinState:NO];
    }
    
    if ([Data isBombTouched] && !exploded)
    {
        CCDelayTime *delay = [CCDelayTime actionWithDuration:0];
        
        CCCallFunc *explodeAction = [CCCallFunc actionWithTarget:self selector:@selector(releaseExplosion)];
        
        CCCallFunc *smokeAction = [CCCallFunc actionWithTarget:self selector:@selector(releaseSmoke)];
        
        CCSequence *bombsequence = [CCSequence actions:explodeAction, delay, smokeAction, nil];

        [self runAction:bombsequence];
        
        [hero unschedule:@selector(update:)];
        hero.body->SetLinearVelocity(b2Vec2(0,0));
        
        exploded = YES;
    }
}

- (void)releaseExplosion {
    explosion.position = [Data getBombPoint];
    [explosion resetSystem];
}

- (void)releaseSmoke {
    smoke.position = [Data getBombPoint];
    [smoke resetSystem];
}

#pragma mark - Touch methods

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    startTouch = [touch locationInView: [touch view]];
    
    //NSLog(@"StartY : %f", startTouch.y);
    
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    
    stopTouch = [touch locationInView: [touch view]];
    //NSLog(@"StopY : %f", stopTouch.y);
    
    if (startTouch.y > stopTouch.y)
    {
        [hero jump:jumpintensity];
    }
    
    if (startTouch.y < stopTouch.y)
    {
        [hero jump:-jumpintensity];
    }
}

-(void) registerWithTouchDispatcher
{
	[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

#pragma mark - Dealloc

-(void) dealloc {
    
	delete world;
	world = NULL;
    
    [hero dealloc];
    
    [ennemy dealloc];
    
    delete contactListener;
    
	delete m_debugDraw;
	m_debugDraw = NULL;
	
	[super dealloc];
}
@end
