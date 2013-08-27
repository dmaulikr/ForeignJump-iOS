//
//  MenuPause.h
//  ForeignJump
//
//  Created by Francis Visoiu Mistrih on 27/08/13.
//  Copyright 2013 Epimac. All rights reserved.
//

@interface MenuPause : CCLayer {
    CCSprite *background;
    CCMenu *menu;

    UISlider *volumeSlider;
}

@property (nonatomic, assign) UISlider *volumeSlider;

@end
