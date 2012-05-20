#import "GameLayer.h"
#import "drawSpace.h"
#import <UIKit/UIKit.h>
#import "Wall.h"
#import "MenuLayer.h"
#import "MathUtil.h"
#import "GameConfig.h"


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
  //  cpSpaceResizeStaticHash(_space, 400, 200);
    //cpSpaceResizeActiveHash(_space, 200, 200);
}




- (void)draw 
{
    drawSpaceOptions options = {
        0, // drawHash
        0, // drawBBs,
        1, // drawShapes
        0, // collisionPointSize
        1.0, // bodyPointSize,
        1.0 // lineThickness
    };
    
    drawSpace(_space, &options);
    
}


- (void) update: (ccTime) dt
{
    cpSpaceStep(_space, dt);
}

- (void) setupPauseButton
{
    CCDirector *director = [CCDirector sharedDirector];
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


- (id)init {
    if ((self = [super init])) {                
        _walls = [[NSMutableArray alloc] init];
        _balls = [[NSMutableArray alloc] init];
        _ballCount = BALL_COUNT;
        
  
        
        [self initSpace];
        [_walls addObjectsFromArray:[Wall initFrameForSpace:_space]];
        
        for(int i = 0; i< _ballCount; i++)
        {
            [_balls addObject:[Ball initAndAddToSpace:_space]];
        }
        
        [self scheduleUpdate];
        self.isTouchEnabled = YES;
        
        [self setupPauseButton  ];              
    }
    return self;
}  

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSSet *allTouches = [event allTouches];
    UITouch * touch = [[allTouches allObjects] objectAtIndex:0];
    CGPoint location = [touch locationInView: [touch view]];
    _firstTouch = [[CCDirector sharedDirector] convertToGL:location];
}

- (void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];
    UITouch * touch = [[allTouches allObjects] objectAtIndex:0];
    CGPoint location = [touch locationInView: [touch view]];
    _lastTouch = [[CCDirector sharedDirector] convertToGL:location];
    
    [_walls addObject: [Wall initAndAddToSpace:_space from:_firstTouch to:_lastTouch]];
    _firstTouch = _lastTouch;
}

- (void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
        

    
}



- (void)dealloc {
    cpSpaceFree(_space);
    [_balls release];
    [_walls release];
    [super dealloc];
}

@end
