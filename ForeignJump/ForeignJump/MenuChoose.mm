//
//  MenuChoose.m
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 25/08/13.
//  Copyright 2013 Epimac. All rights reserved.
//

#import "MenuChoose.h"
#import "InGame.h"
#import "Character.h"
#import "MainMenu.h"

@implementation MenuChoose {

}

CGSize winSize;

+ (CCScene *) scene
{
    winSize = [[CCDirector sharedDirector] winSize];
    
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
    // add game layer
	MenuChoose *layer = [MenuChoose node];
	[scene addChild: layer z:2];
    
	// return the scene
	return scene;
}

- (id) init {
    
   	if( (self = [super init])) {
        
        //background
        CCSprite *background = [CCSprite spriteWithFile:@"Menu/menuchoosebg.png"];
        background.position = ccp(winSize.width/2, winSize.height/2);
        
        [self addChild:background z:0];
        //end background
        
        CCSprite *roumainChar = [CCSprite spriteWithFile:@"Menu/Choose/roumain.png"];
        CCSprite *indienChar = [CCSprite spriteWithFile:@"Menu/Choose/indien.png"];
        CCSprite *renoiChar = [CCSprite spriteWithFile:@"Menu/Choose/renoi.png"];
        CCSprite *reunionnaisChar = [CCSprite spriteWithFile:@"Menu/Choose/reunionnais.png"];
        CCSprite *roumainChar2 = [CCSprite spriteWithFile:@"Menu/Choose/roumain.png"];
        CCSprite *indienChar2 = [CCSprite spriteWithFile:@"Menu/Choose/indien.png"];
        CCSprite *renoiChar2 = [CCSprite spriteWithFile:@"Menu/Choose/renoi.png"];
        CCSprite *reunionnaisChar2 = [CCSprite spriteWithFile:@"Menu/Choose/reunionnais.png"];
        
        CCMenuItemSprite *roumain = [CCMenuItemSprite itemWithNormalSprite:roumainChar selectedSprite:roumainChar2 target:self selector:@selector(goToGame:)];
        roumain.tag = Roumain;
        CCMenuItemSprite *indien = [CCMenuItemSprite itemWithNormalSprite:indienChar selectedSprite:indienChar2 target:self selector:@selector(goToGame:)];
        indien.tag = Indien;
        CCMenuItemSprite *renoi = [CCMenuItemSprite itemWithNormalSprite:renoiChar selectedSprite:renoiChar2 target:self selector:@selector(goToGame:)];
        renoi.tag = Renoi;
        CCMenuItemSprite *reunionnais = [CCMenuItemSprite itemWithNormalSprite:reunionnaisChar selectedSprite:reunionnaisChar2 target:self selector:@selector(goToGame:)];
        reunionnais.tag = Reunionnais;
        
        
        menu = [CCMenu menuWithItems:roumain, indien, renoi, reunionnais, nil];
        [menu alignItemsHorizontallyWithPadding:25];
        menu.position = ccp(winSize.width/2, winSize.height/2 - 40);
        
        [self addChild:menu];
    }
    return self;
}

- (void) goToGame:(CCMenuItemSprite *)sender_ {
    CCMenuItemSprite *sender = sender_;
    
    switch (sender.tag) {
        case Roumain:
        {
            [Character setCharacter:@"Andrei" andType:Roumain andHeroTexture:@"Roumain_hero.png" andHeroPlist:@"Roumain_hero.plist" andEnnemyTexture:@"Roumain_ennemy.png" andEnnemyPlist:@"Roumain_ennemy.plist" andMap:@"Roumain_map.txt" andMapTerre:@"Roumain_terre.png" andMapSousTerre:@"Roumain_sousterre.png" andMapObstacle:@"Roumain_obstacle.png" andMapPiece:@"Roumain_piece.png" andMapBomb:@"Roumain_bomb.png" andBackground:@"Roumain_bg.png" andBackgroundSun:@"Roumain_sun.png"];
            break;
        }
        case Reunionnais:
        {
            [Character setCharacter:@"Andrei" andType:Reunionnais andHeroTexture:@"Reunionnais_hero.png" andHeroPlist:@"Reunionnais_hero.plist" andEnnemyTexture:@"Reunionnais_ennemy.png" andEnnemyPlist:@"Reunionnais_ennemy.plist" andMap:@"Reunionnais_map.txt" andMapTerre:@"Reunionnais_terre.png" andMapSousTerre:@"Reunionnais_sousterre.png" andMapObstacle:@"Reunionnais_obstacle.png" andMapPiece:@"Reunionnais_piece.png" andMapBomb:@"Reunionnais_bomb.png" andBackground:@"Reunionnais_bg.png" andBackgroundSun:@"Reunionnais_sun.png"];
            break;
        }
        case Renoi:
        {
            [Character setCharacter:@"Andrei" andType:Renoi andHeroTexture:@"Renoi_hero.png" andHeroPlist:@"Renoi_hero.plist" andEnnemyTexture:@"Renoi_ennemy.png" andEnnemyPlist:@"Renoi_ennemy.plist" andMap:@"Renoi_map.txt" andMapTerre:@"Renoi_terre.png" andMapSousTerre:@"Renoi_sousterre.png" andMapObstacle:@"Renoi_obstacle.png" andMapPiece:@"Renoi_piece.png" andMapBomb:@"Renoi_bomb.png" andBackground:@"Renoi_bg.png" andBackgroundSun:@"Renoi_sun.png"];
            break;
        }
        case Indien:
        {
            [Character setCharacter:@"Andrei" andType:Indien andHeroTexture:@"Indien_hero.png" andHeroPlist:@"Indien_hero.plist" andEnnemyTexture:@"Indien_ennemy.png" andEnnemyPlist:@"Indien_ennemy.plist" andMap:@"Indien_map.txt" andMapTerre:@"Indien_terre.png" andMapSousTerre:@"Indien_sousterre.png" andMapObstacle:@"Indien_obstacle.png" andMapPiece:@"Indien_piece.png" andMapBomb:@"Indien_bomb.png" andBackground:@"Indien_bg.png" andBackgroundSun:@"Indien_sun.png"];
            break;
        }
        default:
        {
            NSLog(@"Character sender tag is wrong.");
            break;
        }
    }
    
    [[CCDirector sharedDirector] replaceScene:[InGame scene]];
}


- (void) dealloc {
    
    [super dealloc];
}

@end