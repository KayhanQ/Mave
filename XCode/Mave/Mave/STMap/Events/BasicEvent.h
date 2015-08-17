//
//  GHEvent.h
//  GameOfHovels
//
//  Created by Kayhan Feroze Qaiser on 19/02/2015.
//  Copyright (c) 2015 CivetAtelier. All rights reserved.
//

#import <Foundation/Foundation.h>

#define EVENT_NPC_DIALOGUE_FINISHED @"npcDialogueFinished"

@interface BasicEvent : SPEvent

- (id)initWithType:(NSString *)type;


@end