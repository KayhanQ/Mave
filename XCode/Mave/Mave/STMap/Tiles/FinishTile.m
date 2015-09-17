//
//  FinishTile.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-09-17.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FinishTile.h"

@implementation FinishTile
{

}

@synthesize nextLevelName = _nextLevelName;
@synthesize functional = _functional;

- (id)initWithTexture:(SPTexture *)texture coordinate:(id)coordinate nextLevelName:(NSString *)nextLevelName functional:(BOOL)functional
{
    if (self = [super initWithType:STFINISH texture:texture coordinate:coordinate]) {
        _nextLevelName = nextLevelName;
        _functional = functional;
    }
    return self;
}

@end