//
//  InGame.h
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 25/07/13.
//  Copyright Epimac 2013. All rights reserved.
//
#import "Hero.h"
#import "GLES-Render.h"
#import "Map.h"
#import "Ennemy.h"
#import "ContactListener.h"

//Pixel to metres ratio. Box2D uses metres as the unit for measurement.
//This ratio defines how many pixels correspond to 1 Box2D "metre"
//Box2D is optimized for objects of 1x1 metre therefore it makes sense
//to define the ratio so that your most common object type is 1x1 metre.

// InGame
@interface InGame : CCLayer {
	GLESDebugDraw *m_debugDraw;		// strong ref
    Hero *hero; //the main hero
    Ennemy *ennemy;
    b2World *world;
    Map *map;
    b2ContactListener *contactListener; //detect collision
}

@property (nonatomic, strong) Hero *hero;
@property (nonatomic, strong) Ennemy *ennemy;

// returns a CCScene that contains the InGame as the only child

+ (CCScene *) scene;

+ (b2World *) getWorld;

+ (float) getWorldWidth;

+ (void) pauseAll;

@end
