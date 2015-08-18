//
//  PlayerAction.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-15.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import "NPCAction.h"

@class NPCSpeech;

@interface NPCResponse : NSObject
{

}

@property(nonatomic, readonly) NSString* textToRespondWith;
@property(nonatomic, readonly) NPCSpeech* npcSpeech;

- (id)initWithTextToRespondWith:(NSString*)textToRespondWith npcSpeech:(NPCSpeech*)npcSpeech;

@end
