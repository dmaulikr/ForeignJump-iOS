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
        [textureB setVisible:NO];
        [Data startCoinParticle:textureB.position];
        [Data addBodyToDestroy:bodyA];
        
        activateCoin();
    }
    else if (textureA.tag == Piece && textureB.tag == HeroType)
    {
        [textureA setVisible:NO];
        [Data startCoinParticle:textureA.position];
        [Data addBodyToDestroy:bodyB];

        activateCoin();
    }
    
    // hero & ennemy
    if (textureA.tag == HeroType && textureB.tag == EnnemyType)
    {
        [[SimpleAudioEngine sharedEngine] playEffect:@"Sounds/gameover.caf"];
        [textureA setVisible:NO];
        [Data setEnnemyKilledState:YES];
        [Data setDead:YES];
    }
    else if (textureA.tag == EnnemyType && textureB.tag == HeroType)
    {
        [[SimpleAudioEngine sharedEngine] playEffect:@"Sounds/gameover.caf"];
        [textureB setVisible:NO];
        [Data setEnnemyKilledState:YES];
        [Data setDead:YES];
    }
    
    // ennemy & ACDC
    if ((textureA.tag == EnnemyType && textureB.tag == ACDCType) || (textureA.tag == ACDCType && textureB.tag == EnnemyType))
    {
        runWithDelay(@selector(push));
        runWithDelay(@selector(hide));
    }
    
    // hero & ACDC
    if (textureA.tag == HeroType && textureB.tag == ACDC)
    {
        [textureB setVisible:NO];
        runWithDelay(@selector(show));
    }
    else if (textureA.tag == ACDC && textureB.tag == HeroType)
    {
        [textureA setVisible:NO];
        runWithDelay(@selector(show));
    }
    
    // hero & bombe
    if (textureA.tag == HeroType && textureB.tag == Bombe)
    {
        [textureA setVisible:NO];
        [Data startBombParticle:textureB.position];
        activateBomb();
    }
    else if (textureA.tag == Bombe && textureB.tag == HeroType)
    {
        [textureB setVisible:NO];
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

void ContactListener::runWithDelay(SEL method)
{
    CCCallFunc *action = [CCCallFunc actionWithTarget:[ACDCHelp acdcInstance] selector:method];
        
    CCDelayTime *delay = [CCDelayTime actionWithDuration:0.01];
        
    CCSequence *sequence = [CCSequence actions:delay, action, nil];
        
    [[ACDCHelp acdcInstance] runAction:sequence];
}