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
#import "NPCDialogueHandler.h"
#import "ConditionHandler.h"

@interface LevelEngine ()
- (void)swipeLeft:(UISwipeGestureRecognizer *)gestureRecognizer;

@end

@implementation LevelEngine
{
    NSMutableArray* _swipeGestureRecognizers;
    STMap* _map;
    STLayer* _groundLayer;
    STLayer* _obstacleLayer;
    STLayer* _startAndEndLayer;
    NPCLayer* _characterLayer;
    Player* _player;
    SPSprite* _dialogueSprite;
    
    ConditionHandler* _conditionHandler;
}

@synthesize levelName = _levelName;

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
    _characterLayer = (NPCLayer*)[_map layerByName:@"Characters"];
    
    [container addChild:_groundLayer];
    [container addChild:_obstacleLayer];
    [container addChild:_startAndEndLayer];
    [container addChild:_characterLayer];

    _dialogueSprite = [[SPSprite alloc] init];
    [container addChild:_dialogueSprite];
    
    container.scale = 0.7;
    _swipeGestureRecognizers = [[NSMutableArray alloc] init];
    
    _player = [_characterLayer getPlayer];
    _conditionHandler = [ConditionHandler sharedConditionHandler];
    _conditionHandler.player = _player;
    
    
    [self addSwipeRecognizers];
    [self addEventListener:@selector(npcTouched:) atObject:self forType:EVENT_TYPE_NPC_TOUCHED];
    [self addEventListener:@selector(npcDialogueFinished:) atObject:self forType:EVENT_NPC_DIALOGUE_FINISHED];

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
    
    [_characterLayer moveNPCTo:coordinate];
    
    
    //TEMP collision says level completed
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

- (int)getDistanceFromTiles:(STTile*)tile1 tile:(STTile*)tile2 {
    int distx = abs(tile1.coordinate.x - tile2.coordinate.x);
    int disty = abs(tile1.coordinate.y - tile2.coordinate.y);
    return distx + disty;
}

- (void)npcTouched:(NPCTouchedEvent*)event {
    NPC* npc = event.npc;
    
    //set value to 1 to get real gameplay
    if ([self getDistanceFromTiles:_player tile:npc] <= 999999999) {
        [self startDialogue:npc];
    }
}

- (void)startDialogue:(NPC*)npc {
    NPCDialogueHandler* dialogueHandler = [[NPCDialogueHandler alloc] initWithNPC:npc];
    [_dialogueSprite addChild:dialogueHandler];
    [dialogueHandler startDialogue];
    
    _characterLayer.touchable = false;
    [self removeSwipeRecognizers];
}

- (void)npcDialogueFinished:(BasicEvent*)event {
    [_dialogueSprite removeAllChildren];
    _characterLayer.touchable = true;
    [self addSwipeRecognizers];
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

- (void)removeSwipeRecognizers {
    for (UISwipeGestureRecognizer* recognizer in _swipeGestureRecognizers) {
        [Sparrow.currentController.view removeGestureRecognizer:recognizer];
    }
}

- (void)swipeUp:(UISwipeGestureRecognizer *)gestureRecognizer
{
    [self swipeInDirection:UISwipeGestureRecognizerDirectionUp];
}

- (void)swipeRight:(UISwipeGestureRecognizer *)gestureRecognizer
{
    [self swipeInDirection:UISwipeGestureRecognizerDirectionRight];
}

- (void)swipeDown:(UISwipeGestureRecognizer *)gestureRecognizer
{
    [self swipeInDirection:UISwipeGestureRecognizerDirectionDown];
}

- (void)swipeLeft:(UISwipeGestureRecognizer *)gestureRecognizer
{
    [self swipeInDirection:UISwipeGestureRecognizerDirectionLeft];
}


- (void)dealloc {
    [self removeSwipeRecognizers];
}
@end