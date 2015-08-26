//
//  Person.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-14.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//


#import "STTile.h"
#import "TBXML.h"

@class Item;

@interface NPC : STTile {
    
}

@property(nonatomic, readonly) NSString* filename;
@property(nonatomic, readonly) NSString* npcID;
@property(nonatomic, readonly) NSString* displayName;
@property(nonatomic, readonly) NSMutableArray* speeches;

- (id)initWithType:(enum STType)type texture:(SPTexture*)texture coordinate:(STCoordinate*)coordinate filename:(NSString*)filename;
- (BOOL)npcIDEquals:(NSString*)npcID;
- (BOOL)hasItemWithName:(NSString*)itemName;
- (void)giveItem:(Item*)item toNPC:(NPC*)npc;
- (void)addItem:(Item*)item;
- (void)removeItemWithName:(NSString*)itemName;

@end