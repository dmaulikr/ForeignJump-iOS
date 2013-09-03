//
//  MainMenu.m
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 20/08/13.
//  Copyright 2013 Epimac. All rights reserved.
//
#import "MainMenu.h"
#import "MenuChoose.h"
#import "MenuOptions.h"
#import "Data.h"
#import "Tutorial.h"

@implementation MainMenu {

}

CGSize size;
Tutorial *tutorialLayer;

+ (CCScene *) scene
{
    size = [[CCDirector sharedDirector] winSize];
    
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
    tutorialLayer = [Tutorial node];
    [scene addChild: tutorialLayer z:1];
    
    // add menu layer
	MainMenu *layer = [MainMenu node];
	[scene addChild: layer z:0];
    
	// return the scene
	return scene;
}

- (id) init {
    
   	if( (self = [super init])) {
        
        //background
        CCSprite *background = [CCSprite spriteWithFile:@"Menu/menubg.png"];
        [background setPosition:ccp(size.width/2, size.height/2)];
        
        [self addChild:background z:0];
        //end background
        
        //main menu
        CCSprite *helpSprite = [CCSprite spriteWithFile:@"Menu/help.png"];
        CCSprite *optionsSprite = [CCSprite spriteWithFile:@"Menu/options.png"];
        CCSprite *playSprite = [CCSprite spriteWithFile:@"Menu/play.png"];
        CCSprite *helpSpriteSelected = [CCSprite spriteWithFile:@"Menu/help-selected.png"];
        CCSprite *optionsSpriteSelected = [CCSprite spriteWithFile:@"Menu/options-selected.png"];
        CCSprite *playSpriteSelected = [CCSprite spriteWithFile:@"Menu/play-selected.png"];

        CCMenuItemSprite *help = [CCMenuItemSprite itemWithNormalSprite:helpSprite selectedSprite:helpSpriteSelected target:self selector:@selector(goToGame)];
        CCMenuItemSprite *options = [CCMenuItemSprite itemWithNormalSprite:optionsSprite selectedSprite:optionsSpriteSelected target:self selector:@selector(goToOptions)];
        CCMenuItemSprite *start = [CCMenuItemSprite itemWithNormalSprite:playSprite selectedSprite:playSpriteSelected target:self selector:@selector(goToGame)];
        
        menu = [CCMenu menuWithItems:options, start, help, nil];
        [menu alignItemsHorizontally];
        [menu setPosition:ccp(size.width/2, size.height/2 - 85)];
        
        [self addChild:menu];
        //end menu
        
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"Sounds/ok.caf"];
//        [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"Sounds/menuMusic.mp3"];
        
//        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Sounds/menuMusic.mp3" loop:YES];
        
        
        if (![Data isNotFirstTime]) {
            [tutorialLayer setVisible:NO];
        }
        else
        {
            [tutorialLayer setVisible:YES];
        }

    }
    return self;
}

- (void) goToGame {
    [[SimpleAudioEngine sharedEngine] playEffect:@"Sounds/ok.caf"];
    [[CCDirector sharedDirector] replaceScene:[MenuChoose scene]];
}

- (void) goToOptions {
    [[SimpleAudioEngine sharedEngine] playEffect:@"Sounds/ok.caf"];
    [[CCDirector sharedDirector] replaceScene:[MenuOptions scene]];
}

- (void) dealloc {
    
    [super dealloc];
}

@end
