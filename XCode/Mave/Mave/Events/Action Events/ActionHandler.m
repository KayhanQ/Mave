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

@implementation ActionHandler
{
    
}

+ (ActionEvent*)makeActionEvent:(NSString*)string {
    NSArray* actions = @[@"moveNPC",
                    @"giveItem"
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
            UISwipeGestureRecognizerDirection direction;
            
            if ([directionString isEqualToString:@"up"]) direction = UISwipeGestureRecognizerDirectionUp;
            else if ([directionString isEqualToString:@"right"]) direction = UISwipeGestureRecognizerDirectionRight;
            else if ([directionString isEqualToString:@"down"]) direction = UISwipeGestureRecognizerDirectionDown;
            else if ([directionString isEqualToString:@"left"]) direction = UISwipeGestureRecognizerDirectionLeft;

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
        default:
            break;
    }

    
    
    return actionEvent;
}


@end