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

@synthesize levelName = _levelName;

- (id)initWithType:(NSString *)type levelName:(NSString *)levelName
{
    if ((self = [super initWithType:type bubbles:YES]))
    {
        _levelName = levelName;
    }
    return self;
}

@end