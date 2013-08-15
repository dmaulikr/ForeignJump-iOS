//
//  Hero.m
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 29/07/13.
//  Copyright (c) 2013 Epimac. All rights reserved.
//
#import "Hero.h"

#pragma mark - Constant declaration
static const float densityconst = 1.85f;
static const float velocityx = 4;

@implementation Hero {
    BOOL animate;
    CCAction *walkAction;
    float delta;
    b2World* world_;
}

#pragma mark - synthesize
@synthesize texture;
@synthesize body;
@synthesize type;
@synthesize position;

#pragma mark - Init methods

-(id)init
{
    if ((self = [super init]))
    {
        [self initWithPosition:ccp(90,280)];
        
        CCSpriteBatchNode* spriteSheet = [self initWithPlist:@"Hero/hero.plist" andTexture:@"Hero/hero.png"];
        
        [self addChild:spriteSheet];
        
        [self initByAddingSprite:spriteSheet];
        
    }
    return self;
}

-(id)initWithPosition:(CGPoint)position_ {
    
    position = position_;
    
    animate = YES;
    
    type = HeroType;
    
    return self;
}

-(CCSpriteBatchNode*)initWithPlist:(NSString *)plist andTexture:(NSString *)texture_ {
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:plist];
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:texture_];
    
    return spriteSheet;
}

- (void)initByAddingSprite:(CCSpriteBatchNode*) spriteSheet {
    
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
    
    texture.position = position;
    texture.tag = 11;
    [spriteSheet addChild:texture];
}

-(void) initPhysics:(b2World*)world
{
    world_ = world;
    
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
}

#pragma mark - Update

- (void) update:(ccTime)dt {
    
    world_->Step(dt, 60, 60);
    for(b2Body *b = world_->GetBodyList(); b; b=b->GetNext()) {
        
        if (b->GetUserData() != NULL) {
            CCSprite *data = (CCSprite*)b->GetUserData();
            data.position =ccp(b->GetPosition().x * PTM_RATIO,
                               b->GetPosition().y * PTM_RATIO);
        }
    }
    
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
    //stop the animation
    
    [self stopAnimation];
}

- (void)stopAnimation {
    [texture pauseActions];
    animate = NO;
}

- (void)startAnimation {
    animate = YES;
    [texture resumeActions];
}

#pragma mark - Dealloc

-(void)dealloc {
    
    body = NULL;
    
    [super dealloc];
}

@end