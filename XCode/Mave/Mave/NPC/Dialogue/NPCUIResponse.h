//
//  NPCUIResponse.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-09-03.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import "NPCResponse.h"

@interface NPCUIResponse : NPCResponse
{
    
}

@property(nonatomic, readonly) NSString* correctAnswer;
@property(nonatomic) NSString* currentAnswer;

- (id)initWithTBXMLElement:(TBXMLElement*)responseElement npcSpeeches:(NSArray*)npcSpeeches;

@end
