//
//  LevelsMenu.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-15.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import "LevelsMenu.h"
#import "LevelEngine.h"
#import "LevelButton.h"

@implementation LevelsMenu
{    
}


- (id)initWithName:(NSString *)worldName
{
    if (self = [super init]) {

        int x = 0;
        int y = 0;
        
        for (int i = 0; i<30; i++) {
            NSString* levelName = [[NSString alloc] initWithFormat:@"Level_%d", i];
            
            if (i == 18) levelName = @"Level_18s";
            else if (i == 19) levelName = @"Level_19s";
            else if (i == 20) levelName = @"Level_20s";
            else if (i == 21) levelName = @"Level_18j";
            else if (i == 22) levelName = @"Level_19j";
            else if (i == 23) levelName = @"Level_20j";
            
            LevelButton* button = [[LevelButton alloc] initWithLevelName:levelName];
            x = button.width*(i%15) +20;
            button.x = x;
            button.y =  y;
            button.text = levelName;
            [self addChild:button];
            
            if ((i+1)%15 == 0) {
                x = 0;
                y+=40;
            }
        }
        
    }
    return self;
}


@end