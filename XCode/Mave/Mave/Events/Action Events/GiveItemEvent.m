//
//  NPCTouchedEvent.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-16.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GiveItemEvent.h"

@implementation GiveItemEvent

@synthesize item = _item;
@synthesize fromNPCID = _fromNPCID;
@synthesize toNPCID = _toNPCID;

- (id)initWithItem:(Item*)item fromNPC:(NSString*)fromNPCID toNPC:(NSString*)toNPCID
{
    if ((self = [super initWithType:EVENT_TYPE_GIVE_ITEM]))
    {
        _item = item;
        _fromNPCID = fromNPCID;
        _toNPCID = toNPCID;
    }
    return self;
}

@end