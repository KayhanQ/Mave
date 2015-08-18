//
//  PlayerAction.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-15.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

@class Player;
@class Condition;

@interface ConditionHandler : NSObject
{
}

@property(nonatomic)Player* player;

+ (id)sharedConditionHandler;
- (id)init;
- (BOOL)checkCondition:(Condition*)condition;


@end
