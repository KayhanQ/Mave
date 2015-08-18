//
//  PlayerAction.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-15.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import "NPCAction.h"

@class NPCResponse;
@class Condition;

@interface NPCSpeech : NPCAction
{

}

@property(nonatomic, readonly) NSString* textToSpeak;
@property(nonatomic, readonly) NSString* displayName;
@property(nonatomic, readonly) NSArray* responses;
@property(nonatomic, readonly) Condition* condition;

- (id)initWithText:(NSString*)textToSpeak displayName:(NSString*)displayName responses:(NSArray*)responses condition:(Condition*)condition;

@end