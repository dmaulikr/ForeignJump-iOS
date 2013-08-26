//
//  HUD.mm
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 25/07/13.
//  Copyright Epimac 2013. All rights reserved.
//

// Import the interfaces
#import "HUD.h"

@implementation HUD

-(id) init {
	
    if( (self=[super init])) {
    
		scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i", 0] fontName:@"Helvetica" fontSize:30.0];
        scoreLabel.position = ccp(20,300);
        scoreLabel.color = ccc3(0,0,0);
        [self addChild:scoreLabel];
        
        [self schedule:@selector(updateScore)];
	}
	return self;
}

-(void) updateScore {
    int score = [Data getScore];
    [scoreLabel setString:[NSString stringWithFormat:@"%i", score]];
    
    if ([Data getDead]) {
        [self unscheduleAllSelectors];
    }
}

@end
