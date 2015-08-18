//
//  NPCDialogueHandler.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-16.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPCDialogueHandler.h"
#import "NPCSpeechBox.h"
#import "NPCResponse.h"
#import "NPCResponseBox.h"
#import "NPC.h"
#import "NPCSpeech.h"
#import "GameEvents.h"
#import "ConditionHandler.h"

@implementation NPCDialogueHandler
{
    SPSprite* _speechContainer;
    ConditionHandler* _conditionHandler;
}

@synthesize npc = _npc;

- (id)initWithNPC:(NPC *)npc {
    if (self = [super init]) {
        _npc = npc;
        _conditionHandler = [ConditionHandler sharedConditionHandler];
        
        _speechContainer = [[SPSprite alloc] init];
        [self addChild:_speechContainer];
        
        [self addEventListener:@selector(currentSpeechFinished:) atObject:self forType:EVENT_TYPE_NPCSPEECH_FINISHED];
        [self addEventListener:@selector(responseClicked:) atObject:self forType:EVENT_TYPE_NPCRESPONSE_CLICKED];

    }
    return self;
}

- (void)startDialogue {
    [self presentSpeechBoxWithNPCSpeech:_npc.speeches[0]];
}

- (void)presentSpeechBoxWithNPCSpeech:(NPCSpeech*)npcSpeech {
    NPCSpeechBox* speechBox = [[NPCSpeechBox alloc] initWithNPCSpeech:npcSpeech];
    [_speechContainer addChild:speechBox];
}

- (NPCSpeechBox*)getSpeechBox {
    if (_speechContainer.numChildren == 0) return nil;
    else return (NPCSpeechBox*) [_speechContainer childAtIndex:0];
}

- (void)currentSpeechFinished:(NPCSpeechFinsihedEvent*)event {
    NPCSpeech* npcSpeech = event.npcSpeech;
    if ([self npcSpeechIsTerminatingSpeech:npcSpeech]) [self endDialogue];
    else [self presentResponses: npcSpeech.responses];
}

- (void)presentResponses:(NSArray*)responses {
    [self getSpeechBox].touchable = false;
    int y = 200;
    for (NPCResponse* response in responses) {
        NPCResponseBox* responceBox = [[NPCResponseBox alloc] initWithResponse:response];
        [_speechContainer addChild:responceBox];
        responceBox.y = y;
        y += 40;
    }
}

- (void)responseClicked:(NPCResponseClickedEvent*)event {
    [self clearDialogue];
    NPCResponse* response = event.npcResponse;
    //carry out any response related actions
    
    NPCSpeech* nextSpeech = response.npcSpeech;
    if (nextSpeech) {
        if ([_conditionHandler checkCondition:nextSpeech.condition]) [self presentSpeechBoxWithNPCSpeech:nextSpeech];
        else [self endDialogue];
    }
    else [self endDialogue];
}

- (void)clearDialogue {
    [_speechContainer removeAllChildren];
    
}

- (void)endDialogue {
    [self clearDialogue];
    BasicEvent *event = [[BasicEvent alloc] initWithType:EVENT_NPC_DIALOGUE_FINISHED];
    [self dispatchEvent:event];
}

- (BOOL)npcSpeechIsTerminatingSpeech:(NPCSpeech*)npcSpeech {
    for (NPCResponse* responce in npcSpeech.responses) {
        if (responce.textToRespondWith == nil) return true;
    }
    return false;
}


@end