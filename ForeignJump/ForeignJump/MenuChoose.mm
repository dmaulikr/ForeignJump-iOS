//
//  MenuChoose.m
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 25/08/13.
//  Copyright 2013 Epimac. All rights reserved.
//
#import "MenuChoose.h"
#import "InGame.h"
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
        CCSprite *background = [CCSprite spriteWithFile:@"Menu/Choose/menubg.png"];
        [background setPosition:ccp(winSize.width/2, winSize.height/2)];

        [self addChild:background z:0];
        //end background
        
        //menu
        
        //sprites
        CCSprite *roumainChar = [CCSprite spriteWithFile:@"Menu/Choose/roumain.png"];
        CCSprite *roumainChar2 = [CCSprite spriteWithFile:@"Menu/Choose/roumain.png"];
        [roumainChar2 setColor:ccc3(100,100,100)];
        
        
        CCSprite *indienChar = [CCSprite spriteWithFile:@"Menu/Choose/indien.png"];
        CCSprite *indienChar2 = [CCSprite spriteWithFile:@"Menu/Choose/indien.png"];
        [indienChar2 setColor:ccc3(100,100,100)];
        
        CCSprite *renoiChar = [CCSprite spriteWithFile:@"Menu/Choose/renoi.png"];
        CCSprite *renoiChar2 = [CCSprite spriteWithFile:@"Menu/Choose/renoi.png"];
        [renoiChar2 setColor:ccc3(100,100,100)];
        
        CCSprite *reunionnaisChar = [CCSprite spriteWithFile:@"Menu/Choose/reunionnais.png"];
        CCSprite *reunionnaisChar2 = [CCSprite spriteWithFile:@"Menu/Choose/reunionnais.png"];
        [reunionnaisChar2 setColor:ccc3(100,100,100)];
        
        //menuItems
        CCMenuItemSprite *roumain = [CCMenuItemSprite itemWithNormalSprite:roumainChar selectedSprite:roumainChar2 target:self selector:@selector(goToGame:)];
        [roumain setTag:Roumain];
        
        CCMenuItemSprite *indien = [CCMenuItemSprite itemWithNormalSprite:indienChar selectedSprite:indienChar2 target:self selector:@selector(goToGame:)];
        [indien setTag:Indien];
        
        CCMenuItemSprite *renoi = [CCMenuItemSprite itemWithNormalSprite:renoiChar selectedSprite:renoiChar2 target:self selector:@selector(goToGame:)];
        [renoi setTag:Renoi];
        
        CCMenuItemSprite *reunionnais = [CCMenuItemSprite itemWithNormalSprite:reunionnaisChar selectedSprite:reunionnaisChar2 target:self selector:@selector(goToGame:)];
        [reunionnais setTag:Reunionnais];
        
        menu = [CCMenu menuWithItems:roumain, indien, renoi, reunionnais, nil];
        [menu alignItemsHorizontallyWithPadding:25];
        [menu setPosition:ccp(winSize.width/2, winSize.height/2 - 40)];

        [self addChild:menu];
        //end menu
        
        //back menu
        CCSprite *backSprite = [CCSprite spriteWithFile:@"Menu/Choose/back.png"];
        CCSprite *backSpriteSelected = [CCSprite spriteWithFile:@"Menu/Choose/back-selected.png"];
        
        CCMenuItemSprite *back = [CCMenuItemSprite itemWithNormalSprite:backSprite selectedSprite:backSpriteSelected target:self selector:@selector(backToMenu)];
        [back setPosition:ccp(30,30)];
        
        CCMenu *backMenu = [CCMenu menuWithItems:back, nil];
        [backMenu setPosition:ccp(0,0)];
        
        [self addChild:backMenu];
        //end back menu
    }
    return self;
}

- (void) backToMenu {
    [[SimpleAudioEngine sharedEngine] playEffect:@"Sounds/ok.caf"];
    [[CCDirector sharedDirector] replaceScene:[MainMenu scene]];
}

