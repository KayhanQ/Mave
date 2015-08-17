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
@class BasicTile;
@class NPCLayer;

@interface LevelEngine : SPSprite
{
    
}

@property(nonatomic, strong)NSString* levelName;

- (id)initWithName:(NSString*)levelName;

@end
