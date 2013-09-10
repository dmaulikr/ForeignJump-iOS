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
#import "Data.h"

b2Body *bodyA;
b2Body *bodyB;
CCSprite *textureA;
CCSprite *textureB;

void ContactListener::BeginContact(b2Contact *contact)
{
    bodyA = contact->GetFixtureA()->GetBody();
    bodyB = contact->GetFixtureB()->GetBody();
    
    textureA = (CCSprite *)bodyA->GetUserData();
    textureB = (CCSprite *)bodyB->GetUserData();
    
    // hero & pièce
    if (textureA.tag == HeroType && textureB.tag == Piece)
    {
        activateCoin(NO);
    }
    else if (textureA.tag == Piece && textureB.tag == HeroType)
    {
        activateCoin(YES);
    }
    
    
    // hero & bombe
    if (textureA.tag == HeroType && textureB.tag == Bombe)
    {
        activateBomb(NO);
    }
    else if (textureA.tag == Bombe && textureB.tag == HeroType)
    {
        activateBomb(YES);
    }
    
    // hero & ACDC
    if (textureA.tag == HeroType && textureB.tag == ACDC)
    {
        activateACDC(NO);
    }
    else if (textureA.tag == ACDC && textureB.tag == HeroType)
    {
        activateACDC(YES);
    }

    
    // hero & ennemy
    if (textureA.tag == HeroType && textureB.tag == EnnemyType)
    {
        killedByEnnemy(NO);
    }
    else if (textureA.tag == EnnemyType && textureB.tag == HeroType)
    {
        killedByEnnemy(YES);
    }
    
    
    // ennemy & ACDC Type
    if ((textureA.tag == EnnemyType && textureB.tag == ACDCType) || (textureA.tag == ACDCType && textureB.tag == EnnemyType))
    {
        runWithDelay(@selector(push));
        runWithDelay(@selector(hide));
    }
    
    // hero & bonus
    if (textureA.tag == HeroType && textureB.tag == Bonus)
    {
        activateBonus(NO);
    }
    else if (textureA.tag == Bonus && textureB.tag == HeroType)
    {
        activateBonus(YES);
    }
    
    // hero & superman
    if (textureA.tag == HeroType && textureB.tag == Superman)
    {
        activateSuperman(NO);
    }
    else if (textureA.tag == Superman && textureB.tag == HeroType)
    {
        activateSuperman(YES);
    }
}

void ContactListener::activateBomb(BOOL isA)
{
    if (isA) {
        [textureB setVisible:NO];
        [[InGame instance] releaseBombAtPoint:textureA.position];
    }
    else
    {
        [textureA setVisible:NO];
        [[InGame instance] releaseBombAtPoint:textureB.position];
    }
    
    [Data setDead:YES];
    [[SimpleAudioEngine sharedEngine] playEffect:@"Sounds/bomb.caf"];
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

void ContactListener::activateCoin(BOOL isA)
{
    if (isA) {
        [textureA setVisible:NO];
        [[InGame instance] releaseSparklesAtPoint:textureA.position];
        [Data addBodyToDestroy:bodyA];
    }
    else
    {
        [textureB setVisible:NO];
        [[InGame instance] releaseSparklesAtPoint:textureB.position];
        [Data addBodyToDestroy:bodyB];
    }
    
    [Data scorePlusPlus];
    [Data addDistance:10];
    [[SimpleAudioEngine sharedEngine] playEffect:@"Sounds/coin.caf"];
}

void ContactListener::activateACDC(BOOL isA)
{
    if (isA) {
        [textureA setVisible:NO];
        [Data addBodyToDestroy:bodyA];
    }
    else
    {
        [textureB setVisible:NO];
        [Data addBodyToDestroy:bodyB];
    }
    
    runWithDelay(@selector(show));
}

void ContactListener::activateBonus(BOOL isA)
{   int minValue = 1;
    int maxValue = 3;
    int random = (int)(minValue + arc4random() % (maxValue - minValue));
    [Data setBonus:random];
    if (isA) {
        [textureA setVisible:NO];
    }
    else
    {
        [textureB setVisible:NO];
    }
}

void ContactListener::activateSuperman(BOOL isA)
{
    if (isA) {
        [textureA setVisible:NO];
    }
    else
    {
        [textureB setVisible:NO];
    }
    [[Hero heroInstance] superMan];
}


void ContactListener::killedByEnnemy(BOOL isA)
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"Sounds/gameover.caf"];
    
    if (isA) {
        [textureB setVisible:NO];
    }
    else
    {
        [textureA setVisible:NO];
    }

    [[InGame instance] deathByEnnemy];
    [Data setDead:YES];
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

void ContactListener::runWithDelay(SEL method)
{
    CCCallFunc *action = [CCCallFunc actionWithTarget:[ACDCHelp acdcInstance] selector:method];
        
    CCDelayTime *delay = [CCDelayTime actionWithDuration:0.01];
        
    CCSequence *sequence = [CCSequence actions:delay, action, nil];
        
    [[ACDCHelp acdcInstance] runAction:sequence];
}