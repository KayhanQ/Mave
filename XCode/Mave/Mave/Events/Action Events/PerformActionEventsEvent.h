//
//  PerformActionEventsEvent.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-10-05.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import "BasicEvent.h"

#define EVENT_TYPE_PERFORM_ACTION_EVENTS_EVENT @"performActionEvents"

@interface PerformActionEventsEvent : BasicEvent
{
    
}

@property(nonatomic, readonly) NSArray* actionEvents;

- (id)initWithActionEvents:(NSArray*)actionEvents;

@end