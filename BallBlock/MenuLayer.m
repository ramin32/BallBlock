//
//  MenuLayer.m
//  BallBlock
//
//  Created by ramin on 5/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuLayer.h"
#import "GameLayer.h"

@implementation MenuLayer
+ (id)scene {
    CCScene *scene = [CCScene node];
    MenuLayer *layer = [MenuLayer node];
    [scene addChild:layer];
    return scene;
}

- (void) menuItemPressed:(CCMenuItem  *) menuItem
{
    if (menuItem == _timedMenuItem)
    {
    }
    else if (menuItem == _relaxedMenuItem)
    {
        [[CCDirector sharedDirector] replaceScene:
         [CCTransitionFade transitionWithDuration:0.5f scene:[GameLayer scene]]];
    }
    else if (menuItem == _quitMenuItem)
    {
        exit(0);
    }
    
    
}
- (id) init
{
    if (self = [super init])
    {      
        CGSize winSize = [CCDirector sharedDirector].winSize;
        CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
        background.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:background z:0];
        
        //CCMenuItemFont setFont
        _timedMenuItem = [CCMenuItemFont itemFromString: @"Start Timed Game" target:self selector:@selector(menuItemPressed:)];
        _relaxedMenuItem = [CCMenuItemFont itemFromString: @"Start Relaxed Game" target:self selector:@selector(menuItemPressed:)];
        _quitMenuItem = [CCMenuItemFont itemFromString: @"Quit Game" target:self selector:@selector(menuItemPressed:)];

        _menu = [CCMenu menuWithItems: _timedMenuItem, _relaxedMenuItem, _quitMenuItem, nil];
        for (CCMenuItemFont *item in _menu.children){
            item.color = ccBLACK;
        }

        [_menu alignItemsVertically];
        [self addChild:_menu];
    }
    return self;
}

@end
