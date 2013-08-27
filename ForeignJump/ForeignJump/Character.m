//
//  Character.m
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 25/08/13.
//  Copyright 2013 Epimac. All rights reserved.
//
#import "Character.h"

static NSString *name;
static enum CharCase type;

static NSString *heroTexture;
static NSString *heroPlist;

static NSString *ennemyTexture;
static NSString *ennemyPlist;

static NSString *map;
static NSString *mapTerre;
static NSString *mapSousTerre;
static NSString *mapObstacle;
static NSString *mapPiece;
static NSString *mapBomb;

static NSString *backgroundTexture;
static NSString *backgroundSun;

@implementation Character

+ (void) setCharacter:(NSString *)name_ andType:(enum CharCase)type_ andHeroTexture:(NSString *)heroTexture_ andHeroPlist:(NSString *)heroPlist_ andEnnemyTexture:(NSString *)ennemyTexture_ andEnnemyPlist:(NSString *)ennemyPlist_ andMap:(NSString *)map_ andMapTerre:(NSString *)mapTerre_ andMapSousTerre:(NSString *)mapSousTerre_ andMapObstacle:(NSString *)mapObstacle_ andMapPiece:(NSString *)mapPiece_ andMapBomb:(NSString *)mapBomb_ andBackground:(NSString *)background_ andBackgroundSun:(NSString *)backgroundSun_ {
    
    name = [NSString stringWithFormat:@"%@",name_];
    type = type_;
    
    heroTexture = [NSString stringWithFormat:@"%@",heroTexture_];
    heroPlist = [NSString stringWithFormat:@"%@",heroPlist_];
    
    ennemyTexture = [NSString stringWithFormat:@"%@",ennemyTexture_];
    ennemyPlist = [NSString stringWithFormat:@"%@",ennemyPlist_];
    
    map = [NSString stringWithFormat:@"%@",map_];
    mapTerre = [NSString stringWithFormat:@"%@",mapTerre_];
    mapSousTerre = [NSString stringWithFormat:@"%@",mapSousTerre_];
    mapObstacle = [NSString stringWithFormat:@"%@",mapObstacle_];
    mapPiece = [NSString stringWithFormat:@"%@",mapPiece_];
    mapBomb = [NSString stringWithFormat:@"%@",mapBomb_];
    backgroundTexture = [NSString stringWithFormat:@"%@",background_];
    backgroundSun = [NSString stringWithFormat:@"%@",backgroundSun_];
}

+ (void) resetCharacter {
    [name release];
    
    [heroTexture release];
    [heroPlist release];
    
    [ennemyTexture release];
    [ennemyPlist release];
    
    [map release];
    [mapTerre release];
    [mapSousTerre release];
    [mapObstacle release];
    [mapPiece release];
    [mapBomb release];

    [backgroundTexture release];
    [backgroundSun release];
}

+ (NSString *) name {
    return  name;
}

+ (enum CharCase) type {
    return  type;
}


+ (NSString *) heroTexture {
    return heroTexture;
}

+ (NSString *) heroPlist {
    return heroPlist;
}

+ (NSString *) ennemyTexture {
    return ennemyTexture;
}

+ (NSString *) ennemyPlist {
    return ennemyPlist;
}



+ (NSString *) map {
    return map;
}


+ (NSString *) mapTerre {
    return mapTerre;
}

+ (NSString *) mapSousTerre {
    return mapSousTerre;
}

+ (NSString *) mapObstacle {
    return mapObstacle;
}

+ (NSString *) mapPiece {
    return mapPiece;
}

+ (NSString *) mapBomb {
    return mapBomb;
}


+ (NSString *) backgroundTexture {
    return backgroundTexture;
}

+ (NSString *) backgroundSun {
    return backgroundSun;
}

@end
