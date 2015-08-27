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

        for (int i = 0; i<10; i++) {
            NSString* levelName = [[NSString alloc] initWithFormat:@"Level_%d", i];
            
            LevelButton* button = [[LevelButton alloc] initWithLevelName:levelName];
            button.x = button.width*i + 20;
            button.text = levelName;
            [self addChild:button];
        }
        
    }
    return self;
}


@end