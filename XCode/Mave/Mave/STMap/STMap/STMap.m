//
//  STMap.m
//  SparrowTiledTest
//
//  Created by Shilo White on 2/19/11.
//  Copyright 2011 Shilocity Productions & Brian Ensor Apps. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "STMap.h"
#import "TBXML.h"
#import "NSDataAdditions.h"
#import "STTileset.h"
#import "STLayer.h"
#import "NPCLayer.h"
#import "STTile.h"
#import "NPC.h"
#import "FinishTile.h"

@interface STMap ()
- (void)loadXMLFile:(NSString *)filename;
- (void)parseXMLData:(TBXML *)xml;
- (void)setMapProperties:(TBXMLElement *)mapElement;
- (void)loadTileset:(TBXMLElement *)tilesetElement;
- (void)loadLayer:(TBXMLElement *)layerElement;
- (void)raiseXMLError:(NSString *)error message:(NSString *)message;
@end

@implementation STMap

@synthesize filename = _filename;
@synthesize version = _version;
@synthesize orientation = _orientation;
@synthesize width = _width;
@synthesize height = _height;
@synthesize tileWidth = _tileWidth;
@synthesize tileHeight = _tileHeight;
@synthesize pixelWidth = _pixelWidth;
@synthesize pixelHeight = _pixelHeight;
@synthesize tileset = _tileset;
@synthesize layers = _layers;
@synthesize zoom = _zoom;
@synthesize folderPath = _folderPath;

- (id)initWithLevelFolderPath:(NSString *)folderPath filename:(NSString *)filename {
	if (self = [super init]) {
        _folderPath = folderPath;
		_filename = filename;
        
        NSString* filePath = [_folderPath stringByAppendingString:_filename];
		[self loadXMLFile:filePath];
	}
	return self;
}

+ (STMap *)mapWithTMXFile:(NSString *)filename {
	
    return nil;
    //return [[STMap alloc]initWithTMXFile:filename];
}

- (void)loadXMLFile:(NSString *)filename {
	TBXML *xml = [[TBXML alloc] initWithXMLFile:filename];
	[self parseXMLData:xml];
}

- (void)parseXMLData:(TBXML *)xml {
	TBXMLElement *mapElement = xml.rootXMLElement;
	if (!mapElement) [self raiseXMLError:ST_EXC_FILE_NOT_FOUND message:@"file doesn't exist or is unreadable"];
	
	[self setMapProperties:mapElement];
	
	TBXMLElement *tilesetElement = [TBXML childElementNamed:@"tileset" parentElement:mapElement];
	if (!tilesetElement) [self raiseXMLError:ST_EXC_ELEMENT_NOT_FOUND message:@"\"tileset\" element doesn't exist"];
    NSString* tilesetFileName = [TBXML valueOfAttributeNamed:@"source" forElement:tilesetElement];
    TBXML *tilesetXml = [[TBXML alloc] initWithXMLFile:tilesetFileName];
    TBXMLElement *tilesetFileRoot = tilesetXml.rootXMLElement;
    [self loadTileset:tilesetFileRoot];
	
	TBXMLElement *layerElement = [TBXML childElementNamed:@"layer" parentElement:mapElement];
	if (!layerElement) [self raiseXMLError:ST_EXC_ELEMENT_NOT_FOUND message:@"\"layer\" element doesn't exist"];
	_layers = [[NSMutableDictionary alloc] initWithCapacity:1];
	while (layerElement) {
		[self loadLayer:layerElement];
		layerElement = [TBXML nextSiblingNamed:@"layer" searchFromElement:layerElement];
	}
}

- (void)setMapProperties:(TBXMLElement *)mapElement {
	_version = [TBXML valueOfAttributeNamed:@"version" forElement:mapElement];
	_orientation = [TBXML valueOfAttributeNamed:@"orientation" forElement:mapElement];
	_width = [[TBXML valueOfAttributeNamed:@"width" forElement:mapElement] intValue];
	_height = [[TBXML valueOfAttributeNamed:@"height" forElement:mapElement] intValue];
	_tileWidth = [[TBXML valueOfAttributeNamed:@"tilewidth" forElement:mapElement] intValue];
	_tileHeight = [[TBXML valueOfAttributeNamed:@"tileheight" forElement:mapElement] intValue];
	_pixelWidth = _width * _tileWidth;
	_pixelHeight = _height * _tileHeight;

	if (![_orientation isEqualToString:@"orthogonal"]) [self raiseXMLError:@"OrientationNotSupported" message:[NSString stringWithFormat:@"orientation \"%@\" not supported yet", _orientation]];
}

