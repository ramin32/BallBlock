#import "cocos2d.h"
#import "chipmunk.h"

@interface ActionLayer : CCLayer {
    cpSpace *space;
    cpBody *ballBody;
}

+ (id)scene;

@end