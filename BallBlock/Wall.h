//
//  Wall.h
//  BallBlock
//
//  Created by ramin on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "chipmunk.h"

@interface Wall : NSObject
{
    cpBody *_body;
    cpShape *_shape;
}

- (id) initFrom:(CGPoint)from to:(CGPoint)to;
- (void) addToSpace: (cpSpace *) space;
+ (Wall *) initAndAddToSpace:(cpSpace *)space from:(CGPoint)from to:(CGPoint)to;
+ (NSArray *) initFrameForSpace: (cpSpace *) space;

@end
