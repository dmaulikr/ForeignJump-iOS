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

+ (BOOL) getDead;
+ (void) setDead:(BOOL)dead_;

+ (void) setCoinState:(BOOL)state;
+ (BOOL) isCoinTouched;
+ (void) startCoinParticle:(CGPoint)point;
+ (CGPoint) getCoinPoint;

+ (void) setBombState:(BOOL)state;
+ (BOOL) isBombTouched;
+ (void) startBombParticle:(CGPoint)point;
+ (CGPoint) getBombPoint;

+ (void) setEnnemyKilledState:(BOOL)state;
+ (BOOL) isKilledByEnnemy;

+ (id) initDestroyArray;
+ (NSMutableArray *) toDestroyArray;
+ (void) destroyAllBodies;
+ (void) addBodyToDestroy:(b2Body *)body;
+ (BOOL) isDestroyArrayEmpty;
+ (BOOL) isDestroyArrayFull;

@end
