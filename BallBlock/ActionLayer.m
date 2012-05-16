#import "ActionLayer.h"
#import "drawSpace.h"


@implementation ActionLayer


+ (id)scene {
    CCScene *scene = [CCScene node];
    ActionLayer *layer = [ActionLayer node];
    [scene addChild:layer];
    return scene;
}


- (void) initSpace {
    space = cpSpaceNew();
  //  space->gravity = ccp(0, -750);
    cpSpaceResizeStaticHash(space, 400, 200);
    cpSpaceResizeActiveHash(space, 200, 200);
}

- (void) createWallFrom:(CGPoint)from to:(CGPoint)to
{
    cpBody *wallBody = cpBodyNewStatic();
    
    float radius = 10.0;
    cpShape *wallShape = cpSegmentShapeNew(wallBody, from, to, radius);    
    wallShape->e = 0.5;
    wallShape->u = 1;
    cpSpaceAddShape(space, wallShape);
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
    
    drawSpace(space, &options);
    
}

- (void)initBall
{
    ballBody = cpBodyNew(100, INFINITY);      
    ballBody->p = cpv(160,250);
    ballBody->f = cpv(159,250);
    
    cpSpaceAddBody(space, ballBody);  
        
    float r = 10;
    cpShape *ballShape = cpCircleShapeNew(ballBody, r, cpvzero);  
    ballShape->e = 1;      
    ballShape->u = 1; 
    ballShape->collision_type = 1;     
    cpSpaceAddShape(space, ballShape);  
}

- (void) update: (ccTime) dt
{
    cpSpaceStep(space, dt);
}


- (id)init {
    if ((self = [super init])) {                
        [self initSpace];
        [self initFrame];
        [self initBall];
        [self scheduleUpdate];
    }
    return self;
}  


- (void)dealloc {
    cpSpaceFree(space);
    [super dealloc];
}

@end