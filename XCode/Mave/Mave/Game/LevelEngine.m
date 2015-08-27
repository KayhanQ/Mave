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
#import "MoveNPCEvent.h"
#import "GiveItemEvent.h"

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
    _characterLayer = (NPCLayer*)[_map layerByName:@"Characters"];
    
    [container addChild:_groundLayer];
    [container addChild:_obstacleLayer];
    [container addChild:_characterLayer];

    _dialogueSprite = [[SPSprite alloc] init];
    [container addChild:_dialogueSprite];
    
    container.scale = 0.7;
    _swipeGestureRecognizers = [[NSMutableArray alloc] init];
    
    _player = [_characterLayer getPlayer];
    _conditionHandler = [[ConditionHandler alloc] initWithNPCLayer:_characterLayer];
    
    [self addSwipeRecognizers];
    [self addEventListener:@selector(npcTouched:) atObject:self forType:EVENT_TYPE_NPC_TOUCHED];
    [self addEventListener:@selector(npcDialogueFinished:) atObject:self forType:EVENT_NPC_DIALOGUE_FINISHED];
    [self addEventListener:@selector(moveNPCWithIDEvent:) atObject:self forType:EVENT_TYPE_MOVE_NPC];
    [self addEventListener:@selector(giveItemEvent:) atObject:self forType:EVENT_TYPE_GIVE_ITEM];

}

- (void)swipeInDirection:(UISwipeGestureRecognizerDirection)direction {
    [self moveTileInDirection:_player direction:direction];
}

- (void)moveTileInDirection:(STTile*)tile direction:(UISwipeGestureRecognizerDirection)direction {
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
        default:
            break;
    }

    
    if (tile == _player) {
        switch (obstacle.type) {
            case STSPIKES:
            {
                LevelCompletedEvent *event = [[LevelCompletedEvent alloc] initWithType:EVENT_TYPE_LEVEL_COMPLETED];
                [self dispatchEvent:event];
                break;
            }
            case STFINISH:
            {
                LevelCompletedEvent *event = [[LevelCompletedEvent alloc] initWithType:EVENT_TYPE_LEVEL_COMPLETED];
                [self dispatchEvent:event];
                break;
            }
            default:
                break;
        }
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


- (void)moveNPCWithIDEvent:(MoveNPCEvent*)event {
    NSString* npcID = event.npcID;
    UISwipeGestureRecognizerDirection direction = event.direction;
    NPC* npc = [_characterLayer getNPCWithID:npcID];
    [self moveTileInDirection:npc direction:direction];
}


- (void)npcTouched:(NPCTouchedEvent*)event {
    NPC* npc = event.npc;
    
    //set value to 1 to get real gameplay
    if ([self getDistanceFromTiles:_player tile:npc] <= 999999999) {
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