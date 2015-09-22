//
//  LevelEngine.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-14.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LevelEngine.h"
#import "SparrowTiled.h"
#import "Player.h"
#import "GameEvents.h"
#import "NPCDialogueHandler.h"
#import "ConditionHandler.h"

#import "MoveNPCEvent.h"
#import "GiveItemEvent.h"
#import "SetCustomConditionEvent.h"
#import "SetFinishTileFunctionalityEvent.h"

#import "HUD.h"
#import "FinishTile.h"


@interface LevelEngine ()
- (void)swipeLeft:(UISwipeGestureRecognizer *)gestureRecognizer;

@end

@implementation LevelEngine
{
    NSMutableArray* _swipeGestureRecognizers;
    STMap* _map;
    STLayer* _groundLayer;
    STLayer* _obstacleLayer;
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
    
    NSString* folderPath = @"Assets/Levels/";
    folderPath = [folderPath stringByAppendingString:_levelName];
    folderPath = [folderPath stringByAppendingString:@"/"];
    NSString* filename = [_levelName lowercaseString];
    filename = [filename stringByAppendingString:@".tmx"];
    
    _map = [[STMap alloc] initWithLevelFolderPath:folderPath filename:filename];
    _groundLayer = [_map layerByName:@"Ground"];
    _obstacleLayer = [_map layerByName:@"Obstacles"];
    STLayer* movableObstaclesLayer = [_map layerByName:@"MovableObstacles"];
    _characterLayer = (NPCLayer*)[_map layerByName:@"Characters"];
    
    [container addChild:_groundLayer];
    [container addChild:_obstacleLayer];
    if (movableObstaclesLayer) [container addChild:movableObstaclesLayer];
    [container addChild:_characterLayer];

    HUD* hud = [[HUD alloc] init];
    [container addChild:hud];
    
    _dialogueSprite = [[SPSprite alloc] init];
    [container addChild:_dialogueSprite];
    
    container.scale = 0.8;
    _swipeGestureRecognizers = [[NSMutableArray alloc] init];
    
    _player = [_characterLayer getPlayer];
    _conditionHandler = [[ConditionHandler alloc] initWithNPCLayer:_characterLayer];
    
    
    
    [self addSwipeRecognizers];
    [self addEventListener:@selector(npcTouched:) atObject:self forType:EVENT_TYPE_NPC_TOUCHED];
    [self addEventListener:@selector(npcDialogueFinished:) atObject:self forType:EVENT_NPC_DIALOGUE_FINISHED];
    [self addEventListener:@selector(moveNPCWithIDEvent:) atObject:self forType:EVENT_TYPE_MOVE_NPC];
    [self addEventListener:@selector(giveItemEvent:) atObject:self forType:EVENT_TYPE_GIVE_ITEM];
    [self addEventListener:@selector(setCustomConditionEvent:) atObject:self forType:EVENT_TYPE_SET_CUSTOM_CONDITION];
    [self addEventListener:@selector(setFinishTileFunctionality:) atObject:self forType:EVENT_TYPE_SET_FINISH_TILE_FUNCTIONALITY];

}

- (void)swipeInDirection:(UISwipeGestureRecognizerDirection)swipeDirection {
    Direction direction = [HelperFunctions directionFromUISwipeGestureRecognizerDirection:swipeDirection];
    [self moveTileInDirection:_player direction:direction];
}

- (void)moveTileInDirection:(STTile*)tile direction:(Direction)direction {
    STTile* obstacle = [_map getTileClosestToTileInDirection:tile direction:direction];
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
    
    STLayer* layer = [_map getLayerWithTile:tile];
    [layer moveTileTo:tile coordinate:coordinate];
    

    switch (obstacle.type) {
        case STPUSHROCK:
        {
            [self moveTileInDirection:obstacle direction:direction];
            break;
        }
        case STHOLE:
        {
            if (tile.type == STPUSHROCK) {
                [_map removeTile:tile];
            }
            break;
        }
        default:
            break;
    }

    
    switch (obstacle.type) {
        case STSPIKES:
        {
            if (tile == _player) {
                LevelEvent *event = [[LevelEvent alloc] initWithType:EVENT_TYPE_LEVEL_COMPLETED];
                [self dispatchEvent:event];
            }
            break;
        }
        case STHOLE:
        {
            if (tile == _player) {
                LevelEvent *event = [[LevelEvent alloc] initWithType:EVENT_TYPE_LEVEL_LOST];
                [self dispatchEvent:event];
            }
            else {
                [_map removeTile:tile];
            }
            break;
        }
        case STFINISH:
        {
            FinishTile* finishTile = (FinishTile*)obstacle;
            if (finishTile.functional) {
                if (tile == _player) {
                    LevelCompletedEvent *event = [[LevelCompletedEvent alloc] initWithCurrentLevelname:_levelName nextLevelName:finishTile.nextLevelName];
                    [self dispatchEvent:event];
                }
                else {
                    [_map removeTile:tile];
                }
            }
            
            break;
        }
        default:
            break;
    }

}

- (STCoordinate*)getCoordinateForCollisionInDirection:(Direction)direction distance:(int)distance fromCoordinate:(STCoordinate*)coordinate {
    int x = coordinate.x;
    int y = coordinate.y;
    
    switch (direction) {
        case DirectionUp:
        {
            y += distance;
            break;
        }
        case DirectionRight:
        {
            x -= distance;
            break;
        }
        case DirectionDown:
        {
            y -= distance;
            break;
        }
        case DirectionLeft:
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


- (void)moveNPCWithIDEvent:(MoveNPCEvent*)event {
    NSString* npcID = event.npcID;
    UISwipeGestureRecognizerDirection direction = event.direction;
    NPC* npc = [_characterLayer getNPCWithID:npcID];
    [self moveTileInDirection:npc direction:direction];
}

- (void)setFinishTileFunctionality:(SetFinishTileFunctionalityEvent*)event {
    NSString* nextLevel = event.nextLevelForFinishTile;
    NSString* value = event.value;
    FinishTile* finishTile = [_obstacleLayer getFinishTileForNextLevel:nextLevel];
    if (!finishTile) return;
    finishTile.functional = value;
}


- (void)npcTouched:(NPCTouchedEvent*)event {
    NPC* npc = event.npc;
    
    //set value to 1 to get real gameplay
    if ([self getDistanceFromTiles:_player tile:npc] <= 999999) {
        [self startDialogue:npc];
    }
}

- (void)startDialogue:(NPC*)npc {
    NPCDialogueHandler* dialogueHandler = [[NPCDialogueHandler alloc] initWithNPC:npc conditionHandler:_conditionHandler];
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


- (void)giveItemEvent:(GiveItemEvent*)event {
    NPC* fromNPC = [_characterLayer getNPCWithID:event.fromNPCID];
    NPC* toNPC = [_characterLayer getNPCWithID:event.toNPCID];
    Item* item = event.item;
    
    [fromNPC giveItem:item toNPC:toNPC];
}

- (void)setCustomConditionEvent:(SetCustomConditionEvent*)event {
    [_conditionHandler setConditionWithName:event.conditionName toValue:event.value];
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