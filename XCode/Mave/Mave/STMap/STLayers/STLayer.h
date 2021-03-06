//
//  STLayer.h
//  SparrowTiled
//
//  Created by Shilo White on 2/19/11.
//  Copyright 2011 Shilocity Productions & Brian Ensor Apps. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"


@class STTileset;
@class STTile;
@class FinishTile;
@class SPImage;
@class SPRenderTexture;
@class Player;
@class STCoordinate;


@interface STLayer : SPSprite {
    enum RelativePosition {ABOVE = 0, RIGHT, BELOW, LEFT};
    
//	NSString *mLayerName;
//	int mWidth;
//	int mHeight;
//	int mTileWidth;
//	int mTileHeight;

    int pixelWidth;
    int pixelHeight;

    @protected
    SPSprite* _tiles;
    STTileset* _tileSet;
    
    //	NSMutableArray *mTiles;
//	SPRenderTexture *mRenderTexture;
    
}

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, readonly) int width;
@property (nonatomic, readonly) int height;
@property (nonatomic, readonly) int tileWidth;
@property (nonatomic, readonly) int tileHeight;
@property (nonatomic, readonly) int pixelWidth;
@property (nonatomic, readonly) int pixelHeight;
@property (nonatomic, readonly) float trueRotation;
@property (nonatomic, readonly) float viewWidth;
@property (nonatomic, readonly) float viewHeight;
@property (nonatomic, readonly) float zoom;

- (id)initWithLayerElement:(TBXMLElement*)layerElement tileset:(STTileset *)tileset folderPath:(NSString*)folderPath;

- (int)convertCoordinateToGID:(STCoordinate*)coordinate;
- (STTile*)getObstacleRelativeToTile:(enum RelativePosition)position tile:(STTile*)tile;
- (NSMutableArray*)getTilesInRowOfTile:(STTile*)tile;
- (NSMutableArray*)getTilesInColumnOfTile:(STTile*)tile;
- (void)moveTileTo:(STTile*)tile coordinate:(STCoordinate*)coordinate;
- (BOOL)containsTile:(STTile*)tile;
- (STTile*)tileAtIndex:(int)index;
- (STTile*)tileAtCoordinate:(STCoordinate*)coordinate;
- (void)swapTile:(STTile*)tile1 withTile:(STTile*)tile2;
- (FinishTile*)getFinishTileForNextLevel:(NSString*)nextLevel;

- (float)convertCoordinateToX:(STCoordinate*)coordinate;
- (float)convertCoordinateToY:(STCoordinate*)coordinate;
    
- (void)removeTile:(STTile*)tile;

@end