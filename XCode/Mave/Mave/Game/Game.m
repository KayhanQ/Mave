//
//  Game.m
//  Skater
//
//  Created by Kayhan Qaiser on 2015-08-12.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"
#import "SparrowTiled.h"
#import "LevelsMenu.h"
#import "LevelEngine.h"
#import "GameEvents.h"

@implementation Game
{
    LevelEngine* _currentLevel;
    SPSprite* _levelSprite;
}

-(id)init
{
    if ((self = [super init])) {
        
        // This is where the code of your game will start;
        // in this sample, we add just a simple quad to see if it works.

        LevelsMenu* menu = [[LevelsMenu alloc] initWithName:@"world1"];
        [self addChild:menu];
        
        _levelSprite = [[SPSprite alloc] init];
        [self addChild:_levelSprite];
        
        [self addEventListener:@selector(loadLevelEvent:) atObject:self forType:EVENT_TYPE_LOAD_LEVEL];
        [self addEventListener:@selector(levelCompleted:) atObject:self forType:EVENT_TYPE_LEVEL_COMPLETED];
        [self addEventListener:@selector(levelLost:) atObject:self forType:EVENT_TYPE_LEVEL_LOST];
        [self addEventListener:@selector(levelRestart:) atObject:self forType:EVENT_TYPE_LEVEL_RESTART];

    }
    return self;
}

- (void)loadLevelEvent:(LoadLevelEvent*)event
{
    [self loadLevel:event.levelName];
}

- (void)loadLevel:(NSString*)levelName {
    LevelEngine* newLevel = [[LevelEngine alloc] initWithName:levelName];
    [_levelSprite addChild:newLevel];
}

- (void)levelLost:(LevelEvent*)event
{
    [_levelSprite removeAllChildren];
}

- (void)levelRestart:(LevelEvent*)event
{
    [_levelSprite removeAllChildren];
}

- (void)levelCompleted:(LevelCompletedEvent*)event
{
    [_levelSprite removeAllChildren];
    //[self loadLevel:event.nextLevelName];
}


@end