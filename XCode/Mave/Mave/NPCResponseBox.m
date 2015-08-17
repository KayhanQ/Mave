//
//  NPCSpeechBox.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-16.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPCResponseBox.h"
#import "NPCSpeech.h"
#import "NPCResponse.h"
#import "GameEvents.h"

@implementation NPCResponseBox

@synthesize npcResponse = _npcResponse;

- (id)initWithResponse:(NPCResponse *)npcResponse {
    if (self = [super init]) {
        _npcResponse = npcResponse;
        
        SPQuad* background = [SPQuad quadWithWidth:100 height:40];
        [self addChild:background];
        
        SPTextField* response = [SPTextField textFieldWithWidth:100 height:40 text: _npcResponse.textToRespondWith];
        [self addChild:response];
        
        [self addEventListener:@selector(onTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    }
    return self;
}

- (void)onTouch:(SPTouchEvent*)event
{
    SPTouch *touchBegan = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] anyObject];
    if (touchBegan)
    {
        //tell the dialogue handler which response was chosen
        NPCResponseClickedEvent *event = [[NPCResponseClickedEvent alloc] initWithNPCResponse:_npcResponse];
        [self dispatchEvent:event];
    }
}



@end