//
//  ResetButton.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-09-13.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResetButton.h"
#import "LevelEvent.h"

@implementation ResetButton
{
    
}

- (id)init {
    if (self = [super initWithUpState:[SPTexture textureWithContentsOfFile:@"button_square.png"]]) {
        self.text = @"reset";
    }
    return self;
}

- (void)onTouch:(SPTouchEvent*)event {
    SPTouch *touchEnded = [[event touchesWithTarget:self andPhase:SPTouchPhaseEnded] anyObject];
    if (touchEnded)
    {
        LevelEvent* restartEvent = [[LevelEvent alloc] initWithType:EVENT_TYPE_LEVEL_RESTART];
        [self dispatchEvent:restartEvent];
    }
}

@end