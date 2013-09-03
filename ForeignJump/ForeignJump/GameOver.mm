//
//  GameOver.m
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 27/08/13.
//  Copyright 2013 Epimac. All rights reserved.
//

#import "GameOver.h"
#import "MainMenu.h"
#import "Data.h"

@implementation GameOver {
    CGSize size;
}

@synthesize bg = bg;

-(id) init {
	
    if( (self=[super init])) {
        
        size = [[CCDirector sharedDirector] winSize];
        
        bg = [CCSprite spriteWithFile:@"Menu/GameOver.png"];
        [bg setPosition:ccp(size.width/2, size.height/2)];
        [bg setOpacity:0];
        [self addChild:bg z:0 tag:9999];
    }
	return self;
}

-(void) registerWithTouchDispatcher
{
	[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    if ([Data isDead])
    {
        //if dead go to main menu
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0f scene:[MainMenu scene]]];
    }
    return YES;
}

@end
