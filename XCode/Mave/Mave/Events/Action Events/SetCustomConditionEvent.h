//
//  SetCustomConditionEvent.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-27.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import "ActionEvent.h"
#import <Foundation/Foundation.h>

#define EVENT_TYPE_SET_CUSTOM_CONDITION @"setCustomCondition"


@interface SetCustomConditionEvent : ActionEvent
{
    
}

@property(nonatomic, readonly) NSString* conditionName;
@property(nonatomic, readonly) NSString* truthValue;

- (id)initWithConditionName:(NSString*)conditionName truthValue:(NSString*)truthValue;

@end