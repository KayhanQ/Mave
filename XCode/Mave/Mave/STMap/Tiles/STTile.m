//
//  STTile.m
//  SparrowTiled
//
//  Created by Shilo White on 2/19/11.
//  Copyright 2011 Shilocity Productions & Brian Ensor Apps. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "STTile.h"
#import "STCoordinate.h"

@implementation STTile

@synthesize type = _type;
@synthesize collisionType = _collisionType;
@synthesize coordinate = _coordinate;
@synthesize tileWidth = _tileWidth;
@synthesize tileHeight = _tileHeight;

- (id)initWithType:(enum STType)type texture:(SPTexture *)texture coordinate:(STCoordinate *)coordinate {
	if (self = [super init]) {
        SPImage* image = [SPImage imageWithTexture:texture];
        [self addChild:image];
        
        _type = type;
        _tileWidth = 32;
        _tileHeight = 32;
        self.coordinate = coordinate;
        
        if (_type == STROCK || _type == STNPC || _type == STPLAYER || _type == STPUSHROCK) _collisionType = STOPBEFORE;
        else if (_type == STROUGH || _type == STFINISH) _collisionType = STOPONTOPOF;
        else if (_type == STHOLE || _type == STSPIKES) _collisionType = KILL;
        else if (_type == STEMPTY || _type == STGROUND) _collisionType = NONE;
        else _collisionType = NONE;
	}
	return self;
}

- (void)setCoordinate:(STCoordinate *)coordinate {
    _coordinate = coordinate;
    self.x = coordinate.x*_tileWidth;
    self.y = coordinate.y*_tileHeight;
}

@end
