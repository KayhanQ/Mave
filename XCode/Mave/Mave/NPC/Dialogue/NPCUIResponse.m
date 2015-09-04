//
//  NPCUIResponse.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-09-03.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPCUIResponse.h"

@implementation NPCUIResponse{
    
}

@synthesize correctAnswer = _correctAnswer;
@synthesize currentAnswer = _currentAnswer;

- (id)initWithTBXMLElement:(TBXMLElement*)responseElement npcSpeeches:(NSArray*)npcSpeeches {
    if (self = [super initWithTBXMLElement:responseElement npcSpeeches:npcSpeeches]) {
        _correctAnswer =  [TBXML valueOfAttributeNamed:@"correctAnswer" forElement:responseElement];
        _currentAnswer = nil;
    }
    return self;
}

@end