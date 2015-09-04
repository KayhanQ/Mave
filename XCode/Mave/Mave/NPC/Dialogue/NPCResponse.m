//
//  PlayerAction.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-15.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPCResponse.h"

@implementation NPCResponse

@synthesize textToRespondWith = _textToRespondWith;
@synthesize npcSpeeches = _npcSpeeches;

- (id)initWithTBXMLElement:(TBXMLElement*)responseElement npcSpeeches:(NSArray*)npcSpeeches {
    if (self = [super init]) {
        _textToRespondWith = [TBXML valueOfAttributeNamed:@"text" forElement:responseElement];
        _npcSpeeches = npcSpeeches;
    }
    return self;
}

- (id)initAsNil {
    if (self = [super init]) {
        _textToRespondWith = nil;
        _npcSpeeches = nil;
    }
    return self;
}

@end