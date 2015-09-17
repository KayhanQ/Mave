//
//  SetFinishTileFunctionalityEvent.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-09-17.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import "ActionEvent.h"

#define EVENT_TYPE_SET_FINISH_TILE_FUNCTIONALITY @"setFinishTileFunctionality"

@interface SetFinishTileFunctionalityEvent : ActionEvent
{
    
}

@property(nonatomic, readonly) NSString* nextLevelForFinishTile;
@property(nonatomic, readonly) NSString* value;

- (id)initWithValue:(NSString*)value nextLevelForFinishTile:(NSString*)nextLevelForFinishTile;

@end