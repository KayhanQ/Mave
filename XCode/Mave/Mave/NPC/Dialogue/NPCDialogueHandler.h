//
//  NPCDialogueHandler.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-16.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

@class NPC;
@class ConditionHandler;

@interface NPCDialogueHandler : SPSprite
{
    
}

@property(nonatomic, readonly) NPC* npc;

- (id)initWithNPC:(NPC*)npc conditionHandler:(ConditionHandler*)conditionHandler;
- (void)startDialogue;

@end