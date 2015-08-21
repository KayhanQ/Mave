//
//  PlayerAction.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-15.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

@class NPCSpeech;
#import "TBXML.h"

@interface NPCResponse : NSObject
{

}

@property(nonatomic, readonly) NSString* textToRespondWith;
@property(nonatomic, readonly) NSArray* npcSpeeches;

- (id)initWithTBXMLElement:(TBXMLElement*)responseElement npcSpeeches:(NSArray*)npcSpeeches;

- (id)initWithTextToRespondWith:(NSString*)textToRespondWith npcSpeeches:(NSArray*)npcSpeeches;

@end
