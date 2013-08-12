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
}

Map *map;
Background *background;

@synthesize hero;

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
	
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init])) {
		
        size = [[CCDirector sharedDirector] winSize];
        
        worldSize = CGSizeMake(25 * mapCols, 25 * mapRows);
        
        //init hero
        hero = [[Hero alloc] init];
        [self addChild:hero];
        //end init hero
        
        //init physics
        [self initPhysics];
        
        //set up update
        [self scheduleUpdate];
        
        //enable touch
        [self setTouchEnabled:YES];
        [self setAccelerometerEnabled:YES];
		      
        //init map
        [self initMap];
        
        [self runAction: [CCFollow actionWithTarget:hero.sprite worldBoundary:CGRectMake(0, 0, worldSize.width, 290)]];
	}
	return self;
}

-(void) dealloc {
	delete world;
	world = NULL;
    
    hero.body = NULL;
    
    delete contactListener;
    
	delete m_debugDraw;
	m_debugDraw = NULL;
	
	[super dealloc];
}

-(void) initPhysics {
    
    [self createWorld:gravityconst]; //create the world
    
    [hero initPhysics:world]; //init hero's body
    
    //setup contactlistener
//    contactListener = new ContactListener();
  //  world->SetContactListener(contactListener);
}

-(void) draw
{
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
    
}


-(void) initMap {
    
#define GetFullPath(_filePath_) [[NSBundle mainBundle] pathForResource:[_filePath_ lastPathComponent] ofType:nil inDirectory:[_filePath_ stringByDeletingLastPathComponent]]
    
    [map initWithFile:GetFullPath(@"map.txt")];
    [map loadMap:world];

    [self addChild: map z: 1];
}

- (void) createWorld:(float)intensity {
    // Create a world
    b2Vec2 gravity = b2Vec2(0.0f, -intensity);
    world = new b2World(gravity);
    world->SetAllowSleeping(NO);
}

-(void) update: (ccTime) delta {
   
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
