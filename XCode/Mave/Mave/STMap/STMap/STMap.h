//
//  STMap.h
//  SparrowTiled
//
//  Created by Shilo White on 2/19/11.
//  Copyright 2011 Shilocity Productions & Brian Ensor Apps. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
#import "HelperFunctions.h"

@class STTileset;
@class STLayer;
@class STTile;
@class NPC;
@interface STMap : NSObject {
//	NSString *mFilename;
//	NSString *mVersion;
//	NSString *mOrientation;
//	int mWidth;
//	int mHeight;
//	int mTileWidth;
//	int mTileHeight;
	int mPixelWidth;
	int mPixelHeight;
//	STTileset *mTileset;
	NSMutableDictionary *layers;
}

@property (nonatomic, strong, readonly) NSString *filename;
@property (nonatomic, strong, readonly) NSString *version;
@property (nonatomic, strong, readonly) NSString *orientation;
@property (nonatomic, readonly) int width;
@property (nonatomic, readonly) int height;
@property (nonatomic, readonly) int tileWidth;
@property (nonatomic, readonly) int tileHeight;
@property (nonatomic, readonly) int pixelWidth;
@property (nonatomic, readonly) int pixelHeight;
@property (nonatomic, strong, readonly) STTileset *tileset;
@property (nonatomic, strong, readonly) NSMutableDictionary *layers;
@property (nonatomic) float zoom;
@property (nonatomic, strong, readonly) NSString *folderPath;

- (id)initWithLevelFolderPath:(NSString *)folderPath filename:(NSString*)filename;
+ (STMap *)mapWithTMXFile:(NSString *)filename;
- (STLayer *)layerByName:(NSString *)name;
- (STTile*)getTileClosestToTileInDirection:(STTile*)tile direction:(Direction)direction;
- (STLayer*)getLayerWithTile:(STTile*)tile;

@end
