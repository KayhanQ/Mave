//
//  NPCSpeechBox.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-16.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPCSpeechBox.h"
#import "NPCSpeech.h"
#import "GameEvents.h"

@implementation NPCSpeechBox

@synthesize npcSpeech = _npcSpeech;

- (id)initWithNPCSpeech:(NPCSpeech *)npcSpeech {
    if (self = [super init]) {
        _npcSpeech = npcSpeech;
        
        SPTextField* speech = [SPTextField textFieldWithWidth:480 height:320 text: _npcSpeech.textToSpeak];
        speech.y = 200;
        [self addChild:speech];
        
        
    }
    return self;
}

- (void)loadNext {
    //here we will load the rest of the string if it is finished we call this
    NPCSpeechFinsihedEvent *event = [[NPCSpeechFinsihedEvent alloc] initWithNPCSpeech:_npcSpeech];
    [self dispatchEvent:event];
}

@end