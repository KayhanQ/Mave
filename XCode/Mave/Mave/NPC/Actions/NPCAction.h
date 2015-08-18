//
//  PlayerAction.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-15.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

@interface NPCAction : NSObject
{
    enum NPCActionType {NPCMOVE = 0, NPCSPEAK, NPCWAIT};
}

@property(nonatomic) enum NPCActionType type;


- (id)initWithType:(enum NPCActionType)type;
- (void)performAction;


@end
