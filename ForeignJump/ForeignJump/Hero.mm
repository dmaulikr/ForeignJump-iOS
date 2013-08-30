//
//  Hero.m
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 29/07/13.
//  Copyright (c) 2013 Epimac. All rights reserved.
//
#import "Hero.h"
#import "InGame.h"

#pragma mark - Constant declaration
static const float densityconst = 1.85f;
static const float velocityx = 4;

//only one Hero instance per game
static Hero *instance;

@implementation Hero {
    BOOL animate;
    CCAction *walkAction;
    float delta;
    b2World *world_;
    
    CCSpriteBatchNode *spriteSheet;
}

#pragma mark - synthesize
@synthesize texture;
@synthesize body;
@synthesize type;
@synthesize position;

#pragma mark - Init methods

+ (Hero *) heroInstance {
    return instance;
}

+ (id) heroWithPosition:(CGPoint)position_ {
    return [[[Hero alloc] initWithPosition:position_] autorelease];
}

- (id) initWithPosition:(CGPoint)position_ {
    
    if ((self = [super init]))
    {
        position = position_;
        
        animate = YES;
        
        type = HeroType;
        
        [self initSprite:[Character heroPlist] andTexture:[Character heroTexture]];
        
        instance = self;
    }
    return self;
}

- (void) initSprite:(NSString *)plist andTexture:(NSString *)texture_ {
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:plist];
    
    spriteSheet = [CCSpriteBatchNode batchNodeWithFile:texture_];
    
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    
    for (int i=1; i<=12; i++) {
        [walkAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"%d.png",i]]];
    }
    
    CCAnimation *walkAnim = [CCAnimation animationWithSpriteFrames:walkAnimFrames delay:0.05f];
    
    texture = [CCSprite spriteWithSpriteFrameName:@"1.png"];
    walkAction = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:walkAnim]];
    [texture runAction:walkAction];
    
    [texture setPosition:position];
    [texture setTag:HeroType];
    [spriteSheet addChild:texture];
    
    [self addChild:spriteSheet];
}

- (void) initPhysics {
    world_ = [InGame getWorld];
    
    // Create hero body and shape
    b2BodyDef heroBodyDef;
    heroBodyDef.fixedRotation = true;
    heroBodyDef.type = b2_dynamicBody;
    heroBodyDef.position.Set(position.x/PTM_RATIO, position.y/PTM_RATIO);
    body = world_->CreateBody(&heroBodyDef);
    body->SetUserData(texture);
    
    b2PolygonShape shape;
    int num = 6;
    b2Vec2 vertices[] = {
        b2Vec2(21.0f / PTM_RATIO, -35.0f / PTM_RATIO),
        b2Vec2(20.0f / PTM_RATIO, -2.5f / PTM_RATIO),
        b2Vec2(17.0f / PTM_RATIO, 17.5f / PTM_RATIO),
        b2Vec2(-19.0f / PTM_RATIO, -5.5f / PTM_RATIO),
        b2Vec2(-21.0f / PTM_RATIO , -27.500 /PTM_RATIO),
        b2Vec2(-19.0f / PTM_RATIO , -34.500 /PTM_RATIO)
    };
    shape.Set(vertices,num);
    
    b2PolygonShape shape2;
    int num2 = 5;
    b2Vec2 vertices2[] = {
        b2Vec2(11.0f / PTM_RATIO, 35.0f / PTM_RATIO),
        b2Vec2(0.0f / PTM_RATIO, 35.5f / PTM_RATIO),
        b2Vec2(-14.0f / PTM_RATIO, 20.5f / PTM_RATIO),
        b2Vec2(-19.0f / PTM_RATIO, -5.5f / PTM_RATIO),
        b2Vec2(17.0f / PTM_RATIO , 17.500 /PTM_RATIO)
    };
    shape2.Set(vertices2,num2);
    
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &shape;
    
    b2FixtureDef fixtureDef2;
    fixtureDef2.shape = &shape2;
    
    b2FixtureDef heroShapeDef;
    heroShapeDef.shape = &shape;
    heroShapeDef.density = densityconst;
    body->CreateFixture(&heroShapeDef);
    
    b2FixtureDef heroShapeDef2;
    heroShapeDef2.shape = &shape2;
    body->CreateFixture(&heroShapeDef2);
    
    //set constant velocity
    body->SetLinearVelocity(b2Vec2(velocityx, 0));
    
    //update position
    [self schedule:@selector(update:)];
    
    instance = self;
}

#pragma mark - Update

- (void) update:(ccTime)dt {
    
    //get actual velocity
    b2Vec2 vel = body->GetLinearVelocity();
    
    //NSLog(@"%f , %f", vel.x, vel.y);
    
    //set velocity.x to const value
    body->SetLinearVelocity(b2Vec2(velocityx, vel.y));

    position.x = body->GetPosition().x * PTM_RATIO;
    position.y = body->GetPosition().y * PTM_RATIO;

    //start the animation if hit the ground
    if (vel.y >= -0.05 && vel.y <= 0.05 && !animate)
    {
        [self startAnimation];
    }
    
    if (vel.x >= -0.41 && vel.x <= 0.001 && animate)
    {
        [self stopAnimation];
    }
}

#pragma mark - Jump methods

- (void) jump:(float)intensity {
    
    //set the force
    b2Vec2 force = b2Vec2(0, intensity);
    //apply the force
    body->ApplyLinearImpulse(force, body->GetPosition());
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"Sounds/jump.caf"];
    
    //stop the animation
    [self stopAnimation];
}

- (void) stopAnimation {
    [texture pauseActions];
    animate = NO;
}

- (void) startAnimation {
    [texture resumeActions];
    animate = YES;
}

#pragma mark - Dealloc

- (void) dealloc {
    
    body = NULL;
    
    instance = NULL;
    
    [super dealloc];
}

@end