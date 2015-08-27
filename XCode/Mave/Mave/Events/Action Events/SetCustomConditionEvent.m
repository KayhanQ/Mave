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
@synthesize truthValue = _truthValue;

- (id)initWithConditionName:(NSString *)conditionName truthValue:(NSString *)truthValue
{
    if ((self = [super initWithType:EVENT_TYPE_SET_CUSTOM_CONDITION]))
    {
        _conditionName = conditionName;
        _truthValue = truthValue;
    }
    return self;
}

@end