//
//  PlayerAction.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-15.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConditionHandler.h"
#import "Condition.h"
#import "Item.h"
#import "Player.h"

@implementation ConditionHandler
{
    NSArray* _conditions;
}

@synthesize player = _player;

#pragma mark Singleton Methods

+ (id)sharedConditionHandler {
    static ConditionHandler *sharedConditionHandler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedConditionHandler = [[self alloc] init];
    });
    return sharedConditionHandler;
}

- (id)init {
    if (self = [super init]) {
        [self loadConditions];
    }
    return self;
}

- (void)loadConditions {
    _conditions = @[@"hasItem",
                    @"levelProgress",
                    @"noItemsGreater",
                    @"tileTriggered"];
}

- (BOOL)checkCondition:(Condition*)condition {
    if (!condition) return true;
    
    NSString* conditionString = condition.condition;
    int index = (int)[_conditions indexOfObject:conditionString];
    
    switch (index) {
        case 0:
        {
            Item* item = [[Item alloc] initWithName:condition.value];
            return [_player hasItem:item];
            break;
        }
        default:
            break;
    }
    
    return false;
}

@end