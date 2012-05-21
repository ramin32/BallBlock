//
//  Wall.m
//  BallBlock
//
//  Created by ramin on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Wall.h"
#import "cocos2d.h"
#import "GameConfig.h"

@implementation Wall

- (id) initFrom:(CGPoint)from to:(CGPoint)to
{
    if (self = [super init]) 
    {     
        _body = cpBodyNewStatic();
        
        float radius = 5.0;
        _shape = cpSegmentShapeNew(_body, from, to, radius);    
        _shape->e = .7;
        _shape->u =  WALL_FRICTION;
    }
    return self;
}

- (void) addToSpace: (cpSpace *) space
{
    cpSpaceAddShape(space, _shape);
}

+ (Wall *) initAndAddToSpace:(cpSpace *)space from:(CGPoint)from to:(CGPoint)to
{
    Wall *wall = [[Wall alloc] initFrom:from to:to];
    [wall addToSpace:space];
    return wall;
}

+ (Wall *) initAndAddToSpace:(cpSpace *)space fromValue:(NSValue *) fromValue toValue:(NSValue *) toValue
{
    CGPoint from = [fromValue CGPointValue];
    CGPoint to = [toValue CGPointValue];
    return [Wall initAndAddToSpace:space from:from to:to];
}

+ (NSArray *) initFrameForSpace: (cpSpace *) space
{    
    CGSize winSize = [CCDirector sharedDirector].winSize; 
    cpVect lowerLeft = cpv(0, 0);
    cpVect lowerRight = cpv(winSize.width, 0);
    cpVect upperLeft = cpv(0, winSize.height);
    cpVect upperRight = cpv(winSize.width, winSize.height);
    
    Wall *w1 = [Wall initAndAddToSpace:space from:lowerLeft to:lowerRight];
    Wall *w2 = [Wall initAndAddToSpace:space from:lowerLeft to:upperLeft];
    Wall *w3 = [Wall initAndAddToSpace:space from:lowerRight to:upperRight];
    Wall *w4 = [Wall initAndAddToSpace:space from:upperLeft to:upperRight];
    
    return [NSArray arrayWithObjects:w1, w2, w3, w4, nil];
}


- (void) dealloc
{
    cpShapeFree(_shape);
    cpBodyFree(_body);
    [super dealloc];
}
@end
