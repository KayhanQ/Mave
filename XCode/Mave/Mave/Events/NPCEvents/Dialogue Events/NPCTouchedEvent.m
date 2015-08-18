//
//  NPCTouchedEvent.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-16.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPCTouchedEvent.h"
#import "NPC.h"

@implementation NPCTouchedEvent

@synthesize npc = _npc;

- (id)initWithNPC:(NPC *)npc
{
    if ((self = [super initWithType:EVENT_TYPE_NPC_TOUCHED bubbles:YES]))
    {
        _npc = npc;
    }
    return self;
}

@end