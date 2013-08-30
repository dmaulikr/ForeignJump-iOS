//
//  Tile.m
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 27/07/13.
//  Copyright (c) 2013 Epimac. All rights reserved.
//

#import "Tile.h"
#import "InGame.h"

static const float bombRadius = 0.39f;
static const float coinRadius = 0.39f;

@implementation Tile
{
    b2World *world;
}

#pragma mark - synthesize
@synthesize texture;
@synthesize type;
@synthesize position;

#pragma mark - Init method
+ (id) tileWithSpriteFile:(NSString *)texture_ andType:(TypeCase)type_ atPosition:(CGPoint)position_ {
    return [[[Tile alloc] initWithSpriteFile:texture_ andType:type_ atPosition:position_ ] autorelease];
}

- (id) initWithSpriteFile:(NSString *)texture_ andType:(TypeCase)type_ atPosition:(CGPoint)position_ {
    
    if( (self=[super init])) {

        position = position_;
    
        texture = [CCSprite spriteWithFile:texture_];
    
        [texture setPosition:position];
    
        type = type_;
    
        world = [InGame getWorld];
    
        [texture setTag:type];
        
        switch (type) {
            case Terre:
            {
                [self createPhysicsTerre];
                break;
            }
            case Obstacle:
            {
                [self createPhysicsTerre];
                break;
            }
            case Sousterre:
            {
                //[self createPhysicsTerre];
                break;
            }
            case Piece:
            {
                [self createPhysicsCoin];
                break;
            }
            case Bombe:
            {
                [self createPhysicsBomb];
                break;
            }
            case ACDC:
            {
                [self createPhysicsCoin];
                break;
            }
            
            default:
            {
                break;
            }
        }
    }
    return self;
}

#pragma mark - Init Physics

- (void) createPhysicsTerre {
    // Create block body
    b2BodyDef blockBodyDef;
    blockBodyDef.type = b2_staticBody;
    blockBodyDef.position.Set(position.x/PTM_RATIO, position.y/PTM_RATIO);
    b2Body *body = world ->CreateBody(&blockBodyDef);
    body->SetUserData(texture);
    
    
    // Create block shape
    b2PolygonShape blockShape;
    blockShape.SetAsBox(12.5/PTM_RATIO,
                        12.5/PTM_RATIO);
    
    // Create shape definition and add to body
    b2FixtureDef blockShapeDef;
    blockShapeDef.shape = &blockShape;
    blockShapeDef.friction = 0.0f;
    blockShapeDef.restitution = 0.2f;
    body->CreateFixture(&blockShapeDef);
}

- (void) createPhysicsCoin {
    //create body
    b2BodyDef spriteBodyDef;
    spriteBodyDef.type = b2_staticBody;
    spriteBodyDef.position.Set(position.x/PTM_RATIO, position.y/PTM_RATIO);
    b2Body *body = world ->CreateBody(&spriteBodyDef);
    body->SetUserData(texture);
    
    //create circular shape
    b2CircleShape spriteShape;
    spriteShape.m_radius = coinRadius;
    
    //create shape definition and add it to the body
    b2FixtureDef spriteShapeDef;
    spriteShapeDef.shape = &spriteShape;
    spriteShapeDef.isSensor = true;
    body->CreateFixture(&spriteShapeDef);
}

- (void) createPhysicsBomb {
    //create body
    b2BodyDef spriteBodyDef;
    spriteBodyDef.type = b2_staticBody;
    spriteBodyDef.position.Set(position.x/PTM_RATIO, position.y/PTM_RATIO);
    b2Body *body = world ->CreateBody(&spriteBodyDef);
    body->SetUserData(texture);
    
    //create circular shape
    b2CircleShape spriteShape;
    spriteShape.m_radius = bombRadius;
    
    //create shape definition and add it to the body
    b2FixtureDef spriteShapeDef;
    spriteShapeDef.shape = &spriteShape;
    spriteShapeDef.isSensor = true;
    body->CreateFixture(&spriteShapeDef);
}
@end
