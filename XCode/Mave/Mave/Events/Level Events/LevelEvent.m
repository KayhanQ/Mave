//
//  LevelRestartEvent.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-09-13.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LevelEvent.h"

@implementation LevelEvent

@synthesize levelName = _levelName;

- (id)initWithType:(NSString *)type levelName:(NSString*)levelName;
{
    if ((self = [super initWithType:type bubbles:YES]))
    {
        _levelName = levelName;
    }
    return self;
}

@end