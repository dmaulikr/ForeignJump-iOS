//
//  Background.mm
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 25/07/13.
//  Copyright Epimac 2013. All rights reserved.
//
#import "Background.h"
#import "InGame.h"
#import "Data.h"

@implementation Background {
    CGSize size;
    Hero *hero;
    float worldWidth;
}

#pragma mark - synthesize
@synthesize sun;

#pragma mark - Init methods

-(id) init
{
	if( (self=[super init])) {
        
        size = [[CCDirector sharedDirector] winSize];
        
        //background
        background = [CCSprite spriteWithFile:[Character backgroundTexture]];
		[background setPosition:ccp(size.width/2, size.height/2)];
        
        [self addChild: background z: 0];
        //end background
	}
	return self;
}

- (void) setupBackgroundImage {
    
    sun = [CCSprite spriteWithFile:[Character backgroundSun]];
    [sun setPosition:ccp(size.width, size.height/2)];

    [self addChild:sun z:1];
    
    //add schedule to move backgrounds
    [self schedule:@selector(moveBackground)];
}

- (void) setHero {
    
    hero = [Hero heroInstance];
    worldWidth = [InGame getWorldWidth];
    [self setupBackgroundImage];
}

#pragma mark - Update methods
- (void) moveBackground {
    
    if ([Data isDead]) {
        [self unscheduleAllSelectors];
    }
    else
    {
        float hpos = hero.texture.position.x;
        float xpos = (worldWidth - hpos)/7;
        [sun setPosition:ccp(xpos, sun.position.y)];
    }
}

- (void) dealloc {
    [self unscheduleAllSelectors];
    
    [super dealloc];
}

@end
