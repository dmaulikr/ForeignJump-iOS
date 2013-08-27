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

static CGPoint bombTouchPoint;
static BOOL bombTouched;

static BOOL killedByEnnemy;

@implementation Data

+ (void)resetData {
    score = 0;
    dead = NO;
    
    coinTouchPoint = ccp(0,0);
    coinTouched = NO;
    
    bombTouchPoint = ccp(0,0);
    bombTouched = NO;
    
    killedByEnnemy = NO;
}

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
+(void) setCoinState:(BOOL)state {
    coinTouched = state;
}

+(BOOL) isCoinTouched {
    return coinTouched;
}

+(void) startCoinParticle:(CGPoint)point {
    coinTouchPoint = point;
}

+(CGPoint) getCoinPoint {
    return coinTouchPoint;
}

#pragma mark - Bomb
+(void) setBombState:(BOOL)state {
    bombTouched = state;
}

+(BOOL) isBombTouched {
    return bombTouched;
}

+(void) startBombParticle:(CGPoint)point {
    bombTouchPoint = point;
}

+(CGPoint) getBombPoint {
    return bombTouchPoint;
}

+(void) setEnnemyKilledState:(BOOL)state {
    killedByEnnemy = state;
}

+(BOOL) isKilledByEnnemy {
    return killedByEnnemy;
}

@end
