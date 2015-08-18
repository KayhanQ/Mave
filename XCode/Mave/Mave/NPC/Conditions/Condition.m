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
@synthesize value = _value;

- (id)initWithString:(NSString *)string {
    if (self = [super init]) {
        NSArray* splitStrings = [string componentsSeparatedByString:@":"];
        _condition = [splitStrings objectAtIndex:0];
        _value = [splitStrings objectAtIndex:1];
    }
    return self;
}

@end