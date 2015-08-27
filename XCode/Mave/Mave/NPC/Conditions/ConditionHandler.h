//
//  PlayerAction.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-15.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

@class Player;
@class Condition;
@class NPCSpeech;
@class NPCLayer;

@interface ConditionHandler : NSObject
{
}

- (id)initWithNPCLayer:(NPCLayer*)npcLayer;
- (BOOL)checkConditions:(NSArray*)conditions;


@end
