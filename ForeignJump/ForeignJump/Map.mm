//
//  Map.m
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 27/07/13.
//  Copyright (c) 2013 Epimac. All rights reserved.
//

#import "Map.h"
#import "InGame.h"
#import "Tile.h"

@implementation Map {
    NSString *data;
    b2World *world;
}

+ (id) mapWithFile:(NSString *)file {
    return [[[self node] initWithFile:file] loadMap];
}

- (id) initWithFile:(NSString *)file {
    
    if( (self=[super init])) {
        
        data = [[[NSString alloc] initWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] autorelease];
    }
    return self;
}

-(id) loadMap {
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    world = [InGame getWorld];
    
    int i = 0, j = 0;
    
    [[CCTextureCache sharedTextureCache] addImage: [Character mapTerre]];
    [[CCTextureCache sharedTextureCache] addImage: [Character mapPiece]];
    [[CCTextureCache sharedTextureCache] addImage: [Character mapBomb]];
    [[CCTextureCache sharedTextureCache] addImage: [Character mapObstacle]];
    [[CCTextureCache sharedTextureCache] addImage: [Character mapSousTerre]];
    [[CCTextureCache sharedTextureCache] addImage: @"Map/acdcTile.png"];
    [[CCTextureCache sharedTextureCache] addImage: @"Map/rien.png"];

    
    for (NSString *line in [data componentsSeparatedByString:@"\n"])
    {
        for (int ch = 0; ch < line.length; ch++) {
            
            char chara = [line characterAtIndex:ch];
            
            switch (chara) {
                case '1':
                {
                    Tile *object = [Tile tileWithSpriteFile:[Character mapTerre] andType:Terre atPosition:ccp(i*25,size.height - j*25)];
                    [self addChild:object.texture];
                    break;
                }
                case '2':
                {
                    Tile *object = [Tile tileWithSpriteFile:[Character mapPiece] andType:Piece atPosition:ccp(i*25,size.height - j*25)];
                    [self addChild:object.texture];
                    break;
                }
                case '3':
                {
                    Tile *object = [Tile tileWithSpriteFile:[Character mapBomb] andType:Bombe atPosition:ccp(i*25,size.height - j*25)];
                    [self addChild:object.texture];
                    break;
                }
                case '4':
                {
                    Tile *object = [Tile tileWithSpriteFile:[Character mapObstacle] andType:Obstacle atPosition:ccp(i*25,size.height - j*25)];
                    [self addChild:object.texture];
                    break;
                }
                case '8':
                {
                    Tile *object = [Tile tileWithSpriteFile:[Character mapSousTerre] andType:Sousterre atPosition:ccp(i*25,size.height - j*25)];
                    [self addChild:object.texture];
                    break;
                }
                case'A':
                {
                    Tile *object = [Tile tileWithSpriteFile:@"Map/acdcTile.png" andType:ACDC atPosition:ccp(i*25,size.height - j*25)];
                    [self addChild:object.texture];
                }
                default:
                {
                    Tile *object = [Tile tileWithSpriteFile:@"Map/rien.png" andType:Null atPosition:ccp(i*25,size.height - j*25)];
                    [self addChild:object.texture];
                    break;
                }
            }
            i++;
        }
        i = 0;
        j++;
    }
    return self;
}

@end
