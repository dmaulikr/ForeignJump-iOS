//
//  ContactListener.h
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 12/08/13.
//  Copyright (c) 2013 Epimac. All rights reserved.
//
#import "Box2D.h"

class ContactListener : public b2ContactListener
{
private:
    void BeginContact(b2Contact *contact);
    void activateBomb(BOOL isA);
    void activateCoin(BOOL isA);
    void killedByEnnemy (BOOL isA);
    void activateACDC(BOOL isA);
    void activateBonus(BOOL isA);
    void activateSuperman(BOOL isA);
    void runWithDelay(SEL method);
};