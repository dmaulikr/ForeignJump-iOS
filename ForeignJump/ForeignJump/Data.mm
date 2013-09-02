//
//  Data.mm
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 14/08/13.
//  Copyright (c) 2013 Epimac. All rights reserved.
//
#import "Data.h"
#import "InGame.h"

const int capacity = 1;

static int score;
static BOOL dead;

static CGPoint coinTouchPoint;
static BOOL coinTouched;

static CGPoint bombTouchPoint;
static BOOL bombTouched;

static BOOL killedByEnnemy;

static NSMutableArray *toDestroyArray;

static BOOL firstTime;

@implementation Data

+ (void)resetData {
    score = 0;
    dead = NO;
    
    coinTouchPoint = ccp(0,0);
    coinTouched = NO;
    
    bombTouchPoint = ccp(0,0);
    bombTouched = NO;
    
    killedByEnnemy = NO;
    
    [toDestroyArray release];
}

#pragma mark - Score
+ (int) getScore {
    return score;
}

+ (void) setScore:(int)score_ {
    score = score_;
}

+ (void) addScore:(int)score_ {
    score += score_;
}

+ (void) scorePlusPlus {
    [self addScore:1];
}

#pragma mark - Dead
+ (BOOL) isDead {
    return dead;
}

+ (void) setDead:(BOOL)dead_ {
    dead = dead_;
}

#pragma mark - Coin
+ (void) setCoinState:(BOOL)state {
    coinTouched = state;
}

+ (BOOL) isCoinTouched {
    return coinTouched;
}

+ (void) startCoinParticle:(CGPoint)point {
    coinTouchPoint = point;
}

+ (CGPoint) getCoinPoint {
    return coinTouchPoint;
}

#pragma mark - Bomb
+ (void) setBombState:(BOOL)state {
    bombTouched = state;
}

+ (BOOL) isBombTouched {
    return bombTouched;
}

+ (void) startBombParticle:(CGPoint)point {
    bombTouchPoint = point;
}

+ (CGPoint) getBombPoint {
    return bombTouchPoint;
}

+ (void) setEnnemyKilledState:(BOOL)state {
    killedByEnnemy = state;
}

+ (BOOL) isKilledByEnnemy {
    return killedByEnnemy;
}

+ (id) initDestroyArray {
    toDestroyArray = [[NSMutableArray alloc] initWithCapacity:capacity];
    return toDestroyArray;
}

+ (NSMutableArray *) getToDestroyArray {
    return toDestroyArray;
}

+ (void) destroyAllBodies {
    
    b2World *world = [InGame getWorld];
    
    for (NSValue *bodyValue in toDestroyArray)
    {
        b2Body *body;
        body = (b2Body*)[bodyValue pointerValue];
        world->DestroyBody(body);
        body = NULL;
    }
    
    [toDestroyArray removeAllObjects];
}

+ (void) addBodyToDestroy:(b2Body *)body {
    [toDestroyArray addObject:[NSValue valueWithPointer:body]];
}

+ (BOOL) isDestroyArrayEmpty {
    return [toDestroyArray count] == 0;
}

+ (BOOL) isDestroyArrayFull {
    return [toDestroyArray count] >= capacity;
}

+ (BOOL) isFirstTime {
    return !firstTime;
}

+ (void) setFirstTime:(BOOL)state {
    firstTime = !state;
}

@end
