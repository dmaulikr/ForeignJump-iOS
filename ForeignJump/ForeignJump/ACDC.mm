//
//  ACDC.m
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 29/08/13.
//  Copyright 2013 Epimac. All rights reserved.
//

#import "ACDC.h"
#import "InGame.h"
#import "Ennemy.h"

//only one Hero instance per game
static ACDCHelp *instance;

@implementation ACDCHelp {
    float delta;
    b2World *world;
    b2Vec2 velocity;
    Hero *hero;
}

@synthesize position;
@synthesize texture;
@synthesize type;
@synthesize body;

+ (ACDCHelp *) acdcInstance {
    return instance;
}

+ (id) acdcWithPosition:(CGPoint)position_ {
    return [[[ACDCHelp alloc] initWithPosition:position_] autorelease];
}

- (id) initWithPosition:(CGPoint)position_ {
    if ((self = [super init]))
    {
        position = position_;
        
        type = ACDCType;
        
        texture = [CCSprite spriteWithFile:@"Perso/acdc.png"];
        [texture setFlipX:YES];
        [texture setPosition:position];
        [texture setTag:ACDCType];
        [texture setVisible:NO];
        [self addChild:texture];
        
        hero = [Hero heroInstance];
        
        instance = self;
    }
    return self;
}

-(void) initPhysics {
    world = [InGame getWorld];
    
    // Create ennemy body and shape
    b2BodyDef acdcBodyDef;
    acdcBodyDef.fixedRotation = true;
    acdcBodyDef.type = b2_dynamicBody;
    acdcBodyDef.position.Set(position.x/PTM_RATIO, position.y/PTM_RATIO);
    body = world->CreateBody(&acdcBodyDef);
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
    
    b2FixtureDef acdcShapeDef;
    acdcShapeDef.shape = &shape;
    body->CreateFixture(&acdcShapeDef);
    
    b2FixtureDef ennemyShapeDef2;
    ennemyShapeDef2.shape = &shape2;
    body->CreateFixture(&ennemyShapeDef2);
    
    velocity = hero.body->GetLinearVelocity();
    
    //set constant velocity
    body->SetLinearVelocity(velocity);
    body->SetActive(NO);

    //update position
    [self schedule:@selector(update:)];
}

- (void) update:(ccTime)dt {
    
    //NSLog(@"%f , %f", vel.x, vel.y);
    
    //set velocity.x to const value
    body->SetLinearVelocity(b2Vec2_zero);
    
    CGPoint heroPos = hero.position;
    b2Vec2 newPos = b2Vec2((heroPos.x - hero.texture.width - 2) / PTM_RATIO, (heroPos.y + 10)/ PTM_RATIO);
    
    body->SetTransform(newPos, 0);
    
    position.x = body->GetPosition().x * PTM_RATIO;
    position.y = body->GetPosition().y * PTM_RATIO;
}

- (void) hide {
    instance.body->SetActive(NO);
    [instance.texture setVisible:NO];
}

- (void) show {
    instance.body->SetActive(YES);
    [instance.texture setVisible:YES];
}

- (void) push {
    Ennemy *ennemy = [Ennemy ennemyInstance];
    b2Body *ennemyBody = ennemy.body;
    ennemy.body->ApplyLinearImpulse(b2Vec2(-500, 0), ennemyBody->GetPosition());
}


- (void) dealloc {
    
    world->DestroyBody(body);
    body = NULL;
    
    instance = NULL;
    
    [super dealloc];
}


@end
