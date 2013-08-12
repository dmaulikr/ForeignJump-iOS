//
//  Hero.h
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 29/07/13.
//  Copyright (c) 2013 Epimac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "Tile.h"

@interface Hero : CCLayer {
    CCSprite * sprite;
    CGPoint position;
    b2Body* body;
    b2World* world_;
    TypeCase type;
}

@property (nonatomic, readonly) CCSprite* sprite;
@property (nonatomic, readwrite) b2Body* body;
@property (nonatomic, readwrite) TypeCase type;

- (id)initWithPosition:(CGPoint)position_;

- (CCSpriteBatchNode *)initWithPlist:(NSString *)plist andTexture:(NSString *)texture;

- (void) initByAddingSprite:(CCSpriteBatchNode*) spriteSheets;

- (void) initPhysics:(b2World*)world;

- (void) stopAnimation;

- (void) startAnimation;

- (void) jump:(float)intensity;

@end

