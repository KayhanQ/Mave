//
//  LevelCompletedEvent.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-15.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import "BaseEvent.h"

#define EVENT_TYPE_LEVEL_COMPLETED @"levelCompleted"

@interface LevelCompletedEvent : BaseEvent
{
    
}


- (id)initWithType:(NSString *)type;


@end