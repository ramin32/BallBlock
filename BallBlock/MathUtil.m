//
//  MathUtil.c
//  BallBlock
//
//  Created by ramin on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MathUtil.h"
#import "cocos2d.h"

float slope(CGPoint p1, CGPoint p2)
{
    return (p2.y - p1.y) / (p2.x - p1.x);
}

float xPointForPoint(CGPoint p, float m, float y)
{
    return (y - p.y)/m + p.x;
}

float yPointForPoint(CGPoint p, float m, float x)
{
    return m*(x - p.x) + p.y;
}

BOOL between(int x, int min, int max)
{
    return x >= min && x <= max;
}

NSArray *borderPointsForPoints(CGPoint p1, CGPoint p2)
{
    CGSize winSize = [CCDirector sharedDirector].winSize;
    float m = slope(p1, p2);
    
    CGPoint newP1,newP2;
    float xAtYZero = xPointForPoint(p1, m, 0);
    if (between(xAtYZero, 0, winSize.width)) 
    {
        newP1 = CGPointMake(xAtYZero, 0);
    }
    else
    {
        float xAtYHeight = xPointForPoint(p1, m, winSize.height);
        newP1 = CGPointMake(xAtYHeight, winSize.height);
    }
    
    float yAtXZero = yPointForPoint(p1, m, 0);
    if (between(yAtXZero, 0, winSize.height))
    {
        newP2 = CGPointMake(0, yAtXZero);
    }
    else
    {
        float yAtXWidth = yPointForPoint(p1, m, winSize.width);
        newP2 = CGPointMake(winSize.width, yAtXWidth);
    }
    

    return [NSArray arrayWithObjects: [NSValue valueWithCGPoint:newP1],
                                                         [NSValue valueWithCGPoint:newP2],
                                                         nil];
}


