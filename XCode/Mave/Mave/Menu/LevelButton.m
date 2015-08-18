//
//  LevelsMenu.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-15.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import "LevelButton.h"
#import "LoadLevelEvent.h"

@implementation LevelButton
{    
}


- (id)initWithLevelName:(NSString *)levelName
{
    if (self = [super initWithUpState:[SPTexture textureWithContentsOfFile:@"button_square.png"]]) {
        self.text = levelName;
        self.scaleWhenDown = 0.95;
        [self addEventListener:@selector(onTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        
    }
    return self;
}

- (void)onTouch:(SPTouchEvent*)event
{
    SPTouch *touchEnded = [[event touchesWithTarget:self andPhase:SPTouchPhaseEnded] anyObject];
    if (touchEnded)
    {
        SPButton* button = (SPButton*) event.target;
        LoadLevelEvent *event = [[LoadLevelEvent alloc] initWithType:EVENT_TYPE_LOAD_LEVEL levelName:button.text];
        [self dispatchEvent:event];
    }
}


@end