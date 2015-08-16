//
//  NPCTouchedEvent.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-16.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import "BasicEvent.h"

@class NPC;

#define EVENT_TYPE_NPC_TOUCHED @"npcTouched"

@interface NPCTouchedEvent : BasicEvent
{
    
}

@property(nonatomic) NPC* npc;

- (id)initWithNPC:(NPC*)npc;

@end