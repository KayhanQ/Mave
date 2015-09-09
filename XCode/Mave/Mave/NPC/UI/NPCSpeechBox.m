//
//  NPCSpeechBox.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-16.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPCSpeechBox.h"
#import "NPCSpeech.h"
#import "GameEvents.h"

@implementation NPCSpeechBox
{
    NSMutableArray* _boxStrings;
    SPSprite* _textContainer;
    int _boxStringIndex;
}

@synthesize npcSpeech = _npcSpeech;

- (id)initWithNPCSpeech:(NPCSpeech *)npcSpeech {
    if (self = [super init]) {
        _npcSpeech = npcSpeech;
        _boxStringIndex = 0;
        
        SPQuad* background = [SPQuad quadWithWidth:480 height:48];
        [self addChild:background];
        
        _textContainer = [[SPSprite alloc] init];
        [self addChild:_textContainer];
        
        _boxStrings = [[NSMutableArray alloc] init];
        
        [self formatBoxStrings];
        [self loadNext];
        
        [self addEventListener:@selector(onTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    }
    return self;
}

- (void)formatBoxStrings {
    NSArray* words = [_npcSpeech.textToSpeak componentsSeparatedByString:@" "];
    NSString* boxString = [[NSString alloc] init];
    int displayNameLength = (int)_npcSpeech.displayName.length;
    int numCharacters = displayNameLength;
    int boxLength = 110;
    int boxIndex = 0;
    
    for (NSString* word in words) {
        numCharacters += (int)word.length;
        
        NSString* spacedWord = [NSString stringWithFormat:@" %@", word];
        
        if (numCharacters <= boxLength) {
            boxString = [boxString stringByAppendingString:spacedWord];
        }
        else {
            [_boxStrings addObject: boxString];
            //we add the word that didn't fit to the next box
            boxString = [[NSString alloc] init];
            boxString = [boxString stringByAppendingString:word];
            numCharacters = 0;
            boxIndex++;
        }
    }
    //add the left over box
    [_boxStrings addObject: boxString];
}

- (void)onTouch:(SPTouchEvent*)event
{
    SPTouch *touchBegan = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] anyObject];
    if (touchBegan)
    {
        [self loadNext];
    }
}

- (void)loadNext {
    //here we will load the rest of the string if it is finished we call this
    if (_boxStringIndex < _boxStrings.count) {
        [_textContainer removeAllChildren];
        
        NSString* currentText = [_boxStrings objectAtIndex:_boxStringIndex];
        NSString* displayText = [[NSString alloc] initWithFormat:@""];
        if (_boxStringIndex == 0) displayText = [NSString stringWithFormat:@"%@: ", _npcSpeech.displayName];
        displayText = [displayText stringByAppendingString:currentText];
        
        SPTextField* textField = [self makeTextField:displayText];
        [_textContainer addChild: textField];
        
        _boxStringIndex++;
    }
    else {
        NPCSpeechFinsihedEvent *event = [[NPCSpeechFinsihedEvent alloc] initWithNPCSpeech:_npcSpeech];
        [self dispatchEvent:event];
    }
}

- (SPTextField*)makeTextField:(NSString*)text {
    
    SPTextField* textField = [SPTextField textFieldWithWidth:480 height:40 text: text];
    textField.x = 10;
    textField.y = 10;
    textField.vAlign = SPVAlignTop;
    textField.hAlign = SPHAlignLeft;
    return textField;
}

@end