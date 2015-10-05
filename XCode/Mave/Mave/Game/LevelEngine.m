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

#import "Animator.h"


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
    
    NSMutableArray* _actionEvents;
    
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
    [container addChild:_map];
    _groundLayer = [_map layerByName:@"Ground"];
    _obstacleLayer = [_map layerByName:@"Obstacles"];
    STLayer* movableObstaclesLayer = [_map layerByName:@"MovableObstacles"];
    _characterLayer = (NPCLayer*)[_map layerByName:@"Characters"];

    HUD* hud = [[HUD alloc] init];
    [container addChild:hud];
    
    _dialogueSprite = [[SPSprite alloc] init];
    [container addChild:_dialogueSprite];
    
    container.scale = 0.8;
    _swipeGestureRecognizers = [[NSMutableArray alloc] init];
    
    _player = [_characterLayer getPlayer];
    _conditionHandler = [[ConditionHandler alloc] initWithNPCLayer:_characterLayer];
    
    _actionEvents = [[NSMutableArray alloc] init];
    
    [self addSwipeRecognizers];
    [self addEventListener:@selector(npcTouched:) atObject:self forType:EVENT_TYPE_NPC_TOUCHED];
    [self addEventListener:@selector(npcDialogueFinished:) atObject:self forType:EVENT_NPC_DIALOGUE_FINISHED];
    [self addEventListener:@selector(moveNPCWithIDEvent:) atObject:self forType:EVENT_TYPE_MOVE_NPC];
    [self addEventListener:@selector(giveItemEvent:) atObject:self forType:EVENT_TYPE_GIVE_ITEM];
    [self addEventListener:@selector(performActionEvents:) atObject:self forType:EVENT_TYPE_PERFORM_ACTION_EVENTS_EVENT];

    [self addEventListener:@selector(setCustomConditionEvent:) atObject:self forType:EVENT_TYPE_SET_CUSTOM_CONDITION];
    [self addEventListener:@selector(setFinishTileFunctionality:) atObject:self forType:EVENT_TYPE_SET_FINISH_TILE_FUNCTIONALITY];

    [self addEventListener:@selector(onEnterFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];

    [self addEventListener:@selector(moveTileCompleted:) atObject:self forType:EVENT_TYPE_MOVE_TILE_COMPLETED];

}

- (void)swipeInDirection:(UISwipeGestureRecognizerDirection)swipeDirection {
    Direction direction = [HelperFunctions directionFromUISwipeGestureRecognizerDirection:swipeDirection];
    MoveNPCEvent* event = [[MoveNPCEvent alloc] initWithNPCID:@"player" direction:direction];
    [_actionEvents addObject:event];
    [self performActionEvent];
    
    //[self moveTileInDirection:_player direction:direction];
}

- (void)moveTileInDirection:(STTile*)tile direction:(Direction)direction {
    [self stopGameInput];
    [_map moveTile:tile inDirection:direction];
    
    //map moves the tile

}

- (void)moveTileCompleted:(MoveTileCompletedEvent*)event {
    
    NSLog(@"move Tile completed");

    [self startGameInput];
    [self performActionEvent];
    
}

- (void)performActionEvents:(PerformActionEventsEvent*)event {
    [_actionEvents addObjectsFromArray:event.actionEvents];
    [self performActionEvent];
}

- (void)performActionEvent {
    if (_actionEvents.count > 0) {
        ActionEvent* event = [_actionEvents objectAtIndex:0];
        [_actionEvents removeObjectAtIndex:0];
        [self dispatchEvent:event];
        
        if (![event.type isEqual:EVENT_TYPE_MOVE_NPC]) {
            [self performActionEvent];
        }
    }
}

- (void)moveNPCWithIDEvent:(MoveNPCEvent*)event {
    NSString* npcID = event.npcID;
    Direction direction = event.direction;
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
    if ([_map getDistanceFromTiles:_player tile:npc] <= 9999) {
        [self startDialogue:npc];
    }
}

- (void)startDialogue:(NPC*)npc {
    NPCDialogueHandler* dialogueHandler = [[NPCDialogueHandler alloc] initWithNPC:npc conditionHandler:_conditionHandler];
    [_dialogueSprite addChild:dialogueHandler];
    [dialogueHandler startDialogue];
    
    [self stopGameInput];
}

- (void)npcDialogueFinished:(BasicEvent*)event {
    [_dialogueSprite removeAllChildren];
    [self startGameInput];
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

- (void)stopGameInput {
    _characterLayer.touchable = false;
    [self removeSwipeRecognizers];
}

- (void)startGameInput {
    _characterLayer.touchable = true;
    [self removeSwipeRecognizers];
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


- (void)onEnterFrame:(SPEnterFrameEvent *)event
{
    [self advanceTime:event.passedTime];
}

- (void)advanceTime:(double)seconds
{
    [[[Animator sharedAnimator] mainJuggler] advanceTime:seconds];
}

- (void)dealloc {
    [self removeSwipeRecognizers];
}
@end