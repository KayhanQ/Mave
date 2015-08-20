//
//  NPCLayer.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-17.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPCLayer.h"
#import "Player.h"
#import "STCoordinate.h"

@implementation NPCLayer


- (Player*)getPlayer {
    for (STTile* tile in _tiles) {
        if (tile.type == STCHARACTER) {
            NPC* npc = (NPC*)tile;
            if ([npc.npcID isEqualToString:@"player"]) {
                Player* player = (Player*)npc;
                return player;
            }
        }
    }
    return nil;
}




@end