//
//  Player.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-14.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "Item.h"

@implementation Player
{
    NSMutableArray* _items;
}

- (id)initWithType:(enum STType)type texture:(SPTexture*)texture coordinate:(STCoordinate*)coordinate filename:(NSString*)filename {
    if ((self = [super initWithType:STCHARACTER texture:texture coordinate:coordinate filename:filename])) {
        
        _items = [[NSMutableArray alloc] init];
        [_items addObject:[[Item alloc] initWithName:@"Bus Ticket"]];
        [_items addObject:[[Item alloc] initWithName:@"fish"]];
        [_items addObject:[[Item alloc] initWithName:@"car"]];


    }
    return self;
}

- (BOOL)hasItem:(Item *)item {
    
    for (Item* curItem in _items) {
        if ([curItem.itemName isEqualToString:item.itemName]) return true;
    }
    return false;
}

@end