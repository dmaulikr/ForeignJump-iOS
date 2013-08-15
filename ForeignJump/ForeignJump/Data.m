//
//  Data.m
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 14/08/13.
//  Copyright (c) 2013 Epimac. All rights reserved.
//

#import "Data.h"

static int score;
static BOOL dead;

static CGPoint coinTouchPoint;
static BOOL coinTouched;

@implementation Data

#pragma mark - Score
+(int)getScore {
    return score;
}

+(void) setScore:(int)score_ {
    score = score_;
}

+(void) addScore:(int)score_ {
    score += score_;
}

+(void) scorePlusPlus {
    [self addScore:1];
}

#pragma mark - Dead
+(BOOL) getDead {
    return dead;
}

+(void) setDead:(BOOL)dead_ {
    dead = dead_;
}

#pragma mark - Coin
+(void) setCoinTouch:(BOOL)state {
    coinTouched = state;
}

+(BOOL) isCoinTouched {
    return coinTouched;
}

+(void) startCoinParticle:(CGPoint)point {
    coinTouchPoint = point;
}

+(CGPoint) getTouchPoint {
    return coinTouchPoint;
}

@end
