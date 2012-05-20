#import "cocos2d.h"
#import "chipmunk.h"
#import "Ball.h"
#import <CCTouchDelegateProtocol.h>

@interface GameLayer : CCLayer {
    cpSpace *_space;
    NSMutableArray *_walls;
    NSMutableArray *_balls;
    int _ballCount;
    
    CGPoint _firstTouch;
    CGPoint _lastTouch;    

}

+ (id)scene;

@end
