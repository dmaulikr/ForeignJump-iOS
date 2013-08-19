//
//  Map.m
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 27/07/13.
//  Copyright (c) 2013 Epimac. All rights reserved.
//

#import "Map.h"

@implementation Map {
    NSString *data;
    b2World *world;
}

-(id) initWithFile:(NSString *)file {
    
    if( (self=[super init])) {
        
        NSError *error = nil;
        
        data = [[[NSString alloc] initWithContentsOfFile:file encoding:NSUTF8StringEncoding error:&error] autorelease];
    }
    
    return self;
}

-(void) loadMap:(b2World *)world_ {
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    world = world_;
    
    int i = 0, j = 0;
    
    for (NSString *line in [data componentsSeparatedByString:@"\n"])
    {
        
        for (int ch = 0; ch < line.length; ch++) {
            
            char chara = [line characterAtIndex:ch];
            
            Tile *object = [[[Tile alloc] init] autorelease];
            
            switch (chara) {
                case '1':
                {
                    [object initWithSpriteFile:@"Map/obstacle.png" andType:Terre atPosition:ccp(i*25,size.height - j*25) andWorld:world];
                    [self addChild:object.texture];
                    break;
                }
                case '2':
                {
                    [object initWithSpriteFile:@"Map/piece.png" andType:Piece atPosition:ccp(i*25,size.height - j*25) andWorld:world];
                    [self addChild:object.texture];
                    break;
                }
                case '3':
                {
                    [object initWithSpriteFile:@"Map/bomb.png" andType:Bombe atPosition:ccp(i*25,size.height - j*25) andWorld:world];
                    [self addChild:object.texture];
                    break;
                }
                default:
                {
                    [object initWithSpriteFile:@"Map/rien.png" andType:Null atPosition:ccp(i*25,size.height - j*25) andWorld:world];
                    [self addChild:object.texture];
                    break;
                }
            }
            i++;
        }
        i = 0;
        j++;
    }
}

@end
