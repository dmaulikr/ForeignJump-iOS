//
//  ContactListener.m
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 12/08/13.
//  Copyright (c) 2013 Epimac. All rights reserved.
//

#import "ContactListener.h"
#import "Map.h"
#import "InGame.h"
#import "Hero.h"

void ContactListener::BeginContact(b2Contact *contact)
{
    b2Body *bodyA = contact->GetFixtureA()->GetBody();
    b2Body *bodyB = contact->GetFixtureB()->GetBody();
    
    CCSprite *textureA = (CCSprite *)bodyA->GetUserData();
    CCSprite *textureB = (CCSprite *)bodyB->GetUserData();
    
    // hero & pièce
    if (textureA.tag == HeroType && textureB.tag == Piece)
    {
        textureB.visible = NO;
        [Data scorePlusPlus];
        [Data startCoinParticle:textureA.position];
        [Data setCoinState:YES];
    }
    else if (textureA.tag == Piece && textureB.tag == HeroType)
    {
        textureA.visible = NO;
        [Data scorePlusPlus];
        [Data startCoinParticle:textureA.position];
        [Data setCoinState:YES];
    }
    
    // hero & ennemy
    if (textureA.tag == HeroType && textureB.tag == EnnemyType)
    {
        textureA.visible = NO;
        [Data setDead:YES];
    }
    else if (textureA.tag == EnnemyType && textureB.tag == HeroType)
    {
        textureB.visible = NO;
        [Data setDead:YES];
    }
    
    // hero & bombe
    if (textureA.tag == HeroType && textureB.tag == Bombe)
    {
        textureA.visible = NO;
        [Data startBombParticle:textureB.position];
        [Data setBombState:YES];
    }
    else if (textureA.tag == Bombe && textureB.tag == HeroType)
    {
        textureB.visible = NO;
        [Data startBombParticle:textureA.position];
        [Data setBombState:YES];
    }
}