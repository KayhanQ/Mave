//
//  TileTouchedEvent.m
//  Bastion
//
//  Created by Kayhan Feroze Qaiser on 10/02/2015.
//
//

#import <Foundation/Foundation.h>
#import "LoadLevelEvent.h"

@implementation LoadLevelEvent

- (id)initWithLevelName:(NSString*)levelName
{
    if ((self = [super initWithType:EVENT_TYPE_LOAD_LEVEL levelName:levelName]))
    {
        
    }
    return self;
}

@end