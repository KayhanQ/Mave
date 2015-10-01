//
//  TileMovedEvent.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-09-30.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoveTileCompletedEvent.h"

@implementation MoveTileCompletedEvent

@synthesize tile = _tile;

- (id)initWithTile:(STTile *)tile
{
    if ((self = [super initWithType:EVENT_TYPE_MOVE_TILE_COMPLETED]))
    {
        _tile = tile;
    }
    return self;
}

@end