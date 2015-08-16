//
//  TileTouchedEvent.h
//  Bastion
//
//  Created by Kayhan Feroze Qaiser on 10/02/2015.
//
//

#import "BasicEvent.h"

#define EVENT_TYPE_NPCSPEECH_FINISHED @"npcSpeechFinsihed"

@class NPCSpeech;

@interface NPCSpeechFinsihedEvent : BasicEvent
{
    
}

@property(nonatomic) NPCSpeech* npcSpeech;

- (id)initWithNPCSpeech:(NPCSpeech*)npcSpeech;


@end