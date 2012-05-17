#import "cocos2d.h"
#import "chipmunk.h"
#import "Ball.h"

@interface GameLayer : CCLayer {
    cpSpace *_space;
    Ball *_ball;
}

+ (id)scene;

@end
