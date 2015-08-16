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

@synthesize responses = _responses;
@synthesize textToSpeak = _textToSpeak;

- (id)initWithText:(NSString *)textToSpeak responses:(NSArray *)responses {
    if (self = [super initWithType:NPCSPEAK]) {
        _textToSpeak = textToSpeak;
        _responses = responses;
        
    }
    return self;
}



@end