//
//  HUD.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-09-13.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HUD.h"
#import "ResetButton.h"

@implementation HUD
{
    
}

- (id)init
{
    if (self = [super init]) {
        [self makeHUD];
    }
    return self;
}

- (void)makeHUD {
    SPButton* resetButton = [[ResetButton alloc] init];
    [self addChild:resetButton];
}

@end