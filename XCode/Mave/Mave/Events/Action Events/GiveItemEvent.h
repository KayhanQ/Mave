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
@property(nonatomic, readonly) NSString* fromNPCID;
@property(nonatomic, readonly) NSString* toNPCID;

- (id)initWithItem:(Item*)item fromNPC:(NSString*)fromNPCID toNPC:(NSString*)toNPCID;

@end