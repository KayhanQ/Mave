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

- (void)loadLevel
{
    SPSprite* container = [[SPSprite alloc] init];
    [self addChild:container];
    
    
    _map = [[STMap alloc] initWithTMXFile:_levelName];
    _groundLayer = [_map layerByName:@"Ground"];
    _obstacleLayer = [_map layerByName:@"Obstacles"];
    _startAndEndLayer = [_map layerByName:@"StartAndEnd"];
    _characterLayer = [_map layerByName:@"Characters"];
    _map.zoom = 0.5;
    
    [container addChild:_groundLayer];
    [container addChild:_obstacleLayer];
    [container addChild:_startAndEndLayer];
    [container addChild:_characterLayer];

    _swipeGestureRecognizers = [[NSMutableArray alloc] initWithCapacity:1];
    
    _player = [_characterLayer getPlayer];
    

    [self addSwipeRecognizers];
}

- (void)addSwipeRecognizers
{
    
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
}

- (void)swipeRight:(UISwipeGestureRecognizer *)gestureRecognizer
{
    NSLog(@"detected swipe right");
}

- (void)swipeDown:(UISwipeGestureRecognizer *)gestureRecognizer
{
    NSLog(@"detected swipe down");
}

- (void)swipeLeft:(UISwipeGestureRecognizer *)gestureRecognizer
{
    NSLog(@"detected swipe left");
}
@end