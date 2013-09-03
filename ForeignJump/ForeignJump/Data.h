//
//  Data.h
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 14/08/13.
//  Copyright (c) 2013 Epimac. All rights reserved.
//
#import "Box2D.h"

@interface Data : NSObject

+ (void) resetData;

+ (int) getScore;
+ (void) setScore:(int)score_;
+ (void) addScore:(int)score_;
+ (void) scorePlusPlus;

+ (int) getDistance;
+ (void) setDistance:(int)distance_;
+ (void) addDistance:(int)distance_;
+ (void) distancePlusPlus;

+ (BOOL) isDead;
+ (void) setDead:(BOOL)dead_;

+ (id) initDestroyArray;
+ (NSMutableArray *) getToDestroyArray;
+ (void) destroyAllBodies;
+ (void) addBodyToDestroy:(b2Body *)body;
+ (BOOL) isDestroyArrayEmpty;
+ (BOOL) isDestroyArrayFull;

+ (BOOL) isNotFirstTime;
+ (void) setNotFirstTime:(BOOL)state;

@end
