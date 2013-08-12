//
//  ContactListener.m
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 12/08/13.
//  Copyright (c) 2013 Epimac. All rights reserved.
//

#import "ContactListener.h"
#import "cocos2d.h"
#import "Hero.h"
#import "Tile.h"
#import "InGame.h"

void ContactListener::BeginContact(b2Contact* contact)
{
    b2Body* bodyA = contact->GetFixtureA()->GetBody();
    b2Body* bodyB = contact->GetFixtureB()->GetBody();
}