//
//  LevelRestartEvent.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-09-13.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import "BasicEvent.h"

#define EVENT_TYPE_LEVEL_RESTART @"levelRestart"
#define EVENT_TYPE_LEVEL_LOST @"levelLost"
#define EVENT_TYPE_LEVEL_COMPLETED @"levelCompleted"

@interface LevelEvent : BasicEvent
{
    
}

@property(nonatomic, readonly) NSString* levelName;


- (id)initWithType:(NSString *)type levelName:(NSString*)levelName;


@end