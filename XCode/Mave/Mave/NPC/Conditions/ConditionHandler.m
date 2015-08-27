//
//  PlayerAction.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-15.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConditionHandler.h"
#import "Condition.h"
#import "Item.h"
#import "Player.h"
#import "NPCSpeech.h"
#import "STCoordinate.h"
#import "NPC.h"
#import "NPCLayer.h"

@implementation ConditionHandler
{
    NPCLayer* _npcLayer;
    Player* _player;
    NSArray* _conditionTypes;
    NSArray* _customConditions;
}

- (id)initWithNPCLayer:(NPCLayer *)npcLayer {
    if (self = [super init]) {
        _npcLayer = npcLayer;
        _player = [npcLayer getPlayer];
        
        _customConditions = [self getCustomConditions];
    }
    return self;
}

- (NSArray*)getCustomConditions {
    NSMutableArray* array = [[NSMutableArray alloc] init];
    for (NPC* npc in [_npcLayer getAllNPCs]) {
        [array addObject:[npc getCustomConditions]];
    }
    return array;
}

- (void)loadConditions {
    _conditionTypes = @[@"hasItem",
                    @"levelProgress",
                    @"custom",
                    @"tileTriggered",
                    @"inPosition"];
}

- (BOOL)checkConditions:(NSArray*)conditions {
    for (Condition* condition in conditions) {
        if (!condition) return true;
        
        NSString* conditionString = condition.condition;
        int index = (int)[_conditionTypes indexOfObject:conditionString];
        
        switch (index) {
            case 0:
            {
                NPC* npc = [_npcLayer getNPCWithID:[condition.values objectAtIndex:0]];
                Item* item = [[Item alloc] initWithName:[condition.values objectAtIndex:1]];
                if (![npc hasItemWithName:item.itemName]) return false;
                break;
            }
            case 2:
            {
                
                break;
            }
            case 4:
            {
                int x = [condition.values[1] intValue];
                int y = [condition.values[2] intValue];
                STCoordinate* coordinate = [[STCoordinate alloc] initWithX:x y:y];
                
                if (![self tileHasCoordinates:_player coordinate:coordinate]) return false;

                break;
            }
            default:
                break;
        }
    }
    return true;
}

- (BOOL)tileHasCoordinates:(STTile*)tile coordinate:(STCoordinate*)coordinate {
    if (tile.coordinate.x == coordinate.x && tile.coordinate.y == coordinate.y) return true;
    return false;
}

@end