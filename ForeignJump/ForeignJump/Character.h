//
//  Character.h
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 25/08/13.
//  Copyright 2013 Epimac. All rights reserved.
//

enum CharCase {
    Roumain = 1,
    Indien = 2,
    Renoi = 3,
    Reunionnais = 4
};

@interface Character : NSObject 

+ (void) setCharacter:(NSString *)name_ andType:(enum CharCase)type_ andHeroTexture:(NSString *)heroTexture_ andHeroPlist:(NSString *)heroPlist_ andEnnemyTexture:(NSString *)ennemyTexture_ andEnnemyPlist:(NSString *)ennemyPlist_ andMap:(NSString *)map_ andMapTerre:(NSString *)mapTerre_ andMapSousTerre:(NSString *)mapSousTerre_ andMapObstacle:(NSString *)mapObstacle_ andMapPiece:(NSString *)mapPiece_ andMapBomb:(NSString *)mapBomb_ andBackground:(NSString *)background_ andBackgroundSun:(NSString *)backgroundSun_;

+ (NSString *) name;

+ (enum CharCase) type;

+ (NSString *) heroTexture;

+ (NSString *) heroPlist;

+ (NSString *) ennemyTexture;

+ (NSString *) ennemyPlist;


+ (NSString *) map;


+ (NSString *) mapTerre;

+ (NSString *) mapSousTerre;

+ (NSString *) mapObstacle;

+ (NSString *) mapPiece;

+ (NSString *) mapBomb;


+ (NSString *) backgroundTexture;

+ (NSString *) backgroundSun;

@end
