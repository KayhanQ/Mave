//
//  LevelEngine.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-14.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STMap;
@class STLayer;
@class Player;

@interface LevelEngine : SPSprite
{
    
}

@property(nonatomic, strong)NSString* levelName;
@property(nonatomic, strong)STMap* map;
@property(nonatomic, strong)STLayer* groundLayer;
@property(nonatomic, strong)STLayer* obstacleLayer;
@property(nonatomic, strong)STLayer* startAndEndLayer;
@property(nonatomic, strong)STLayer* characterLayer;
@property(nonatomic, strong)Player* player;

- (id)initWithName:(NSString*)levelName;

@end
