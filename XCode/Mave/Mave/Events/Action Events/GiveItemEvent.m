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

- (id)initWithItem:(Item *)item
{
    if ((self = [super initWithType:EVENT_TYPE_GIVE_ITEM]))
    {
        _item = item;
    }
    return self;
}

@end