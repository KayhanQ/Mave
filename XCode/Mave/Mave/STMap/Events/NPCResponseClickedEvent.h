//
//  TileTouchedEvent.h
//  Bastion
//
//  Created by Kayhan Feroze Qaiser on 10/02/2015.
//
//

#import "BasicEvent.h"

#define EVENT_TYPE_NPCRESPONSE_CLICKED @"npcResponseClicked"

@class NPCResponse;

@interface NPCResponseClickedEvent : BasicEvent
{
    
}

@property(nonatomic) NPCResponse* npcResponse;

- (id)initWithNPCResponse:(NPCResponse*)npcResponse;


@end