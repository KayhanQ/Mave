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
#import "NPC.h"
#import "NPCSpeech.h"
#import "GameEvents.h"

@implementation NPCDialogueHandler
{
    SPSprite* _speechContainer;
}

@synthesize npc = _npc;

- (id)initWithNPC:(NPC *)npc {
    if (self = [super init]) {
        _npc = npc;
        _speechContainer = [[SPSprite alloc] init];
        [self addChild:_speechContainer];
        
        [self addEventListener:@selector(onTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        [self addEventListener:@selector(currentSpeechFinished:) atObject:self forType:EVENT_TYPE_NPCSPEECH_FINISHED];

    }
    return self;
}

- (void)playDialogue {
    NPCSpeechBox* speechBox = [[NPCSpeechBox alloc] initWithNPCSpeech:_npc.speeches[0]];
    [_speechContainer addChild:speechBox];
    
}

- (NPCSpeechBox*)getSpeechBox {
    if (_speechContainer.numChildren == 0) return nil;
    else return (NPCSpeechBox*) [_speechContainer childAtIndex:0];
}

- (void)onTouch:(SPTouchEvent*)event
{
    SPTouch *touchBegan = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] anyObject];
    if (touchBegan)
    {
        [[self getSpeechBox] loadNext];
    }
}

- (void)currentSpeechFinished:(NPCSpeechFinsihedEvent*)event {
    NPCSpeech* npcSpeech = event.npcSpeech;
    [self presentResponses: npcSpeech.responses];
}

- (void)presentResponses:(NSArray*)responses {
    
}


@end