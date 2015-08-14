//
//  STLayer.m
//  SparrowTiled
//
//  Created by Shilo White on 2/19/11.
//  Copyright 2011 Shilocity Productions & Brian Ensor Apps. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "STLayer.h"
#import "STTileset.h"
#import "STTile.h"
#import "BasicTile.h"
#import "Player.h"

@interface STLayer ()
- (void)loadTileWithGID:(int)gid tileset:(STTileset *)tileset index:(int)i;
- (void)loadLayer;
@end

@implementation STLayer
{
    NSMutableArray* _tiles;
    SPRenderTexture* _renderTexture;
    STTileset* _tileSet;
}

@synthesize name = _name;
@synthesize width = _width;
@synthesize height = _height;
@synthesize tileWidth = _tileWidth;
@synthesize tileHeight = _tileHeight;
@synthesize pixelWidth = _pixelWidth;
@synthesize pixelHeight = _pixelHeight;
@synthesize zoom;
@synthesize image = _image;

- (id)initWithName:(NSString *)name width:(int)width height:(int)height gids:(NSMutableArray *)gids tileset:(STTileset *)tileset {
	if (self = [super init]) {
		_name = name;
		_width = width;
		_height = height;
		_tileWidth = tileset.tileWidth;
		_tileHeight = tileset.tileHeight;
		_pixelWidth = _width * _tileWidth;
		_pixelHeight = _height * _tileHeight;
        _tileSet = tileset;
        
		int i = 0;
        
        _tiles = [[NSMutableArray alloc] initWithCapacity:10];
        _renderTexture = [[SPRenderTexture alloc] initWithWidth:_width*_tileWidth height:_height*_tileHeight];
        for (NSNumber *gid in gids) {
			[self loadTileWithGID:[gid intValue] index:i++];
		}
		
		[self loadLayer];
	}
	return self;
}

- (void)loadTileWithGID:(int)gid index:(int)i {
	SPTexture *texture;
	if (gid >= _tileSet.firstGID) {
		texture = [_tileSet textureByGID:gid];
	} else {
		texture = [SPTexture textureWithWidth:_tileSet.tileWidth height:_tileSet.tileHeight draw:nil];
	}
    
    STTile* tile;
    switch (gid) {
        case CHARACTER:
        {
            tile = [[Player alloc] initWithType:CHARACTER];
            break;
        }
        default:
        {
            tile = [[BasicTile alloc] initWithType:gid texture:texture];
            break;
        }
    }
	[_tiles addObject:tile];
	
    tile.y = [self getcooYForTile:tile]*_tileHeight;
    tile.x = [self getcooXForTile:tile]*_tileWidth;
}

- (void)loadLayer {
    [_renderTexture clear];
    for (STTile* t in _tiles) {
        if (t.type != EMPTY) [_renderTexture drawObject:t];
    }
	_image = [[SPImage alloc] initWithTexture:_renderTexture];
	[self addChild:_image];
}

- (Player*)getPlayer {
    for (STTile* tile in _tiles) {
        if (tile.type == CHARACTER) {
            return (Player*)tile;
        }
    }
    return nil;
}

- (void)insertTileAtGid:(STTile *)tile gid:(int)gid {
    [_tiles replaceObjectAtIndex:gid withObject:tile];
    [self loadLayer];
}

- (STTile *)tileAtIndex:(int)index {
	return [_tiles objectAtIndex:index];
}

- (int)getcooXForTile:(STTile *)tile {
    int i = [_tiles indexOfObject:tile];
    int cooY = (int)(i/_width);
    int cooX = i-(cooY*_width);
    return cooX;
}

- (int)getcooYForTile:(STTile *)tile {
    int i = [_tiles indexOfObject:tile];
    int cooY = (int)(i/_width);
    return cooY;
}

//- (STTile *)tileAtX:(int)x y:(int)y {
//	int i = (y*_width)+x;
//	return [_tiles objectAtIndex:i];
//}

- (float)trueRotation {
	float rotation = 0;
	
	SPDisplayObject *currentObject = self;
    while (currentObject.parent) {
		rotation += currentObject.rotation;
		currentObject = currentObject.parent;
	}
	
	return rotation;
}

- (float)viewWidth {
	float trueRotation = SP_R2D(self.trueRotation);
	if (trueRotation == 90 || trueRotation == -90 || trueRotation == 270 || trueRotation == -270) {
		return self.stage.height;
	} else {
		return self.stage.width;
	}
}

- (float)viewHeight {
	float trueRotation = SP_R2D(self.trueRotation);
	if (trueRotation == 90 || trueRotation == -90 || trueRotation == 270 || trueRotation == -270) {
		return self.stage.width;
	} else {
		return self.stage.height;
	}
}

- (void)dealloc {

}
@end
