//
//  setFinishTileFunctionalityEvent.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-09-17.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SetFinishTileFunctionalityEvent.h"

@implementation SetFinishTileFunctionalityEvent

@synthesize value = _value;
@synthesize nextLevelForFinishTile = _nextLevelForFinishTile;

- (id)initWithValue:(NSString *)value nextLevelForFinishTile:(NSString *)nextLevelForFinishTile
{
    if ((self = [super initWithType:EVENT_TYPE_SET_FINISH_TILE_FUNCTIONALITY]))
    {
        _value = value;
        _nextLevelForFinishTile = nextLevelForFinishTile;
    }
    return self;
}

@end