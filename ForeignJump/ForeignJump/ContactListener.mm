//
//  ContactListener.m
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 12/08/13.
//  Copyright (c) 2013 Epimac. All rights reserved.
//

#import "ContactListener.h"
#import "InGame.h"
#import "Hero.h"

void ContactListener::BeginContact(b2Contact* contact)
{
    
    b2Body* bodyA = contact->GetFixtureA()->GetBody();
    b2Body* bodyB = contact->GetFixtureB()->GetBody();
    
    /*
    if ([bodyA->GetUserData() isKindOfClass:[Hero class]] &&
        [bodyB->GetUserData() isKindOfClass:[Tile class]])
    {
        Hero *hero = (Hero*)bodyA->GetUserData();
        Tile *tile = (Tile*)bodyB->GetUserData();
        
        tile.texture.visible = NO;
    }
    else if ([bodyB->GetUserData() isKindOfClass:[Hero class]]
             && [bodyA->GetUserData() isKindOfClass:[Tile class]])
    {
        Hero *hero = (Hero*)bodyB->GetUserData();
        Tile *tile = (Tile*)bodyA->GetUserData();
        
        tile.texture.visible = NO;
    }
     */
    
    CCSprite *textureA = (CCSprite*)bodyA->GetUserData();
    CCSprite *textureB = (CCSprite*)bodyB->GetUserData();

    if (textureA.tag == 11 && textureB.tag == 5)
    {
        textureB.visible = NO;
        [InGame scorePlusPlus];
    }
    else if (textureA.tag == 5 && textureB.tag == 11)
    {
        textureA.visible = NO;
        [InGame scorePlusPlus];
    }
    
}