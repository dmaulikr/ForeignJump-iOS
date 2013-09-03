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

static float distance;

static BOOL dead;

static NSMutableArray *toDestroyArray;

static BOOL firstTime;

@implementation Data

+ (void)resetData {
    score = 0;

    distance = 0;
    
    dead = NO;
    
    [toDestroyArray release];
}

#pragma mark - Score
+ (int) getScore {
    return (int)score;
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

#pragma mark - Distance
+ (int) getDistance {
    return distance;
}

+ (void) setDistance:(int)distance_ {
    distance = distance_;
}

+ (void) addDistance:(int)distance_ {
    distance += distance_;
}

+ (void) distancePlusPlus {
    [self addDistance:1];
}

#pragma mark - Dead
+ (BOOL) isDead {
    return dead;
}

+ (void) setDead:(BOOL)dead_ {
    dead = dead_;
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

+ (BOOL) isNotFirstTime {
    return !firstTime;
}

+ (void) setNotFirstTime:(BOOL)state {
    firstTime = !state;
}

@end
