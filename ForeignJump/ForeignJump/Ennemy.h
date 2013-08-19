//
//  Ennemy.h
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 29/07/13.
//  Copyright (c) 2013 Epimac. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Box2D.h"
#import "Tile.h"
#import "Hero.h"

@interface Ennemy : CCNode {
    CCSprite *texture;
    CGPoint position;
    b2Body *body;
    TypeCase type;
}

@property (nonatomic, readonly) CCSprite *texture;
@property (nonatomic, readwrite) b2Body *body;
@property (nonatomic, readwrite) TypeCase type;

+ (Ennemy *) ennemyInstance;

+ (id) ennemyWithPosition:(CGPoint)position_;

- (id) initWithPosition:(CGPoint)position_;

- (void) initSprite:(NSString *)plist andTexture:(NSString *)texture_;

- (void) initPhysics;

- (void) stopAnimation;

- (void) startAnimation;

- (void) jump:(float)intensity;

@end

