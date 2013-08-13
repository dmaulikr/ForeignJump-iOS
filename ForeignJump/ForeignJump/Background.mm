//
//  Background.mm
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 25/07/13.
//  Copyright Epimac 2013. All rights reserved.
//

// Import the interfaces
#import "Background.h"

#pragma mark - Background

static const int mapCols = 120;
static const int mapRows = 15;

@implementation Background
{
    CCParallaxNode *parallaxNode;
    CGSize size;
}

@synthesize sun;
@synthesize animation;

-(id) init
{
	if( (self=[super init])) {
		
        size = [[CCDirector sharedDirector] winSize];
        
        //background
        
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
			background = [CCSprite spriteWithFile:@"Background/bg.png"];
		} else {
			background = [CCSprite spriteWithFile:@"Background/bg.png"];
		}
		background.position = ccp(size.width/2, size.height/2);
        
        [self addChild: background z: 0];

        //end background
        
        [self setupBackgroundImage];
        
        animation = true;
        
	}
	return self;
}

- (void)setupBackgroundImage
{
    
    sun = [CCSprite spriteWithFile:@"Background/sun.png"];
    
    sun.position = ccp(size.width, size.height/2);

    [self addChild:sun z:1];
    
    //add schedule to move backgrounds
    [self schedule:@selector(scroll:)];
}

- (void)scroll:(ccTime)dt {
    
    sun.position = ccp( sun.position.x - 0.03, sun.position.y );
    
    if (sun.position.x == - (size.width/2)) {
        sun.position = ccp(size.width+(size.width/2), size.height/2);
    }
    
}

- (void) pauseBG {
    [self pauseSchedulerAndActions];
    animation = false;
}

- (void) resumeBG {
    [self resumeSchedulerAndActions];
    animation = true;
}

@end
