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

@property(nonatomic)Player* player;
@property(nonatomic)NPCLayer* npcLayer;

+ (id)sharedConditionHandler;
- (id)init;
- (BOOL)checkConditions:(NSArray*)conditions;


@end
