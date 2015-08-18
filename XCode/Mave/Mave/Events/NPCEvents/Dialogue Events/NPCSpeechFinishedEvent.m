//
//  TileTouchedEvent.m
//  Bastion
//
//  Created by Kayhan Feroze Qaiser on 10/02/2015.
//
//

#import <Foundation/Foundation.h>
#import "NPCSpeechFinishedEvent.h"

@implementation NPCSpeechFinsihedEvent

@synthesize npcSpeech = _npcSpeech;

- (id)initWithNPCSpeech:(NPCSpeech *)npcSpeech
{
    if ((self = [super initWithType:EVENT_TYPE_NPCSPEECH_FINISHED bubbles:YES]))
    {
        _npcSpeech = npcSpeech;
    }
    return self;
}

@end