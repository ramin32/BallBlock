//
//  MathUtil.c
//  BallBlock
//
//  Created by ramin on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MathUtil.h"


float slope(CGPoint p1, CGPoint p2)
{
    return (p2.y - p1.y) / (p2.x - p1.x);
}

float xPointForPoints(CGPoint p1, CGPoint p2, float y)
{
    float m = slope(p1, p2);
    return (y - p1.y)/m + p1.x;
}

float yPointForPoints(CGPoint p1, CGPoint p2, float x)
{
    float m = slope(p1, p2);
    return m*(x - p1.x) + p1.y;
}



