//
//  NPCSpeechBox.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-16.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

@class NPCSpeech;

@interface NPCSpeechBox : SPSprite
{
    
}

@property(nonatomic, readonly) NPCSpeech* npcSpeech;

- (id)initWithNPCSpeech:(NPCSpeech*)npcSpeech;
- (void)loadNext;
@end