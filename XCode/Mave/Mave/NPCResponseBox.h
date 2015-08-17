//
//  NPCSpeechBox.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-16.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

@class NPCSpeech;
@class NPCResponse;

@interface NPCResponseBox : SPSprite
{
    
}

@property(nonatomic, readonly) NPCResponse* npcResponse;

- (id)initWithResponse:(NPCResponse*)npcResponse;
@end