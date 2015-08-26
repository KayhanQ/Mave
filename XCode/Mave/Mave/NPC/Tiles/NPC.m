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
#import "NPCSpeech.h"
#import "NPCResponse.h"
#import "Condition.h"
#import "Item.h"

@implementation NPC
{
    NSMutableArray* _items;
}

@synthesize filename = _filename;
@synthesize npcID = _npcID;
@synthesize displayName = _displayName;
@synthesize speeches = _speeches;

- (id)initWithType:(enum STType)type texture:(SPTexture *)texture coordinate:(STCoordinate *)coordinate filename:(NSString *)filename {
    if (self = [super initWithType:type texture:texture coordinate:coordinate]) {
        SPImage* image = [SPImage imageWithTexture:texture];
        [self addChild:image];
        
        _filename = filename;
        _speeches = [[NSMutableArray alloc] init];
        
        [self loadXMLFile:_filename];
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
    _speeches = [NSMutableArray arrayWithArray:[self loadNPCSpeechTreeWithNode:npcSpeechElement]];
}

- (void)setNPCProperties:(TBXMLElement *)npcElement {
    _npcID = [TBXML valueOfAttributeNamed:@"npcID" forElement:npcElement];
    _displayName = [TBXML valueOfAttributeNamed:@"displayName" forElement:npcElement];
    NSArray* itemsArray = [[TBXML valueOfAttributeNamed:@"items" forElement:npcElement] componentsSeparatedByString:@","];
    _items = [[NSMutableArray alloc] init];
    for (NSString* itemName in itemsArray) {
        Item* item = [[Item alloc] initWithName:itemName];
        [_items addObject:item];;
    }
}

- (NSArray*)loadNPCSpeechTreeWithNode:(TBXMLElement*)npcSpeechElement {
    NSMutableArray* npcSpeeches = [[NSMutableArray alloc] init];

    while (npcSpeechElement) {
        NSMutableArray* responses = [[NSMutableArray alloc] init];

        TBXMLElement *responseElement = [TBXML childElementNamed:@"response" parentElement:npcSpeechElement];
        if (!responseElement) {
            NPCResponse* response = [[NPCResponse alloc] initWithTextToRespondWith:nil npcSpeeches:nil];
            [responses addObject:response];
        }
        
        while (responseElement) {
            TBXMLElement *childNPCSpeechElement = [TBXML childElementNamed:@"npcSpeech" parentElement:responseElement];
            //recursive call
            NSArray* childNPCSpeeches = nil;
            if (childNPCSpeechElement) childNPCSpeeches = [self loadNPCSpeechTreeWithNode:childNPCSpeechElement];
            
            NPCResponse* response = [[NPCResponse alloc] initWithTBXMLElement:responseElement npcSpeeches:childNPCSpeeches];
            [responses addObject:response];
            
            responseElement = [TBXML nextSiblingNamed:@"response" searchFromElement:responseElement];
        }
        
        NSArray* allResponses = [[NSArray alloc] initWithArray:responses];
        NPCSpeech* npcSpeech = [[NPCSpeech alloc] initWithTBXMLElement:npcSpeechElement responses:allResponses];
        [npcSpeeches addObject:npcSpeech];
        
        npcSpeechElement = [TBXML nextSiblingNamed:@"npcSpeech" searchFromElement:npcSpeechElement];
    }
    NSArray* result = [[NSArray alloc] initWithArray:npcSpeeches];
    return result;
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

- (BOOL)npcIDEquals:(NSString*)npcID {
    return [_npcID isEqualToString:npcID];
}

- (void)giveItem:(Item *)item toNPC:(NPC *)npc {
    if ([self hasItemWithName:item.itemName]) {
        [npc addItem:item];
        [self removeItemWithName:item.itemName];
    }
}

- (void)addItem:(Item *)item {
    [_items addObject:item];
}

- (void)removeItemWithName:(NSString *)itemName {
    for (Item* curItem in _items) {
        if ([curItem.itemName isEqualToString:itemName]) {
            [_items removeObject:curItem];
            break;
        }
    }
}

- (BOOL)hasItemWithName:(NSString *)itemName {
    for (Item* curItem in _items) {
        if ([curItem.itemName isEqualToString:itemName]) return true;
    }
    return false;
}

- (void)dealloc {
    [self removeEventListener:@selector(onTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
}

@end