//
//  Ball.h
//  BallBlock
//
//  Created by ramin on 5/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "chipmunk.h"

@interface Ball : NSObject{
    cpBody *_body;
    cpShape *_shape;
    CGSize _bounds;
}

- (id)initWithBounds: (CGSize) bounds;

- (void) addToSpace: (cpSpace *) space;

- (void) update;

@end
