//
//  GameOver.m
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 27/08/13.
//  Copyright 2013 Epimac. All rights reserved.
//

#import "GameOver.h"
#import "MainMenu.h"
#import "MenuOptions.h"
#import "Data.h"
#import "ABGameKitHelper.h"

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
        
       // [[ABGameKitHelper sharedHelper] showLeaderboard:@"leaderboardID"];
    }
	return self;
}
@end
