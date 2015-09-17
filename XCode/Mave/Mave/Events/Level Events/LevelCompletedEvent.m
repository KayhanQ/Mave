//
//  LevelCompletedEvent.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-09-17.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LevelCompletedEvent.h"

@implementation LevelCompletedEvent

@synthesize nextLevelName = _nextLevelName;

- (id)initWithCurrentLevelname:(NSString *)currentLevelName nextLevelName:(NSString *)nextLevelName
{
    if ((self = [super initWithType:EVENT_TYPE_LEVEL_COMPLETED levelName:currentLevelName]))
    {
        _nextLevelName = nextLevelName;
    }
    return self;
}

@end