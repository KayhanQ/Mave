//
//  LevelCompletedEvent.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-09-17.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import "LevelEvent.h"

#define EVENT_TYPE_LEVEL_COMPLETED @"levelCompleted"

@interface LevelCompletedEvent : LevelEvent
{
    
}

@property(nonatomic, readonly)NSString* nextLevelName;

- (id)initWithCurrentLevelname:(NSString*)currentLevelName nextLevelName:(NSString*)nextLevelName;


@end