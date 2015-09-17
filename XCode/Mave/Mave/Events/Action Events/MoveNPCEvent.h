//
//  NPCTouchedEvent.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-16.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import "ActionEvent.h"
#import <Foundation/Foundation.h>
#import "HelperFunctions.h"

#define EVENT_TYPE_MOVE_NPC @"moveNPC"

@interface MoveNPCEvent : ActionEvent
{
    
}

@property(nonatomic, readonly) NSString* npcID;
@property(nonatomic, readonly) Direction direction;

- (id)initWithNPCID:(NSString*)npcID direction:(Direction)direction;

@end