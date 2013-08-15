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

void ContactListener::BeginContact(b2Contact* contact)
{
    
    b2Body* bodyA = contact->GetFixtureA()->GetBody();
    b2Body* bodyB = contact->GetFixtureB()->GetBody();
    
    CCSprite *textureA = (CCSprite*)bodyA->GetUserData();
    CCSprite *textureB = (CCSprite*)bodyB->GetUserData();
    
    // hero & pièce
    if (textureA.tag == 11 && textureB.tag == 5)
    {
        textureB.visible = NO;
        [Data scorePlusPlus];
        [Data startCoinParticle:textureA.position];
        [Data setCoinTouch:YES];
    }
    else if (textureA.tag == 5 && textureB.tag == 11)
    {
        textureA.visible = NO;
        [Data scorePlusPlus];
        [Data startCoinParticle:textureA.position];
        [Data setCoinTouch:YES];
    }
    
    // hero & ennemi
    if (textureA.tag == 11 && textureB.tag == 12)
    {
        textureA.visible = NO;
        [Data setDead:YES];
    }
    else if (textureA.tag == 12 && textureB.tag == 11)
    {
        textureB.visible = NO;
        [Data setDead:YES];
    }
}

void ContactListener::EndContact(b2Contact* contact)
{
    b2Body* bodyA = contact->GetFixtureA()->GetBody();
    b2Body* bodyB = contact->GetFixtureB()->GetBody();
    
    CCSprite *textureA = (CCSprite*)bodyA->GetUserData();
    CCSprite *textureB = (CCSprite*)bodyB->GetUserData();
    
    // hero & pièce
    if (textureA.tag == 11 && textureB.tag == 5)
    {
        //bodyA->GetWorld()->DestroyBody(bodyB);
    }
    else if (textureA.tag == 5 && textureB.tag == 11)
    {
        //bodyB->GetWorld()->DestroyBody(bodyA);
    }
    
}