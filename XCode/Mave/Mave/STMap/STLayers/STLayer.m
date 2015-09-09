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
#import "Player.h"
#import "TBXML.h"

@interface STLayer ()
- (void)loadTileWithGID:(int)gid tileset:(STTileset *)tileset index:(int)i;
- (void)redrawLayer;
@end

@implementation STLayer
{
    NSString* _folderPath;
}

@synthesize name = _name;
@synthesize width = _width;
@synthesize height = _height;
@synthesize tileWidth = _tileWidth;
@synthesize tileHeight = _tileHeight;
@synthesize pixelWidth = _pixelWidth;
@synthesize pixelHeight = _pixelHeight;
@synthesize zoom = _zoom;

- (id)initWithLayerElement:(TBXMLElement *)layerElement tileset:(STTileset *)tileset folderPath:(NSString *)folderPath {
    if (self = [super init]) {
        _name = [TBXML valueOfAttributeNamed:@"name" forElement:layerElement];
        _width = [[TBXML valueOfAttributeNamed:@"width" forElement:layerElement] intValue];
        _height = [[TBXML valueOfAttributeNamed:@"height" forElement:layerElement] intValue];
        _tileWidth = tileset.tileWidth;
        _tileHeight = tileset.tileHeight;
        _pixelWidth = _width * _tileWidth;
        _pixelHeight = _height * _tileHeight;
        _tileSet = tileset;
        _folderPath = folderPath;        
        
        NSString *opacity = [TBXML valueOfAttributeNamed:@"opacity" forElement:layerElement];
        
        TBXMLElement *dataElement = [TBXML childElementNamed:@"data" parentElement:layerElement];
        if (!dataElement) [self raiseXMLError:ST_EXC_ELEMENT_NOT_FOUND message:@"\"data\" element doesn't exist"];
        TBXMLElement *tileElement = [TBXML childElementNamed:@"tile" parentElement:dataElement];
        if (!tileElement) [self raiseXMLError:ST_EXC_ELEMENT_NOT_FOUND message:@"\"tile\" element doesn't exist"];
        
        _tiles = [[SPSprite alloc] init];
        [self addChild:_tiles];
        int i = 0;
        while (tileElement) {
            [self loadTile:tileElement index:i++];
            tileElement = [TBXML nextSiblingNamed:@"tile" searchFromElement:tileElement];
        }
    }
    return self;
}

- (void)loadTile:(TBXMLElement*)tileElement index:(int)i {
    int gid = [[TBXML valueOfAttributeNamed:@"gid" forElement:tileElement] intValue];
    
    SPTexture *texture;
    if (gid >= _tileSet.firstGID) {
        texture = [_tileSet textureByGID:gid];
    } else {
        texture = [SPTexture textureWithWidth:_tileSet.tileWidth height:_tileSet.tileHeight draw:nil];
    }
    
    int cooY = (int)(i/_width);
    int cooX = i-(cooY*_width);
    STCoordinate* coordinate = [[STCoordinate alloc] initWithX:cooX y:cooY];
    
    STTile* tile;
    

    switch (gid) {
        case STNPC:
        {
            NSString* npcFilename = [TBXML valueOfAttributeNamed:@"npcFile" forElement:tileElement];
            NSString* filePath = [_folderPath stringByAppendingString:npcFilename];
            NPC* npc = [[NPC alloc] initWithType:STNPC texture:texture coordinate:coordinate filename:filePath];
            tile = npc;
            break;
        }
        case STPLAYER:
        {
            NSString* npcFilename = [TBXML valueOfAttributeNamed:@"npcFile" forElement:tileElement];
            NSString* filePath = [_folderPath stringByAppendingString:npcFilename];
            Player* npc = [[Player alloc] initWithType:STPLAYER texture:texture coordinate:coordinate filename:filePath];
            tile = npc;
            break;
        }
        default:
        {
            tile = [[STTile alloc] initWithType:gid texture:texture coordinate:coordinate];
            break;
        }
    }
    
    [_tiles addChild:tile];
    
}
- (void)moveTileTo:(STTile*)tile coordinate:(STCoordinate*)coordinate {
    int tileIndex = [self convertCoordinateToGID:tile.coordinate];
    int destinationIndex = [self convertCoordinateToGID:coordinate];
    STTile* destTile = (STTile*) [_tiles childAtIndex:destinationIndex];
    
    [_tiles swapChildAtIndex:tileIndex withChildAtIndex:destinationIndex];
    
    STCoordinate* tmpCoordinate = [[STCoordinate alloc] initWithX:coordinate.x y:coordinate.y];
    destTile.coordinate = tile.coordinate;
    tile.coordinate = tmpCoordinate;
}

- (int)convertCoordinateToGID:(STCoordinate*)coordinate {
    int result = (coordinate.y*_width) + coordinate.x;
    return result;
}

- (NSMutableArray*)getTilesInRowOfTile:(STTile*)tile {
    NSMutableArray* array = [[NSMutableArray alloc] init];
    for (STTile* curTile in _tiles) {
        if (tile.coordinate.y == curTile.coordinate.y) [array addObject:curTile];
    }
    return array;
}

- (NSMutableArray*)getTilesInColumnOfTile:(STTile*)tile {
    NSMutableArray* array = [[NSMutableArray alloc] init];
    for (STTile* curTile in _tiles) {
        if (tile.coordinate.x == curTile.coordinate.x) {
            [array addObject:curTile];
            
        }
    }
    return array;
}

- (BOOL)containsTile:(STTile*)tile {
    for (STTile* curTile in _tiles) {
        if (curTile == tile) return true;
    }
    return false;
}

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

- (void)raiseXMLError:(NSString *)error message:(NSString *)message {
    
//    [NSException raise:error format:[NSString stringWithFormat:@"Error while reading \"%@\", %@.", _filename, message], NSStringFromSelector(_cmd)];
}

@end
