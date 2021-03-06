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
#import "FinishTile.h"
#import "HelperFunctions.h"
#import "Animator.h"

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
        texture = [self getEmptyTexture];
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
        case STFINISH:
        {
            NSString* nextLevel = [TBXML valueOfAttributeNamed:@"nextLevel" forElement:tileElement];
            NSString* functional = [TBXML valueOfAttributeNamed:@"functional" forElement:tileElement];
        
            tile = [[FinishTile alloc] initWithTexture:texture coordinate:coordinate nextLevelName:nextLevel functional:[HelperFunctions stringToBool:functional]];
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

- (int)convertCoordinateToGID:(STCoordinate*)coordinate {
    int result = (coordinate.y*_width) + coordinate.x;
    return result;
}

- (float)convertCoordinateToX:(STCoordinate*)coordinate {
    float result = (coordinate.x*_tileWidth);
    return result;
}

- (float)convertCoordinateToY:(STCoordinate*)coordinate {
    float result = (coordinate.y*_tileHeight);
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

- (STTile*)tileAtIndex:(int)index {
    return (STTile*)[_tiles childAtIndex:index];
}

- (STTile*)tileAtCoordinate:(STCoordinate*)coordinate {
    int index = [self convertCoordinateToGID:coordinate];
    return (STTile*) [_tiles childAtIndex:index];
}

- (void)swapTile:(STTile*)tile1 withTile:(STTile*)tile2 {
    STCoordinate* tempTile1Coordinate = tile1.coordinate;
    tile1.coordinate = tile2.coordinate;
    tile2.coordinate = tempTile1Coordinate;
    [_tiles swapChild:tile1 withChild:tile2];
}

- (void)removeTile:(STTile*)tile {
    STTile* emptyTile = [[STTile alloc] initWithType:STEMPTY texture:[self getEmptyTexture] coordinate:tile.coordinate];
    int tileIndex = [_tiles childIndex:tile];
    [_tiles removeChild:tile];
    [_tiles addChild:emptyTile atIndex:tileIndex];
}

- (FinishTile*)getFinishTileForNextLevel:(NSString*)nextLevel {
    for (STTile* tile in _tiles) {
        if (tile.type == STFINISH) {
            FinishTile* finishTile = (FinishTile*)tile;
            if ([finishTile.nextLevelName isEqualToString:nextLevel]) {
                return finishTile;
            }
        }
    }
    return nil;
}

- (SPTexture*)getEmptyTexture {
    SPTexture* texture = [SPTexture textureWithWidth:_tileSet.tileWidth height:_tileSet.tileHeight draw:nil];
    return texture;
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
