//
//  SetCustomConditionEvent.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-27.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SetCustomConditionEvent.h"

@implementation SetCustomConditionEvent

@synthesize conditionName = _conditionName;
@synthesize value = _value;

- (id)initWithConditionName:(NSString *)conditionName value:(NSString *)value
{
    if ((self = [super initWithType:EVENT_TYPE_SET_CUSTOM_CONDITION]))
    {
        _conditionName = conditionName;
        _value = value;
    }
    return self;
}

@end