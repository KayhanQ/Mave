//
//  LevelEngine.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-14.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LevelEngine.h"
#import "SparrowTiled.h"
#import <UIKit/UIKit.h>
#import "Player.h"
#import "GameEvents.h"

@interface LevelEngine ()
- (void)swipeLeft:(UISwipeGestureRecognizer *)gestureRecognizer;

@end

@implementation LevelEngine
{
    NSMutableArray* _swipeGestureRecognizers;
    
}

@synthesize levelName = _levelName;
@synthesize map = _map;
@synthesize groundLayer = _groundLayer;
@synthesize obstacleLayer = _obstacleLayer;
@synthesize startAndEndLayer = _startAndEndLayer;
@synthesize characterLayer = _characterLayer;
@synthesize player = _player;

- (id)initWithName:(NSString *)levelName
{
    if ((self = [super init])) {
        _levelName = levelName;
        
        [self loadLevel];
    }
    return self;
}

- (void)loadLevel {
    SPSprite* container = [[SPSprite alloc] init];
    [self addChild:container];
    
    
    _map = [[STMap alloc] initWithTMXFile:_levelName];
    _groundLayer = [_map layerByName:@"Ground"];
    _obstacleLayer = [_map layerByName:@"Obstacles"];
    _startAndEndLayer = [_map layerByName:@"StartAndEnd"];
    _characterLayer = [_map layerByName:@"Characters"];
    
    [container addChild:_groundLayer];
    [container addChild:_obstacleLayer];
    [container addChild:_startAndEndLayer];
    [container addChild:_characterLayer];

    container.scale = 0.7;
    _swipeGestureRecognizers = [[NSMutableArray alloc] initWithCapacity:1];
    
    
    _player = [_characterLayer getPlayer];
    [self addSwipeRecognizers];
}

- (void)swipeInDirection:(UISwipeGestureRecognizerDirection)direction {
    STTile* obstacle = [_map getTileClosestToTileInDirection:_player direction:direction];
    STCoordinate* coordinate;
    
    switch (obstacle.collisionType) {
        case STOPBEFORE:
        {
            coordinate = [self getCoordinateForCollisionInDirection:direction distance:1 fromCoordinate:obstacle.coordinate];
            break;
        }
        case STOPONTOPOF:
        {
            coordinate = obstacle.coordinate;
            break;
        }
        case KILL:
        {
            coordinate = obstacle.coordinate;
            break;
        }
        default:
            break;
    }
    
    _player.coordinate = coordinate;
    [_characterLayer redrawLayer];
    
    if (obstacle.type == STFINISH) {
        LevelCompletedEvent *event = [[LevelCompletedEvent alloc] initWithType:EVENT_TYPE_LEVEL_COMPLETED];
        [self dispatchEvent:event];
    }
}

- (STCoordinate*)getCoordinateForCollisionInDirection:(UISwipeGestureRecognizerDirection)direction distance:(int)distance fromCoordinate:(STCoordinate*)coordinate {
    int x = coordinate.x;
    int y = coordinate.y;
    
    switch (direction) {
        case UISwipeGestureRecognizerDirectionUp:
        {
            y += distance;
            break;
        }
        case UISwipeGestureRecognizerDirectionRight:
        {
            x -= distance;
            break;
        }
        case UISwipeGestureRecognizerDirectionDown:
        {
            y -= distance;
            break;
        }
        case UISwipeGestureRecognizerDirectionLeft:
        {
            x += distance;
            break;
        }
        default:
            break;
    }
    
    STCoordinate* result = [[STCoordinate alloc] initWithX:x y:y];
    return result;
}

- (void)addSwipeRecognizers {
    UISwipeGestureRecognizer *swipeUpRecognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeUp:)];
    swipeUpRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    [_swipeGestureRecognizers addObject:swipeUpRecognizer];
    
    UISwipeGestureRecognizer *swipeRightRecognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRight:)];
    swipeRightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [_swipeGestureRecognizers addObject:swipeRightRecognizer];

    UISwipeGestureRecognizer *swipeLDownRecognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDown:)];
    swipeLDownRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [_swipeGestureRecognizers addObject:swipeLDownRecognizer];

    UISwipeGestureRecognizer *swipeLeftRecognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeft:)];
    swipeLeftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [_swipeGestureRecognizers addObject:swipeLeftRecognizer];

    for (UISwipeGestureRecognizer* recognizer in _swipeGestureRecognizers) {
        [Sparrow.currentController.view addGestureRecognizer:recognizer];
    }
}

- (void)swipeUp:(UISwipeGestureRecognizer *)gestureRecognizer
{
    NSLog(@"detected swipe up");
    [self swipeInDirection:UISwipeGestureRecognizerDirectionUp];
}

- (void)swipeRight:(UISwipeGestureRecognizer *)gestureRecognizer
{
    NSLog(@"detected swipe right");
    [self swipeInDirection:UISwipeGestureRecognizerDirectionRight];
}

- (void)swipeDown:(UISwipeGestureRecognizer *)gestureRecognizer
{
    NSLog(@"detected swipe down");
    [self swipeInDirection:UISwipeGestureRecognizerDirectionDown];
}

- (void)swipeLeft:(UISwipeGestureRecognizer *)gestureRecognizer
{
    NSLog(@"detected swipe left");
    [self swipeInDirection:UISwipeGestureRecognizerDirectionLeft];
}

- (void)dealloc {
    for (UISwipeGestureRecognizer* recognizer in _swipeGestureRecognizers) {
        [Sparrow.currentController.view removeGestureRecognizer:recognizer];
    }
    
}
@end