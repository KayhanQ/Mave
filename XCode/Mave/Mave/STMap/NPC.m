//
//  Person.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-14.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPC.h"
#import "GameEvents.h"
#import "TBXML.h"
#import "NPCSpeech.h"
#import "Response.h"

@implementation NPC

@synthesize filename = _filename;
@synthesize npcID = _npcID;
@synthesize displayName = _displayName;
@synthesize speeches = _speeches;

- (id)initWithType:(enum STType)type texture:(SPTexture *)texture coordinate:(STCoordinate *)coordinate dialogueFileName:(NSString *)filename {
    if (self = [super initWithType:type texture:texture coordinate:coordinate]) {
        
        SPImage* image = [SPImage imageWithTexture:texture];
        [self addChild:image];
        
        _speeches = [[NSMutableArray alloc] init];
        
        [self loadXMLFile:filename];
        
        [self addEventListener:@selector(onTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    }
    return self;
}

- (void)loadXMLFile:(NSString *)filename {
    TBXML *xml = [[TBXML alloc] initWithXMLFile:filename];
    [self parseXMLData:xml];
}

- (void)parseXMLData:(TBXML *)xml {
    TBXMLElement *npcElement = xml.rootXMLElement;
    if (!npcElement) [self raiseXMLError:ST_EXC_FILE_NOT_FOUND message:@"file doesn't exist or is unreadable"];
    
    [self setNPCProperties:npcElement];
    
    TBXMLElement *npcSpeechElement = [TBXML childElementNamed:@"npcSpeech" parentElement:npcElement];
    if (!npcSpeechElement) [self raiseXMLError:ST_EXC_ELEMENT_NOT_FOUND message:@"\"npcSpeech\" element doesn't exist"];
    NPCSpeech* npcSpeech = [self loadNPCSpeechTreeWithNode:npcSpeechElement];
    [_speeches addObject:npcSpeech];
    
}

- (void)setNPCProperties:(TBXMLElement *)npcElement {
    _npcID = [TBXML valueOfAttributeNamed:@"npcID" forElement:npcElement];
    _npcID = [TBXML valueOfAttributeNamed:@"displayName" forElement:npcElement];
}

- (NPCSpeech*)loadNPCSpeechTreeWithNode:(TBXMLElement*)npcSpeechElement {
    TBXMLElement *responseElement = [TBXML childElementNamed:@"response" parentElement:npcSpeechElement];
    if (!responseElement) [self raiseXMLError:ST_EXC_ELEMENT_NOT_FOUND message:@"\"responseElement\" element doesn't exist"];
    NSMutableArray* responses = [[NSMutableArray alloc] init];
    while (responseElement) {
        //recursive call
        TBXMLElement *nextNPCSpeechElement = [TBXML childElementNamed:@"npcSpeech" parentElement:responseElement];
        NPCSpeech* nextNPCSpeech = [self loadNPCSpeechTreeWithNode:nextNPCSpeechElement];
        
        NSString* responseString = [TBXML valueOfAttributeNamed:@"text" forElement:responseElement];
        Response* response = [[Response alloc] initWithTextToRespondWith:responseString npcSpeech:nextNPCSpeech];
        
        [responses addObject:response];
        
        responseElement = [TBXML nextSiblingNamed:@"response" searchFromElement:responseElement];
    }
    
    NSArray* allResponses = [[NSArray alloc] initWithArray:responses];
    NSString* speechString = [TBXML valueOfAttributeNamed:@"text" forElement:npcSpeechElement];
    NPCSpeech* npcSpeech = [[NPCSpeech alloc] initWithText:speechString responses:allResponses];
    
    return npcSpeech;
}

- (void)raiseXMLError:(NSString *)error message:(NSString *)message {
    [NSException raise:error format:[NSString stringWithFormat:@"Error while reading \"%@\", %@.", _filename, message], NSStringFromSelector(_cmd)];
}


- (void)onTouch:(SPTouchEvent*)event
{
    SPTouch *touchEnded = [[event touchesWithTarget:self andPhase:SPTouchPhaseEnded] anyObject];
    if (touchEnded)
    {
        NPCTouchedEvent *event = [[NPCTouchedEvent alloc] initWithNPC:self];
        [self dispatchEvent:event];
    }
}

- (void)dealloc {
    [self removeEventListener:@selector(onTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
}

@end