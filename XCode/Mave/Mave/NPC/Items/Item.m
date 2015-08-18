//
//  PlayerAction.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-15.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@implementation Item

@synthesize itemName = _itemName;

- (id)initWithName:(NSString *)itemName {
    if (self = [super init]) {
        _itemName = itemName;
    }
    return self;
}
@end