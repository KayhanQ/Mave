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
@synthesize npcSpeech = _npcSpeech;

- (id)initWithTextToRespondWith:(NSString *)textToRespondWith npcSpeech:(NPCSpeech *)npcSpeech {
    if (self = [super init]) {
        _textToRespondWith = textToRespondWith;
        _npcSpeech = npcSpeech;
    }
    return self;
}

@end