- (void)loadTileset:(TBXMLElement *)tilesetElement {
	TBXMLElement *imageElement = [TBXML childElementNamed:@"image" parentElement:tilesetElement];
	if (!imageElement) [self raiseXMLError:ST_EXC_ELEMENT_NOT_FOUND message:@"\"image\" element doesn't exist"];
	
	NSString *filename = [TBXML valueOfAttributeNamed:@"source" forElement:imageElement];
	NSString *name = [TBXML valueOfAttributeNamed:@"name" forElement:tilesetElement];
	int firstGID = [[TBXML valueOfAttributeNamed:@"firstgid" forElement:tilesetElement] intValue];
	int tileWidth = [[TBXML valueOfAttributeNamed:@"tilewidth" forElement:tilesetElement] intValue];
	int tileHeight = [[TBXML valueOfAttributeNamed:@"tileheight" forElement:tilesetElement] intValue];
	int spacing = [[TBXML valueOfAttributeNamed:@"spacing" forElement:tilesetElement] intValue];
	int margin = [[TBXML valueOfAttributeNamed:@"margin" forElement:tilesetElement] intValue];
	NSString *transparentColor = [TBXML valueOfAttributeNamed:@"trans" forElement:imageElement];
	int width = [[TBXML valueOfAttributeNamed:@"width" forElement:imageElement] intValue];
	int height = [[TBXML valueOfAttributeNamed:@"height" forElement:imageElement] intValue];
	
    //tsx files don't contain first gid info for some reason
    firstGID = 1;
	_tileset = [[STTileset alloc] initWithFile:filename name:name firstGID:firstGID tileWidth:tileWidth tileHeight:tileHeight spacing:spacing margin:margin transparentColor:transparentColor width:width height:height];
}

- (void)loadLayer:(TBXMLElement *)layerElement {
	NSString *name = [TBXML valueOfAttributeNamed:@"name" forElement:layerElement];

    STLayer *layer;
    if ([name isEqualToString:@"Characters"]) {
        layer = [[NPCLayer alloc] initWithLayerElement:layerElement tileset:_tileset folderPath:_folderPath];
    }
    else {
        layer = [[STLayer alloc] initWithLayerElement:layerElement tileset:_tileset folderPath:_folderPath];
    }
    
	[_layers setObject:layer forKey:[name lowercaseString]];
}

- (STLayer *)layerByName:(NSString *)name {
	name = [name lowercaseString];
	return [_layers objectForKey:name];
}

- (void)raiseXMLError:(NSString *)error message:(NSString *)message {
	[NSException raise:error format:[NSString stringWithFormat:@"Error while reading \"%@\", %@.", _filename, message], NSStringFromSelector(_cmd)];
}

- (NSMutableArray*)getOrderedLayers {
    NSMutableArray* array = [[NSMutableArray alloc] init];
    [array addObject:[self layerByName:@"ground"]];;
    [array addObject:[self layerByName:@"obstacles"]];;
    STLayer* movableObstaclesLayer = [self layerByName:@"movableObstacles"];
    if (movableObstaclesLayer) [array addObject:movableObstaclesLayer];;
    [array addObject:[self layerByName:@"characters"]];;

    return array;
}

- (NSMutableArray*)mergeArrays:(NSMutableArray*)arrays {
    NSMutableArray* result = [arrays objectAtIndex:0];
    
    for (NSMutableArray* curArray in arrays) {
        if (result == curArray) continue;
        
        for (STTile* newTile in curArray) {
            if (newTile.collisionType == NONE || newTile.type == STEMPTY) continue;
            [result replaceObjectAtIndex:[curArray indexOfObject:newTile] withObject:newTile];
        }
    }
    return result;
}

- (STTile*)getTileClosestToTileInDirection:(STTile*)tile direction:(Direction)direction {
    STTile* closestTile = nil;
    NSMutableArray* arrayToMerge = [[NSMutableArray alloc] init];
    NSMutableArray* curLineArray = [[NSMutableArray alloc] init];

    for (STLayer* layer in [self getOrderedLayers]) {
        if (direction == DirectionUp || direction == DirectionDown) {
            curLineArray = [layer getTilesInColumnOfTile:tile];
        }
        else if (direction == DirectionRight || direction == DirectionLeft) {
            curLineArray = [layer getTilesInRowOfTile:tile];
        }
        [arrayToMerge addObject:curLineArray];
    }

    NSMutableArray* lineArray = [self mergeArrays:arrayToMerge];
    NSLog(@"new Line");
    for (STTile* t in lineArray) NSLog(@"%d",t.type);
    
    //We are going forwards in the arrays to find the next Tile
    if (direction == DirectionDown || direction == DirectionRight) {
        for (STTile* curTile in lineArray) {
            if (curTile.collisionType == NONE) continue;
            if (direction == DirectionDown) {
                if (curTile.coordinate.y > tile.coordinate.y) {
                    closestTile = curTile;
                    break;
                }
            }
            else if (direction == DirectionRight) {
                if (curTile.coordinate.x > tile.coordinate.x) {
                    closestTile = curTile;
                    break;
                }
            }
            
        }
    }
    //We are going backwards in the arrays to find the next Tile
    if (direction == DirectionUp || direction == DirectionLeft) {
        for (STTile* curTile in [lineArray reverseObjectEnumerator]) {
            if (curTile.collisionType == NONE) continue;
            if (direction == DirectionUp) {
                if (curTile.coordinate.y < tile.coordinate.y) {
                    closestTile = curTile;
                    break;
                }
            }
            else if (direction == DirectionLeft) {
                if (curTile.coordinate.x < tile.coordinate.x) {
                    closestTile = curTile;
                    break;
                }
            }
        }
    }
    
    return closestTile;
}

- (STLayer*)getLayerWithTile:(STTile*)tile {
    NSEnumerator *enumerator = [_layers objectEnumerator];
    for (STLayer* layer in enumerator) {
        if ([layer containsTile:tile]) return layer;
    }
    return nil;
}

- (void)removeTile:(STTile*)tile {
    NSEnumerator *enumerator = [_layers objectEnumerator];
    STLayer* tileLayer;
    for (STLayer* layer in enumerator) {
        if ([layer containsTile:tile]) tileLayer = layer;
    }
    [tileLayer removeTile:tile];
}


@end
