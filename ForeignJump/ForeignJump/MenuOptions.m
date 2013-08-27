//
//  MenuOptions.m
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 27/08/13.
//  Copyright 2013 Epimac. All rights reserved.
//
#import "MenuOptions.h"
#import "MainMenu.h"

@implementation MenuOptions {
    CGSize size;
    UISlider *volumeSlider;
}

+ (CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
    // add game layer
	MenuOptions *layer = [MenuOptions node];
	[scene addChild: layer z:2];
    
	// return the scene
	return scene;
}

- (id) init {
    
   	if( (self = [super init])) {
        
        size = [[CCDirector sharedDirector] winSize];
        
        //background
        CCSprite *background = [CCSprite spriteWithFile:@"Menu/Options/menubg.png"];
        [background setPosition:ccp(size.width/2, size.height/2)];
        
        [self addChild:background z:0];
        //end background
        
        //menu
        CCSprite *muteSprite = [CCSprite spriteWithFile:@"Menu/Options/mute.png"];
        CCSprite *muteSprite2 = [CCSprite spriteWithFile:@"Menu/Options/mute.png"];
        [muteSprite2 setColor:ccc3(255, 255, 255)];
        
        CCSprite *unMuteSprite = [CCSprite spriteWithFile:@"Menu/Options/unmute.png"];
        CCSprite *unMuteSprite2 = [CCSprite spriteWithFile:@"Menu/Options/unmute.png"];
        [unMuteSprite2 setColor:ccc3(255, 255, 255)];

        CCMenuItemSprite *muteItem = [CCMenuItemSprite itemWithNormalSprite:muteSprite selectedSprite:muteSprite2 target:nil selector:nil];
        CCMenuItemSprite *unMuteItem = [CCMenuItemSprite itemWithNormalSprite:unMuteSprite selectedSprite:unMuteSprite2 target:nil selector:nil];
        
        CCMenuItemToggle *sound;
        
        if ([[SimpleAudioEngine sharedEngine] mute])
        {
            sound = [CCMenuItemToggle itemWithTarget:self selector:@selector(mute) items: muteItem,unMuteItem, nil];
        }
        else
        {
            sound = [CCMenuItemToggle itemWithTarget:self selector:@selector(mute) items: unMuteItem,muteItem, nil];
        }
        
        menu = [CCMenu menuWithItems: sound,nil];
        [menu alignItemsHorizontallyWithPadding:25];
        [menu setPosition:ccp(size.width/2, size.height/2 - 20)];
        
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
        
        float vol = [[SimpleAudioEngine sharedEngine] effectsVolume];
        NSLog(@"%f", vol);
        
        //volume slider
        volumeSlider = [[UISlider alloc] initWithFrame:CGRectMake(size.width/2 - 75, size.height/2 + 60, 150, 50)];
        [volumeSlider setMaximumValue:100];
        [volumeSlider setMinimumValue:0];
        [volumeSlider setValue:(vol * 100)];
        
        [[[CCDirector sharedDirector] view] addSubview:volumeSlider];
        
        [self scheduleUpdate];
        //volume slider
    }
    return self;
}

- (void) update:(ccTime)delta {
    [[SimpleAudioEngine sharedEngine] setEffectsVolume:([volumeSlider value] / 100)];
}

- (void) mute {
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"Sounds/ok.caf"];
    
    if ([[SimpleAudioEngine sharedEngine] mute])
    {
        [[SimpleAudioEngine sharedEngine] setMute:0];
    }
    else
    {
        [[SimpleAudioEngine sharedEngine] setMute:1];
    }
}

- (void) backToMenu {
    [[SimpleAudioEngine sharedEngine] playEffect:@"Sounds/ok.caf"];
    [[CCDirector sharedDirector] replaceScene:[MainMenu scene]];
}

- (void) dealloc {
    [volumeSlider removeFromSuperview];
    [volumeSlider release];
    [self unscheduleUpdate];
    
    [super dealloc];
}

@end
