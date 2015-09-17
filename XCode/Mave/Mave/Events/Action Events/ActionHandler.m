//
//  NPCTouchedEvent.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-16.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionHandler.h"
#import "MoveNPCEvent.h"
#import "GiveItemEvent.h"
#import "Item.h"
#import "SetCustomConditionEvent.h"
#import "SetFinishTileFunctionalityEvent.h"
#import "HelperFunctions.h"

@implementation ActionHandler
{
    
}

+ (ActionEvent*)makeActionEvent:(NSString*)string {
    NSArray* actions = @[@"moveNPC",
                    @"giveItem",
                         @"setCustomCondition",
                         @"setFinishTileFunctionality"
                         ];
    
    ActionEvent* actionEvent;
    NSArray* splitStrings = [string componentsSeparatedByString:@":"];
    NSString* action = [splitStrings objectAtIndex:0];
    
    NSArray* values = [[splitStrings objectAtIndex:1] componentsSeparatedByString:@","];
    
    int index = (int)[actions indexOfObject:action];
    switch (index) {
        case 0:
        {
            NSString*npcID = [values objectAtIndex:0];
            NSString* directionString = [values objectAtIndex:1];

            Direction direction = [HelperFunctions directionFromString:directionString];

            actionEvent = [[MoveNPCEvent alloc] initWithNPCID:npcID direction:direction];
            break;
        }
        case 1:
        {
            NSString* fromNPCID = [values objectAtIndex:0];
            NSString* toNPCID = [values objectAtIndex:1];
            NSString* itemName = [values objectAtIndex:2];

            Item* item = [[Item alloc] initWithName:itemName];
            actionEvent = [[GiveItemEvent alloc] initWithItem:item fromNPC:fromNPCID toNPC:toNPCID];
            break;
        }
        case 2:
        {
            NSString* conditionName = [values objectAtIndex:0];
            NSString* value = [values objectAtIndex:1];
            
            actionEvent = [[SetCustomConditionEvent alloc] initWithConditionName:conditionName value:value];
            break;
        }
        case 3:
        {
            NSString* nextLevel = [values objectAtIndex:0];
            NSString* value = [values objectAtIndex:1];
            
            actionEvent = [[SetFinishTileFunctionalityEvent alloc] initWithValue:value nextLevelForFinishTile:nextLevel];
            break;
        }
        default:
            break;
    }

    
    
    return actionEvent;
}


@end