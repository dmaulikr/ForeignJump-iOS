//
//  GameWon.m
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 03/09/13.
//  Copyright 2013 Epimac. All rights reserved.
//

#import "GameWon.h"
#import "MainMenu.h"
#import "Data.h"
#import "ABGameKitHelper.h"

@implementation GameWon {
    CGSize size;
}

@synthesize bg = bg;

-(id) init {
	
    if( (self=[super init])) {
        
        size = [[CCDirector sharedDirector] winSize];
        
        bg = [CCSprite spriteWithFile:@"Menu/GameWon.png"];
        [bg setPosition:ccp(size.width/2, size.height/2)];
        [bg setOpacity:0];
        [self addChild:bg z:0 tag:9999];
        
     //   [[ABGameKitHelper sharedHelper] showLeaderboard:@"leaderboardID"];
    }
	return self;
}

-(void) registerWithTouchDispatcher
{
	[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    if ([Data didWin])
    {
    //    [[ABGameKitHelper sharedHelper] reportScore:[Data getScore] forLeaderboard:@"leaderboardId"];
        //if dead go to main menu
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0f scene:[MainMenu scene]]];
    }
    return YES;
}

@end