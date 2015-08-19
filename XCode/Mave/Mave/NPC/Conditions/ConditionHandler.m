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
#import "NPCSpeech.h"
#import "STCoordinate.h"

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
                    @"tileTriggered",
                    @"inPosition"];
}

- (BOOL)checkConditions:(NSArray*)conditions {
    for (Condition* condition in conditions) {
        if (!condition) return true;
        
        NSString* conditionString = condition.condition;
        int index = (int)[_conditions indexOfObject:conditionString];
        
        switch (index) {
            case 0:
            {
                Item* item = [[Item alloc] initWithName:[condition.values objectAtIndex:0]];
                if (![_player hasItem:item]) return false;
                break;
            }
            case 4:
            {
                int x = [condition.values[1] intValue];
                int y = [condition.values[2] intValue];
                STCoordinate* coordinate = [[STCoordinate alloc] initWithX:x y:y];
                
                if (![self tileHasCoordinates:_player coordinate:coordinate]) return false;

                break;
            }
            default:
                break;
        }
    }
    return true;
}

- (BOOL)tileHasCoordinates:(STTile*)tile coordinate:(STCoordinate*)coordinate {
    if (tile.coordinate.x == coordinate.x && tile.coordinate.y == coordinate.y) return true;
    return false;
}

@end