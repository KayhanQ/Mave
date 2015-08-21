//
//  NPCTouchedEvent.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-16.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import "ActionEvent.h"
#import <Foundation/Foundation.h>

#define EVENT_TYPE_GIVE_ITEM @"giveItem"


@class Item;


@interface GiveItemEvent : ActionEvent
{
    
}

@property(nonatomic, readonly) Item* item;

- (id)initWithItem:(Item*)item;

@end