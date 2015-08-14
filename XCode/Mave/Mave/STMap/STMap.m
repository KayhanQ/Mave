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

#define ST_EXC_FILE_NOT_FOUND @"FileNotFoundOrInvalid"
#define ST_EXC_ELEMENT_NOT_FOUND @"ElementNotFound"

#import "STMap.h"
#import "TBXML.h"
#import "NSDataAdditions.h"
#import "STTileset.h"
#import "STLayer.h"
#import "STTile.h"

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
@synthesize zoom;

- (id)initWithTMXFile:(NSString *)filename {
	if (self = [super init]) {
		_filename = filename;
		
		[self loadXMLFile:filename];
	}
	return self;
}

+ (STMap *)mapWithTMXFile:(NSString *)filename {
	return [[STMap alloc]initWithTMXFile:filename];
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
	[self loadTileset:tilesetElement];
	
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
	
    NSLog(@"%d", _width);
    NSLog(@"%d", _height);
    NSLog(@"%d", _tileWidth);
    NSLog(@"%d", _width);
    NSLog(@"%d", _pixelWidth);

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
	
	_tileset = [[STTileset alloc] initWithFile:filename name:name firstGID:firstGID tileWidth:tileWidth tileHeight:tileHeight spacing:spacing margin:margin transparentColor:transparentColor width:width height:height];
}

- (void)loadLayer:(TBXMLElement *)layerElement {
	NSString *name = [TBXML valueOfAttributeNamed:@"name" forElement:layerElement];
	int width = [[TBXML valueOfAttributeNamed:@"width" forElement:layerElement] intValue];
	int height = [[TBXML valueOfAttributeNamed:@"height" forElement:layerElement] intValue];
	NSString *opacity = [TBXML valueOfAttributeNamed:@"opacity" forElement:layerElement];
	
	TBXMLElement *dataElement = [TBXML childElementNamed:@"data" parentElement:layerElement];
	if (!dataElement) [self raiseXMLError:ST_EXC_ELEMENT_NOT_FOUND message:@"\"data\" element doesn't exist"];
	TBXMLElement *tileElement = [TBXML childElementNamed:@"tile" parentElement:dataElement];
	if (!tileElement) [self raiseXMLError:ST_EXC_ELEMENT_NOT_FOUND message:@"\"tile\" element doesn't exist"];
	NSMutableArray *tileGIDS = [NSMutableArray arrayWithCapacity:10];
	while (tileElement) {
		NSNumber *tileGID = [NSNumber numberWithInt:[[TBXML valueOfAttributeNamed:@"gid" forElement:tileElement] intValue]];
		[tileGIDS addObject:tileGID];
		tileElement = [TBXML nextSiblingNamed:@"tile" searchFromElement:tileElement];
	}
	
	STLayer *layer = [[STLayer alloc] initWithName:name width:width height:height gids:tileGIDS tileset:_tileset];
	if (opacity) layer.alpha = [opacity floatValue]; 
	[_layers setObject:layer forKey:[name lowercaseString]];
}

- (STLayer *)layerByName:(NSString *)name {
	name = [name lowercaseString];
	return [_layers objectForKey:name];
}

- (void)raiseXMLError:(NSString *)error message:(NSString *)message {
	[NSException raise:error format:[NSString stringWithFormat:@"Error while reading \"%@\", %@.", _filename, message], NSStringFromSelector(_cmd)];
}

@end
