//
//  PlayerAction.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-15.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPCAction.h"

@implementation NPCAction

@synthesize type = _type;

- (id)initWithType:(enum NPCActionType)type {
    if (self = [super init]) {
        
        _type = type;
        
    }
    return self;
}

@end