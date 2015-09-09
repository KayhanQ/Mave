//
//  LevelLostEvent.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-09-04.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LevelLostEvent.h"

@implementation LevelLostEvent

- (id)initLevelLost
{
    if ((self = [super initWithType:EVENT_TYPE_LEVEL_LOST bubbles:YES]))
    {
        
    }
    return self;
}

@end