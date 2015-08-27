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
    NSMutableDictionary* _customConditions;
}

- (id)initWithNPCLayer:(NPCLayer *)npcLayer {
    if (self = [super init]) {
        _npcLayer = npcLayer;
        _player = [npcLayer getPlayer];
        
        _customConditions = [self getCustomConditions];
    }
    return self;
}

- (NSMutableDictionary*)getCustomConditions{
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    for (NPC* npc in [_npcLayer getAllNPCs]) {
        NSArray* allConditions = [npc getAllConditions];
        for (Condition* condition in allConditions) {
            if (condition.conditionType == CTCUSTOM) {
                [dictionary setObject:[NSString stringWithFormat:@"false"] forKey:condition.values[0]];
            }
        }
    }
    return dictionary;
}

- (BOOL)customConditionForNameTrue:(NSString*)name {
    return [[_customConditions objectForKey:name] isEqualToString:@"true"];
}

- (BOOL)checkConditions:(NSArray*)conditions {
    for (Condition* condition in conditions) {
        if (!condition) return true;
        
        switch (condition.conditionType) {
            case CTHASITEM:
            {
                NPC* npc = [_npcLayer getNPCWithID:[condition.values objectAtIndex:0]];
                Item* item = [[Item alloc] initWithName:[condition.values objectAtIndex:1]];
                if (![npc hasItemWithName:item.itemName]) return false;
                break;
            }
            case CTCUSTOM:
            {
                NSString* name = [condition.values objectAtIndex:0];
                NSString* value = [condition.values objectAtIndex:1];

                if (![[_customConditions objectForKey:name] isEqualToString:value]) return false;
                break;
            }
            case CTINPOSITION:
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