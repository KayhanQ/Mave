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
        
        SPQuad* background = [SPQuad quadWithWidth:400 height:40];
        [self addChild:background];
        
        SPTextField* speech = [SPTextField textFieldWithWidth:480 height:40 text: _npcSpeech.textToSpeak];
        [self addChild:speech];
        
        [self addEventListener:@selector(onTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    }
    return self;
}

- (void)onTouch:(SPTouchEvent*)event
{
    SPTouch *touchBegan = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] anyObject];
    if (touchBegan)
    {
        [self loadNext];
    }
}

- (void)loadNext {
    //here we will load the rest of the string if it is finished we call this
    NPCSpeechFinsihedEvent *event = [[NPCSpeechFinsihedEvent alloc] initWithNPCSpeech:_npcSpeech];
    [self dispatchEvent:event];
}


@end