//
//  MenuPause.m
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 27/08/13.
//  Copyright 2013 Epimac. All rights reserved.
//

#import "MenuPause.h"
#import "InGame.h"
#import "MainMenu.h"

@implementation MenuPause {
    CGSize size;
}

@synthesize volumeSlider = volumeSlider;

-(id) init {
	
    if( (self=[super init])) {
        size = [[CCDirector sharedDirector] winSize];
        
        //background
        background = [CCSprite spriteWithFile:@"Menu/Pause/pausemenubg.png"];
		[background setPosition:ccp(size.width/2, size.height/2)];
        
        [self addChild: background z: 0];
        //end background
        
        //main menu
        CCSprite *menuSprite = [CCSprite spriteWithFile:@"Menu/Pause/menu.png"];
        CCSprite *menuSpriteSelected = [CCSprite spriteWithFile:@"Menu/Pause/menu-selected.png"];
        CCSprite *playSprite = [CCSprite spriteWithFile:@"Menu/Pause/play.png"];
        CCSprite *playSpriteSelected = [CCSprite spriteWithFile:@"Menu/Pause/play-selected.png"];
        CCSprite *muteSprite = [CCSprite spriteWithFile:@"Menu/Options/mute.png"];
        [muteSprite setScale:0.5f];
        CCSprite *muteSprite2 = [CCSprite spriteWithFile:@"Menu/Options/mute.png"];
        [muteSprite2 setScale:0.5f];
        
        CCSprite *unMuteSprite = [CCSprite spriteWithFile:@"Menu/Options/unmute.png"];
        [unMuteSprite setScale:0.5f];
        CCSprite *unMuteSprite2 = [CCSprite spriteWithFile:@"Menu/Options/unmute.png"];
        [unMuteSprite2 setScale:0.5f];
        
        CCMenuItemSprite *menuItem = [CCMenuItemSprite itemWithNormalSprite:menuSprite selectedSprite:menuSpriteSelected target:self selector:@selector(goToMenu)];
        CCMenuItemSprite *playItem = [CCMenuItemSprite itemWithNormalSprite:playSprite selectedSprite:playSpriteSelected target:self selector:@selector(pauseAll)];
        
        menu = [CCMenu menuWithItems:menuItem, playItem, nil];
        [menu alignItemsVertically];
        [menu setPosition:ccp(size.width/2, size.height/2 - 20)];
        
        [self addChild:menu];
        //end menu
        
        
        //volume slider
        volumeSlider = [[UISlider alloc] initWithFrame:CGRectMake(size.width/2 - 75, size.height/2 + 100, 150, 50)];
        [volumeSlider setMaximumValue:100];
        [volumeSlider setMinimumValue:0];
        [volumeSlider setValue:([[SimpleAudioEngine sharedEngine] effectsVolume] * 100)];
        
        [[[CCDirector sharedDirector] view] addSubview:volumeSlider];
        [volumeSlider setHidden:YES];
        
    }
	return self;
}

- (void) pauseAll {
    [InGame pauseAll];
}

- (void) goToMenu {
    [InGame pauseAll];
    [[CCDirector sharedDirector] replaceScene:[MainMenu scene]];
}

- (void) update:(ccTime)delta {
    [[SimpleAudioEngine sharedEngine] setEffectsVolume:([volumeSlider value] / 100)];
    [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:([volumeSlider value] / 100)];
}

- (void) dealloc {
    [volumeSlider removeFromSuperview];
    [volumeSlider release];
    [self unscheduleUpdate];
    
    [super dealloc];
}


@end
