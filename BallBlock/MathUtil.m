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

int polyContainsPoint(int nvert, float *vertx, float *verty, float testx, float testy)
{
    int i, j, c = 0;
    for (i = 0, j = nvert-1; i < nvert; j = i++) {
        if ( ((verty[i]>testy) != (verty[j]>testy)) &&
            (testx < (vertx[j]-vertx[i]) * (testy-verty[i]) / (verty[j]-verty[i]) + vertx[i]) )
            c = !c;
    }
    return c;
}

