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
#import "SimpleAudioEngine.h"

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
        [Data startCoinParticle:textureB.position];
        
        activateCoin();
    }
    else if (textureA.tag == Piece && textureB.tag == HeroType)
    {
        textureA.visible = NO;
        [Data startCoinParticle:textureA.position];

        activateCoin();
    }
    
    // hero & ennemy
    if (textureA.tag == HeroType && textureB.tag == EnnemyType)
    {
        textureA.visible = NO;
        [Data setEnnemyKilledState:YES];
        [Data setDead:YES];
    }
    else if (textureA.tag == EnnemyType && textureB.tag == HeroType)
    {
        textureB.visible = NO;
        [Data setEnnemyKilledState:YES];
        [Data setDead:YES];
    }
    
    // hero & bombe
    if (textureA.tag == HeroType && textureB.tag == Bombe)
    {
        textureA.visible = NO;
        [Data startBombParticle:textureB.position];
        activateBomb();
    }
    else if (textureA.tag == Bombe && textureB.tag == HeroType)
    {
        textureB.visible = NO;
        [Data startBombParticle:textureA.position];
        activateBomb();
    }
}

void ContactListener::activateBomb()
{
    [Data setBombState:YES];
    [Data setDead:YES];
    [[SimpleAudioEngine sharedEngine] playEffect:@"Sounds/bomb.caf"];
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

void ContactListener::activateCoin()
{
    [Data setCoinState:YES];
    [Data scorePlusPlus];
    [[SimpleAudioEngine sharedEngine] playEffect:@"Sounds/coin.caf"];
}