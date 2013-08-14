//
//  InGame.mm
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 25/07/13.
//  Copyright Epimac 2013. All rights reserved.
//

// Import the interfaces
#import "InGame.h"

//Import touch detection
#import "CCTouchDispatcher.h"

static const int mapCols = 120;
static const int mapRows = 15;
static const float jumpintensity = 40;
static const float gravityconst = 28;

#pragma mark - InGame

@implementation InGame {
    CGPoint startTouch;
    CGPoint stopTouch;
    float dt;
    CGSize size;
    CGSize worldSize;
    bool exploded;
}

Map *map;
Background *background;

@synthesize hero;
@synthesize ennemi;

static int score;

+(int) getScore {
    return score;
}

+(void) scorePlusPlus {
    score++;
}

static bool dead;

+(int) getDead {
    return dead;
}

+(void) setDead:(bool)dead_ {
    dead = dead_;
}

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

-(id) init
{
	if( (self=[super init])) {
        
        size = [[CCDirector sharedDirector] winSize];
        
        worldSize = CGSizeMake(25 * mapCols, 25 * mapRows);
        
        score = 0;
        
        exploded = false;
        
        //init hero
        hero = [[Hero alloc] init];
        [self addChild:hero];
        //end init hero
        
        //init ennemi
        ennemi = [[Ennemi alloc] init:hero];
        [self addChild:ennemi];
        
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
        
        [background initWithHero:hero andWorldWidth:worldSize.width];
        
        particleSystem = [CCParticleSystemQuad particleWithFile:@"Particle/fire.plist"];
        //particleSystem.texture = [[CCTextureCache sharedTextureCache] addImage:@"Particle/fire.png"];
        
        [particleSystem stopSystem];
        [self addChild:particleSystem z:33 tag:99];
        
}
	return self;
}

-(void) dealloc {
    
	delete world;
	world = NULL;
    
    [hero dealloc];
    
    [ennemi dealloc];
    
    delete contactListener;
    
	delete m_debugDraw;
	m_debugDraw = NULL;
	
	[super dealloc];
}

-(void) initPhysics {
    
    [self createWorld:gravityconst]; //create the world
    
    [hero initPhysics:world]; //init hero's body

    [ennemi initPhysics:world]; //init ennemy's body
    
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
    world->SetContinuousPhysics(TRUE);
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

-(void) update: (ccTime) delta {
    
    if (dead && !exploded)
    {
        CGPoint pnt = hero.position;
        particleSystem.position = pnt;
        [particleSystem resetSystem];
        exploded = true;
    }
}

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

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
}


-(void) registerWithTouchDispatcher
{
	[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

@end
