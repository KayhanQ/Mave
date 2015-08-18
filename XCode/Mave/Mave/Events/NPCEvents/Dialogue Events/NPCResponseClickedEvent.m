//
//  TileTouchedEvent.m
//  Bastion
//
//  Created by Kayhan Feroze Qaiser on 10/02/2015.
//
//

#import <Foundation/Foundation.h>
#import "NPCResponseClickedEvent.h"

@implementation NPCResponseClickedEvent

@synthesize npcResponse = _npcResponse;

- (id)initWithNPCResponse:(NPCResponse *)npcResponse
{
    if ((self = [super initWithType:EVENT_TYPE_NPCRESPONSE_CLICKED bubbles:YES]))
    {
        _npcResponse = npcResponse;
    }
    return self;
}

@end