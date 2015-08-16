//
//  PlayerAction.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-15.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import "NPCAction.h"

@class Response;

@interface NPCSpeech : NPCAction
{

}

@property(nonatomic, readonly) NSString* textToSpeak;
@property(nonatomic, readonly) NSArray* responses;

- (id)initWithText:(NSString*)textToSpeak responses:(NSArray*)responses;

@end