#import "GameLayer.h"
#import "drawSpace.h"


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

- (void) createWallFrom:(CGPoint)from to:(CGPoint)to
{
    cpBody *wallBody = cpBodyNewStatic();
    
    float radius = 10.0;
    cpShape *wallShape = cpSegmentShapeNew(wallBody, from, to, radius);    
    wallShape->e = .7;
    wallShape->u = 0;
    cpSpaceAddShape(_space, wallShape);
}

- (void)initFrame {    
    CGSize winSize = [CCDirector sharedDirector].winSize; 
    CGPoint lowerLeft = ccp(0, 0);
    CGPoint lowerRight = ccp(winSize.width, 0);
    CGPoint upperLeft = ccp(0, winSize.height);
    CGPoint upperRight = ccp(winSize.width, winSize.height);
    
    [self createWallFrom:lowerLeft to:lowerRight];
    [self createWallFrom:lowerLeft to:upperLeft];
    [self createWallFrom:lowerRight to:upperRight];
    [self createWallFrom:upperLeft to:upperRight];
}

- (void)draw {
    
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
    [_ball update];
}


- (id)init {
    if ((self = [super init])) {                
        CGSize winSize = [CCDirector sharedDirector].winSize;
        [self initSpace];
        [self initFrame];
        
        
        
        for(int i = 0; i< 10; i++){
        _ball = [[Ball alloc] initWithBounds: winSize];
            [_ball addToSpace: _space];}
        
        [self scheduleUpdate];
    }
    return self;
}  


- (void)dealloc {
    cpSpaceFree(_space);
    [super dealloc];
}

@end
