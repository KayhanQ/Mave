//
//  PlayerAction.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-15.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPCSpeech.h"

@implementation NPCSpeech

@synthesize textToSpeak = _textToSpeak;
@synthesize displayName = _displayName;
@synthesize responses = _responses;
@synthesize condition = _condition;

- (id)initWithText:(NSString *)textToSpeak displayName:(NSString *)displayName responses:(NSArray *)responses condition:(Condition *)condition{
    if (self = [super initWithType:NPCSPEAK]) {
        _textToSpeak = textToSpeak;
        _displayName = displayName;
        _responses = responses;
        _condition = condition;
    }
    return self;
}



@end