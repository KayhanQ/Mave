//
//  PlayerAction.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-15.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPCSpeech.h"
#import "Condition.h"
#import "ActionEvent.h"
#import "ActionHandler.h"

@implementation NPCSpeech

@synthesize textToSpeak = _textToSpeak;
@synthesize displayName = _displayName;
@synthesize responses = _responses;
@synthesize conditions = _conditions;
@synthesize actionEvents = _actionEvents;
@synthesize maxPlayCount = _maxPlayCount;
@synthesize playCount = _playCount;

- (id)initWithTBXMLElement:(TBXMLElement*)npcSpeechElement responses:(NSArray*)responses {
    if (self = [super init]) {
        _textToSpeak = [TBXML valueOfAttributeNamed:@"text" forElement:npcSpeechElement];
        _displayName = [TBXML valueOfAttributeNamed:@"displayName" forElement:npcSpeechElement];
        _maxPlayCount = [[TBXML valueOfAttributeNamed:@"maxPlayCount" forElement:npcSpeechElement] intValue];
        _playCount = 0;
        _responses = responses;
        
        NSMutableArray* mutableConditions = [[NSMutableArray alloc] init];
        for (NSString* conditionString in [self getValuesForString:npcSpeechElement forAttribute:@"conditions"]) {
            if (conditionString) [mutableConditions addObject:[[Condition alloc] initWithString:conditionString]];
        }
        _conditions = mutableConditions;
        
        NSMutableArray* mutableActions = [[NSMutableArray alloc] init];
        for (NSString* actionEventString in [self getValuesForString:npcSpeechElement forAttribute:@"actions"]) {
            if (actionEventString) {
                [mutableActions addObject:[ActionHandler makeActionEvent:actionEventString]];
            }
        }
        _actionEvents = mutableActions;
        
    }
    return self;
}

- (NSArray*)getValuesForString:(TBXMLElement*)npcSpeechElement forAttribute:(NSString*)attribute {
    NSString* unparsedString = [TBXML valueOfAttributeNamed:attribute forElement:npcSpeechElement];
    NSArray* values = [unparsedString componentsSeparatedByString:@"|"];
    return values;
}


- (id)initWithText:(NSString *)textToSpeak displayName:(NSString *)displayName responses:(NSArray *)responses condition:(Condition *)condition{
    if (self = [super init]) {
        _textToSpeak = textToSpeak;
        _displayName = displayName;
        _responses = responses;
        //_condition = condition;
    }
    return self;
}



@end