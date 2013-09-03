//
//  Tutorial.m
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 03/09/13.
//  Copyright 2013 Epimac. All rights reserved.
//

#import "Tutorial.h"


@implementation Tutorial {
    CCSprite *bg;
    CGSize size;
    CGPoint startTouch;
    CGPoint stopTouch;
}

- (id) init {
    
   	if( (self = [super init])) {
        size = [[CCDirector sharedDirector] winSize];
        
        //background
        bg = [CCSprite spriteWithFile:@"Menu/Options/menubg.png"];
        [bg setPosition:ccp(size.width/2, size.height/2)];
        
        [self addChild:bg z:0];
        //end background
    }
    return self;
}


-(void) registerWithTouchDispatcher
{
	[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:50 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    startTouch = [touch locationInView: [touch view]];
    
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    stopTouch = [touch locationInView: [touch view]];
    
    if (startTouch.y > stopTouch.y)
    {
        //add next step
    }
    
}

- (void)secondStep {

}

- (void)thirdStep {
    
}
@end
