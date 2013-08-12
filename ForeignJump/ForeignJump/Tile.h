//
//  Tile.h
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 27/07/13.
//  Copyright (c) 2013 Epimac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

enum TypeCase {
    Terre = 1,
    Sousterre = 2,
    Eau = 3,
    Null = 4,
    Piece = 5,
    Bonus = 6,
    Obstacle = 7,
    AvanceRapide = 8,
    Bombe = 9,
    ACDC = 10,
    HeroType = 11,
    Ennemi = 12
    };

@interface Tile : CCNode
{
    CCSprite* texture;
    enum TypeCase type;
    CGPoint position;
}

@property (nonatomic, retain) CCSprite* texture;
@property (nonatomic, readwrite) enum TypeCase type;
@property (nonatomic, readwrite) CGPoint position;

-(void) initWithSpriteFile:(NSString*)texture_ andType:(TypeCase)type_ atPosition:(CGPoint)position_ andWorld:(b2World*)world_;

@end
