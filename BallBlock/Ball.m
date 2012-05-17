//
//  Ball.m
//  BallBlock
//
//  Created by ramin on 5/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Ball.h"
#import "cocos2d.h"

int randVal(int range)
{
    return arc4random() % range - range;
}

cpVect randcpv(int xrange, int yrange)
{
    return cpv(randVal(xrange), randVal(yrange));
}

@implementation Ball

- (id)initWithBounds: (CGSize) bounds
{
    if (self = [super init]) 
    {
        
        _bounds = bounds; 
        float mass = 10;
        float r = 5;
        _body = cpBodyNew(mass, INFINITY);      
        _body->p = cpv(arc4random() % (int)bounds.width, arc4random() % (int)bounds.height);   
 		cpBodySetVelLimit(_body,100);
        
        
        _shape = cpCircleShapeNew(_body, r, cpvzero);  
        _shape->e = 1.5;      
        _shape->u = 0; 
        _shape->collision_type = 1;  
        
        // Apply initial force
        cpBodyApplyImpulse(_body, randcpv(10000,10000), randcpv(1000,1000)); 

    }
    return self;
}

- (void) addToSpace: (cpSpace *) space
{
    cpSpaceAddBody(space, _body);
    cpSpaceAddShape(space, _shape);  
}

- (void) update
{
       
}

- (void) dealloc
{
    cpShapeFree(_shape);
    cpBodyFree(_body);
    [super dealloc];
}

@end
