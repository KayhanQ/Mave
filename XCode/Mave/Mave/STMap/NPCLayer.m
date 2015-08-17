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
                return (Player*)npc;
            }
        }
    }
    return nil;
}

- (void)moveNPCTo:(STCoordinate*)coordinate {
    Player* player = [self getPlayer];
    int playerIndex = [self convertCoordinateToGID:player.coordinate];
    int destinationIndex = [self convertCoordinateToGID:coordinate];
    STTile* destTile = (STTile*) [_tiles childAtIndex:destinationIndex];
    
    [_tiles swapChildAtIndex:playerIndex withChildAtIndex:destinationIndex];
    
    STCoordinate* tmpCoordinate = [[STCoordinate alloc] initWithX:coordinate.x y:coordinate.y];
    destTile.coordinate = player.coordinate;
    player.coordinate = tmpCoordinate;
}


@end