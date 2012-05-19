#import "GameLayer.h"
#import "drawSpace.h"
#import <UIKit/UIKit.h>
#import "Wall.h"
#import "MenuLayer.h"
#import "MathUtil.h"


@implementation GameLayer


+ (id)scene {
    CCScene *scene = [CCScene node];
    GameLayer *layer = [GameLayer node];
    [scene addChild:layer];
    return scene;
}


- (void) initSpace {
    _space = cpSpaceNew();
    _space->gravity = cpv(0, 0);
    cpSpaceResizeStaticHash(_space, 400, 200);
    cpSpaceResizeActiveHash(_space, 200, 200);
}




- (void)draw 
{
    drawSpaceOptions options = {
        0, // drawHash
        0, // drawBBs,
        1, // drawShapes
        4.0, // collisionPointSize
        4.0, // bodyPointSize,
        2.0 // lineThickness
    };
    
    drawSpace(_space, &options);
    
}


- (void) update: (ccTime) dt
{
    cpSpaceStep(_space, dt);
}


- (id)init {
    if ((self = [super init])) {                
        _walls = [[NSMutableArray alloc] init];
        _balls = [[NSMutableArray alloc] init];
        _ballCount = 20;
        
        CCDirector *director = [CCDirector sharedDirector];
        
        [self initSpace];
        [_walls addObjectsFromArray:[Wall initFrameForSpace:_space]];
        
        for(int i = 0; i< _ballCount; i++)
        {
            [_balls addObject:[Ball initAndAddToSpace:_space]];
        }
        
        [self scheduleUpdate];
        self.isTouchEnabled = YES;
        
        for(int i = 0 ;i < 100; i++) [[NSString alloc] init];
        
        // Standard method to create a button
        CCMenuItem *pauseMenuItem = [CCMenuItemFont 
                                                            itemFromString:@"||" 
                                                            block:^(id sender) 
                                                            {
                                                                [director replaceScene:
                                                                 [CCTransitionMoveInL transitionWithDuration:0.5f scene:[MenuLayer scene]]];
                                                            }];
        pauseMenuItem.position = ccp(director.winSize.width - 20, director.winSize.height - 25 );
        CCMenu *menu = [CCMenu menuWithItems:pauseMenuItem, nil];
        menu.position = CGPointZero;
        [self addChild:menu];
        
              
    }
    return self;
}  

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSSet *allTouches = [event allTouches];
    UITouch * touch = [[allTouches allObjects] objectAtIndex:0];
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    //Swipe Detection Part 1
    _firstTouch = location;
}

//- (void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSSet *allTouches = [event allTouches];
//    UITouch * touch = [[allTouches allObjects] objectAtIndex:0];
//    CGPoint location = [touch locationInView: [touch view]];
//    location = [[CCDirector sharedDirector] convertToGL:location];
//    
//    //Swipe Detection Part 2
//    _lastTouch = location;
//    
//    //Minimum length of the swipe
//    float swipeLength = ccpDistance(_firstTouch, _lastTouch);
//    
//    //Check if the swipe is a left swipe and long enough
//    // if (_firstTouch.x > _lastTouch.x && swipeLength > 60) {
//    //if(    swipeLength > 60) 
//    [_walls addObject: [Wall initAndAddToSpace:_space from:_firstTouch to:_lastTouch]];
//    //}
//    _firstTouch = _lastTouch;
//
//}

- (void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSSet *allTouches = [event allTouches];
    UITouch * touch = [[allTouches allObjects] objectAtIndex:0];
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    //Swipe Detection Part 2
    _lastTouch = location;
    
    //Minimum length of the swipe
    float swipeLength = ccpDistance(_firstTouch, _lastTouch);
    
    NSArray *linePoints = borderPointsForPoints(_firstTouch, _lastTouch);
    CGPoint p1 = [[linePoints objectAtIndex:0] CGPointValue];
    CGPoint p2 = [[linePoints objectAtIndex:1] CGPointValue];
    [_walls addObject: [Wall initAndAddToSpace:_space from: p1 to:p2]];
}


- (void)dealloc {
    cpSpaceFree(_space);
    [_balls release];
    [_walls release];
    [super dealloc];
}

@end
