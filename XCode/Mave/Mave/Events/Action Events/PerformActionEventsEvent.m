//
//  PerformActionEventsEvent.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-10-05.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PerformActionEventsEvent.h"

@implementation PerformActionEventsEvent

@synthesize actionEvents = _actionEvents;

- (id)initWithActionEvents:(NSArray*)actionEvents
{
    if ((self = [super initWithType:EVENT_TYPE_PERFORM_ACTION_EVENTS_EVENT]))
    {
        _actionEvents = [[NSArray alloc] initWithArray:actionEvents];
    }
    return self;
}

@end