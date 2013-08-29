//
//  ACDC.h
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 29/08/13.
//  Copyright 2013 Epimac. All rights reserved.
//
#import "Box2D.h"
#import "Tile.h"

@interface ACDCHelp : CCNode {
    CCSprite *texture;
    CGPoint position;
    b2Body *body;
    TypeCase type;
}

@property (nonatomic, readonly) CCSprite *texture;
@property (nonatomic, readwrite) b2Body *body;
@property (nonatomic, readwrite) TypeCase type;
@property (nonatomic, readwrite) CGPoint position;

+ (ACDCHelp *) acdcInstance;

+ (id) acdcWithPosition:(CGPoint)position_;

- (id) initWithPosition:(CGPoint)position_;

- (void) initPhysics;

- (void) hide;

- (void) show;

- (void) push;

@end
