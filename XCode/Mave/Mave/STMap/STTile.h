//
//  STTile.h
//  SparrowTiled
//
//  Created by Shilo White on 2/19/11.
//  Copyright 2011 Shilocity Productions & Brian Ensor Apps. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>

@class SPTexture;

@interface STTile : SPSprite {
    enum TileType {EMPTY = 0, GROUND = 30, ROUGH = 15, ROCK = 32, HOLE = 31, START = 34, FINISH = 10, CHARACTER = 46};
}

@property (nonatomic, readonly) enum TileType type;

- (id)initWithType:(enum TileType)type;

@end
