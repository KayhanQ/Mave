//
//  PlayerAction.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-15.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import "TBXML.h"

@class NPCResponse;
@class Condition;

@interface NPCSpeech : NSObject
{

}

@property(nonatomic, readonly) NSString* textToSpeak;
@property(nonatomic, readonly) NSString* displayName;
@property(nonatomic, readonly) NSArray* responses;
@property(nonatomic, readonly) NSArray* conditions;
@property(nonatomic, readonly) NSArray* actionEvents;

- (id)initWithTBXMLElement:(TBXMLElement*)npcSpeechElement responses:(NSArray*)responses;
- (id)initWithText:(NSString*)textToSpeak displayName:(NSString*)displayName responses:(NSArray*)responses condition:(Condition*)condition;

@end