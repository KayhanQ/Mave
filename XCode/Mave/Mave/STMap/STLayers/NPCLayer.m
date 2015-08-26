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
        if (tile.type == STPLAYER) {
            Player* player = (Player*)tile;
            return player;
        }
    }
    return nil;
}

- (NPC*)getNPCWithID:(NSString*)npcID {
    NPC* matchedNPC;
    for (STTile* tile in _tiles) {
        if (tile.type == STNPC || tile.type == STPLAYER) {
            NPC* npc = (NPC*)tile;
            if ([npc npcIDEquals:npcID]) matchedNPC = npc;
        }
    }
    return matchedNPC;
}


@end