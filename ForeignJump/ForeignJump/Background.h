//
//  Background.h
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 25/07/13.
//  Copyright Epimac 2013. All rights reserved.
//
#import "Hero.h"

@interface Background : CCLayer {
    CCSprite *background;
    CCSprite *sun;
}

@property (nonatomic, strong) CCSprite *sun;

- (void) setHero;
    
@end
