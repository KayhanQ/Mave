//
//  TileMovedEvent.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-09-30.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import "BasicEvent.h"

#define EVENT_TYPE_MOVE_TILE_COMPLETED @"moveTileCompleted"

@class STTile;

@interface MoveTileCompletedEvent : BasicEvent
{
    
}

@property(nonatomic, readonly) STTile* tile;

- (id)initWithTile:(STTile*)tile;

@end