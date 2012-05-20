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

CGPoint pointOnLineWithY(CGPoint p, float m, float y)
{
    float x = (y - p.y)/m + p.x;
    return CGPointMake(x,y);
}

CGPoint pointOnLineWithX(CGPoint p, float m, float x)
{
    float y = m*(x - p.x) + p.y;
    return CGPointMake(x, y);
}


NSArray *borderPointsForPoints(CGPoint p1, CGPoint p2)
{
    float m = slope(p1, p2);
    CGRect frame = [CCDirector sharedDirector].accessibilityFrame;
    
    CGPoint pointAtYZero = pointOnLineWithY(p1, m, 0);
    CGPoint pointAtYHeight = pointOnLineWithY(p1, m, frame.size.height);
    CGPoint pointAtXZero = pointOnLineWithX(p1, m, 0);
    CGPoint pointAtXWidth = pointOnLineWithX(p1, m, frame.size.width);
    
    NSMutableArray *nsValuePoints = [NSMutableArray arrayWithCapacity:4];
    CGPoint points[4] = {pointAtYZero, pointAtYHeight, pointAtXZero, pointAtXWidth};
    for (int i = 0; i < 4; i++)
    {
        if (CGRectContainsPoint(frame, points[i]))
        {
            [nsValuePoints addObject:[NSValue valueWithCGPoint:points[i]]];
        }
    }
   
    return nsValuePoints;
}


