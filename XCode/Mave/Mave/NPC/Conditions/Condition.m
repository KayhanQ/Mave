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

@synthesize condition = _condition;
@synthesize values = _values;

- (id)initWithString:(NSString *)string {
    if (self = [super init]) {
        NSArray* splitStrings = [string componentsSeparatedByString:@":"];
        _condition = [splitStrings objectAtIndex:0];
        
        NSArray* values = [[splitStrings objectAtIndex:1] componentsSeparatedByString:@","];
        NSMutableArray* mutableValues = [[NSMutableArray alloc] init];
        for (NSString* value in values) {
            [mutableValues addObject:value];
        }
        
        _values = mutableValues;
    }
    return self;
}

@end