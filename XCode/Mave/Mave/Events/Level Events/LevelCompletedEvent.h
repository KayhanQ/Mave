//
//  LevelCompletedEvent.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-15.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import "BasicEvent.h"

#define EVENT_TYPE_LEVEL_COMPLETED @"levelCompleted"

@interface LevelCompletedEvent : BasicEvent
{
    
}


- (id)initWithType:(NSString *)type;


@end