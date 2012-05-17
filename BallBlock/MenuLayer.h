//
//  MenuLayer.h
//  BallBlock
//
//  Created by ramin on 5/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"

@interface MenuLayer : CCLayer
{
    CCMenuItemFont *_timedMenuItem;
    CCMenuItemFont *_relaxedMenuItem;
    CCMenuItemFont *_quitMenuItem;
    CCMenu *_menu;
}

+ (id)scene;

@end
