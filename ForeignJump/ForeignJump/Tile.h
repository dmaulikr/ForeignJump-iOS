//
//  Tile.h
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 27/07/13.
//  Copyright (c) 2013 Epimac. All rights reserved.
//
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
    Superman = 11,
    HeroType = 12,
    EnnemyType = 13,
    ACDCType = 14
    };

@interface Tile : CCNode {
    CCSprite *texture;
    TypeCase type;
    CGPoint position;
}

@property (nonatomic, retain) CCSprite *texture;
@property (nonatomic, readwrite) TypeCase type;
@property (nonatomic, readwrite) CGPoint position;

+ (id) tileWithSpriteFile:(NSString *)texture_ andType:(TypeCase)type_ atPosition:(CGPoint)position_;

- (id) initWithSpriteFile:(NSString *)texture_ andType:(TypeCase)type_ atPosition:(CGPoint)position_;

@end
