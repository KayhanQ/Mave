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

@implementation NPCSpeech

@synthesize textToSpeak = _textToSpeak;
@synthesize displayName = _displayName;
@synthesize responses = _responses;
@synthesize condition = _condition;

- (id)initWithTBXMLElement:(TBXMLElement*)npcSpeechElement responses:(NSArray*)responses {
    if (self = [super init]) {
        _textToSpeak = [TBXML valueOfAttributeNamed:@"text" forElement:npcSpeechElement];
        _displayName = [TBXML valueOfAttributeNamed:@"displayName" forElement:npcSpeechElement];
        _responses = responses;
        _condition = nil;
        NSString* conditionString = [TBXML valueOfAttributeNamed:@"condition" forElement:npcSpeechElement];
        if (conditionString) _condition = [[Condition alloc] initWithString:conditionString];
    }
    return self;
}

- (id)initWithText:(NSString *)textToSpeak displayName:(NSString *)displayName responses:(NSArray *)responses condition:(Condition *)condition{
    if (self = [super init]) {
        _textToSpeak = textToSpeak;
        _displayName = displayName;
        _responses = responses;
        _condition = condition;
    }
    return self;
}



@end