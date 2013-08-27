//
//  HUD.mm
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 25/07/13.
//  Copyright Epimac 2013. All rights reserved.
//
#import "HUD.h"
#import "InGame.h"

@implementation HUD {
    CGSize size;
}

-(id) init {
	
    if( (self=[super init])) {

        size = [[CCDirector sharedDirector] winSize];
    
		scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i", 0] fontName:@"HUD/SCRATCH.TTF" fontSize:30.0];
        [scoreLabel setPosition:ccp(64,284)];
        [scoreLabel setColor:ccc3(0,0,0)];
        [self addChild:scoreLabel];
        
        [self schedule:@selector(updateScore)];
        
        coins = [CCSprite spriteWithFile:@"HUD/coins.png"];
        [coins setPosition:ccp(35,290)];
        [self addChild:coins];
        
        CCSprite *benin = [CCSprite spriteWithFile:@"HUD/benin_flag.png"];
        CCSprite *india = [CCSprite spriteWithFile:@"HUD/india_flag.png"];
        CCSprite *reunion = [CCSprite spriteWithFile:@"HUD/reunion_flag.png"];
        CCSprite *romania = [CCSprite spriteWithFile:@"HUD/romania_flag.png"];
        
        switch ([Character type]) {
            case Roumain:
                flag = romania;
                break;
            case Renoi:
                flag = benin;
                break;
            case Reunionnais:
                flag = reunion;
                break;
            case Indien:
                flag = india;
                break;
            default:
                NSLog(@"Unknown character type.");
                break;
        }
        
        [flag setScale: 0.7];
        [flag setPosition: ccp(size.width - 40,270)];
        [self addChild:flag];
        
        //back menu
        CCSprite *pauseSprite = [CCSprite spriteWithFile:@"Menu/Choose/back.png"];
        CCSprite *pauseSpriteSelected = [CCSprite spriteWithFile:@"Menu/Choose/back-selected.png"];
        
        CCMenuItemSprite *pause = [CCMenuItemSprite itemWithNormalSprite:pauseSprite selectedSprite:pauseSpriteSelected target:self selector:@selector(pauseAll)];
        [pause setPosition:ccp(30,30)];
        
        CCMenu *pauseMenu = [CCMenu menuWithItems:pause, nil];
        [pauseMenu setPosition:ccp(0,0)];
        
        [self addChild:pauseMenu];
        //end back menu
	}
	return self;
}

- (void) pauseAll {
    [InGame pauseAll];
}

- (void) updateScore {
    int score = [Data getScore];
    [scoreLabel setString:[NSString stringWithFormat:@"%i", score]];
    
    if ([Data getDead]) {
        [self unscheduleAllSelectors];
    }
}

@end
