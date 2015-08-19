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
#import "STCoordinate.h"

@class SPTexture;
@class STCoordinate;

@interface STTile : SPSprite {
    enum STType {STEMPTY = 0, STGROUND = 30, STROUGH = 15, STROCK = 32, STHOLE = 31, STFINISH = 10, STCHARACTER = 46, STPLAYER = 47};
    enum CollisionType {NONE = 0, STOPBEFORE, STOPONTOPOF, KILL};
}

@property (nonatomic, readonly) enum STType type;
@property (nonatomic, readonly) enum CollisionType collisionType;
@property (nonatomic) STCoordinate* coordinate;
@property (nonatomic) int tileWidth;
@property (nonatomic) int tileHeight;

- (id)initWithType:(enum STType)type coordinate:(STCoordinate*)coordinate;

@end