- (void) goToGame:(CCMenuItemSprite *)sender_ {
    [[SimpleAudioEngine sharedEngine] playEffect:@"Sounds/ok.caf"];
    CCMenuItemSprite *sender = sender_;
    
    switch (sender.tag) {
        case Roumain:
        {
            [Character setCharacter:@"Andrei" andType:Roumain andHeroTexture:@"Perso/Roumain/Hero/Roumain_hero.png" andHeroPlist:@"Perso/Roumain/Hero/Roumain_hero.plist" andEnnemyTexture:@"Perso/Roumain/Ennemy/Roumain_ennemy.png" andEnnemyPlist:@"Perso/Roumain/Ennemy/Roumain_ennemy.plist" andMap:@"Perso/Roumain/Map/Roumain_map.txt" andMapTerre:@"Perso/Roumain/Map/Roumain_terre.png" andMapSousTerre:@"Perso/Roumain/Map/Roumain_sousterre.png" andMapObstacle:@"Perso/Roumain/Map/Roumain_obstacle.png" andMapPiece:@"Perso/Roumain/Map/Roumain_piece.png" andMapBomb:@"Perso/Roumain/Map/Roumain_bomb.png" andBackground:@"Perso/Roumain/Background/Roumain_bg.png" andBackgroundSun:@"Perso/Roumain/Background/Roumain_sun.png"];
            break;
        }
        case Reunionnais:
        {
            [Character setCharacter:@"Andrei" andType:Reunionnais andHeroTexture:@"Perso/Reunionnais/Hero/Reunionnais_hero.png" andHeroPlist:@"Perso/Reunionnais/Hero/Reunionnais_hero.plist" andEnnemyTexture:@"Perso/Reunionnais/Ennemy/Reunionnais_ennemy.png" andEnnemyPlist:@"Perso/Reunionnais/Ennemy/Reunionnais_ennemy.plist" andMap:@"Perso/Reunionnais/Map/Reunionnais_map.txt" andMapTerre:@"Perso/Reunionnais/Map/Reunionnais_terre.png" andMapSousTerre:@"Perso/Reunionnais/Map/Reunionnais_sousterre.png" andMapObstacle:@"Perso/Reunionnais/Map/Reunionnais_obstacle.png" andMapPiece:@"Perso/Reunionnais/Map/Reunionnais_piece.png" andMapBomb:@"Perso/Reunionnais/Map/Reunionnais_bomb.png" andBackground:@"Perso/Reunionnais/Background/Reunionnais_bg.png" andBackgroundSun:@"Perso/Reunionnais/Background/Reunionnais_sun.png"];
            break;
        }
        case Renoi:
        {
            [Character setCharacter:@"Andrei" andType:Renoi andHeroTexture:@"Perso/Renoi/Hero/Renoi_hero.png" andHeroPlist:@"Perso/Renoi/Hero/Renoi_hero.plist" andEnnemyTexture:@"Perso/Renoi/Ennemy/Renoi_ennemy.png" andEnnemyPlist:@"Perso/Renoi/Ennemy/Renoi_ennemy.plist" andMap:@"Perso/Renoi/Map/Renoi_map.txt" andMapTerre:@"Perso/Renoi/Map/Renoi_terre.png" andMapSousTerre:@"Perso/Renoi/Map/Renoi_sousterre.png" andMapObstacle:@"Perso/Renoi/Map/Renoi_obstacle.png" andMapPiece:@"Perso/Renoi/Map/Renoi_piece.png" andMapBomb:@"Perso/Renoi/Map/Renoi_bomb.png" andBackground:@"Perso/Renoi/Background/Renoi_bg.png" andBackgroundSun:@"Perso/Renoi/Background/Renoi_sun.png"];
            break;
        }
        case Indien:
        {
            [Character setCharacter:@"Rajesh" andType:Indien andHeroTexture:@"Perso/Indien/Hero/Indien_hero.png" andHeroPlist:@"Perso/Indien/Hero/Indien_hero.plist" andEnnemyTexture:@"Perso/Indien/Ennemy/Indien_ennemy.png" andEnnemyPlist:@"Perso/Indien/Ennemy/Indien_ennemy.plist" andMap:@"Perso/Indien/Map/Indien_map.txt" andMapTerre:@"Perso/Indien/Map/Indien_terre.png" andMapSousTerre:@"Perso/Indien/Map/Indien_sousterre.png" andMapObstacle:@"Perso/Indien/Map/Indien_obstacle.png" andMapPiece:@"Perso/Indien/Map/Indien_piece.png" andMapBomb:@"Perso/Indien/Map/Indien_bomb.png" andBackground:@"Perso/Indien/Background/Indien_bg.png" andBackgroundSun:@"Perso/Indien/Background/Indien_sun.png"];
            break;
        }
        default:
        {
            NSAssert(false, @"Character sender tag is wrong.");
            break;
        }
    }
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0f scene:[InGame scene]]];
}

- (void) dealloc {
    
    [super dealloc];
}

@end