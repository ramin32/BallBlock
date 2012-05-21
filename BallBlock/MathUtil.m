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

NSValue *pointOnLineWithY(CGPoint p, float m, float y)
{
    float x = (y - p.y)/m + p.x;
    return [NSValue  valueWithCGPoint: CGPointMake(x,y)];
}

NSValue *pointOnLineWithX(CGPoint p, float m, float x)
{
    float y = m*(x - p.x) + p.y;
    return [NSValue  valueWithCGPoint: CGPointMake(x,y)];
}


NSArray *borderPointsForPoints(CGPoint p1, CGPoint p2)
{
    float m = slope(p1, p2);
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    NSValue *pointAtYZero = pointOnLineWithY(p1, m, 0);
    NSValue *pointAtYHeight = pointOnLineWithY(p1, m, winSize.height);
    NSValue *pointAtXZero = pointOnLineWithX(p1, m, 0);
    NSValue *pointAtXWidth = pointOnLineWithX(p1, m, winSize.width);
    
    NSArray *points = [NSArray arrayWithObjects: pointAtYZero, pointAtYHeight, pointAtXZero, pointAtXWidth, nil];
    
    NSPredicate *inWindowPredicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        CGPoint p = [evaluatedObject CGPointValue];
        return  p.x >= 0 && p.x <= winSize.width && p.y >=0 && p.y <= winSize.height;
    }];
    
    return [points filteredArrayUsingPredicate:inWindowPredicate];
}

