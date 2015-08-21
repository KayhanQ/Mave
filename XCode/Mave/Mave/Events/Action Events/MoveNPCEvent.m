//
//  NPCTouchedEvent.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-16.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoveNPCEvent.h"

@implementation MoveNPCEvent

@synthesize npcID = _npcID;
@synthesize direction = _direction;

- (id)initWithNPCID:(NSString *)npcID direction:(UISwipeGestureRecognizerDirection)direction
{
    if ((self = [super initWithType:EVENT_TYPE_MOVE_NPC]))
    {
        _npcID = npcID;
        _direction = direction;
    }
    return self;
}

@end