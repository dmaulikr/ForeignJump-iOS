//
//  Map.h
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 27/07/13.
//  Copyright (c) 2013 Epimac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tile.h"

@interface Map : CCLayer

-(id) initWithFile:(NSString*)file;
-(void) loadMap:(b2World*)world;

@end
 