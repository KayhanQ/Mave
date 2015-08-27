//
//  PlayerAction.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-15.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Condition.h"

@implementation Condition

@synthesize conditionType = _conditionType;
@synthesize values = _values;

- (id)initWithString:(NSString *)string {
    if (self = [super init]) {
        NSArray* splitStrings = [string componentsSeparatedByString:@":"];
        
        NSString* conditionString = [splitStrings objectAtIndex:0];
        _conditionType = [self getConditionTypeForString:conditionString];
        
        NSArray* values = [[splitStrings objectAtIndex:1] componentsSeparatedByString:@","];
        NSMutableArray* mutableValues = [[NSMutableArray alloc] init];
        for (NSString* value in values) {
            [mutableValues addObject:value];
        }
        
        _values = mutableValues;
    }
    return self;
}

- (enum ConditionType)getConditionTypeForString:(NSString*)conditionString {
    NSArray* conditionTypes = @[@"none",
                                @"hasItem",
                                @"levelProgress",
                                @"custom",
                                @"inPosition"];
    
    enum ConditionType conditionType;
    
    int index = (int)[conditionTypes indexOfObject:conditionString];
    
    switch (index) {
        case 1:
        {
            conditionType = CTHASITEM;
            break;
        }
        case 2:
        {
            conditionType = CTLEVELPROGRESS;
            break;
        }
        case 3:
        {
            conditionType = CTCUSTOM;
            break;
        }
        case 4:
        {
            conditionType = CTINPOSITION;
            break;
        }
        default:
        {
            conditionType = CTNONE;
            break;
        }
    }

    return conditionType;
}







@end