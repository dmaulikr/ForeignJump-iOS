//
//  Data.h
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 14/08/13.
//  Copyright (c) 2013 Epimac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Data : NSObject

+(int) getScore;
+(void) setScore:(int)score_;
+(void) addScore:(int)score_;
+(void) scorePlusPlus;

+(BOOL) getDead;
+(void) setDead:(BOOL)dead_;

+(void) setCoinTouch:(BOOL)state;
+(BOOL) isCoinTouched;
+(void) startCoinParticle:(CGPoint)point;
+(CGPoint) getTouchPoint;

@end
