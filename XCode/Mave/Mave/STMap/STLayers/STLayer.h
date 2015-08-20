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
@property (nonatomic) float zoom;
@property (nonatomic) SPImage* image;

- (id)initWithName:(NSString *)name LayerElement:(TBXMLElement*)layerElement tileset:(STTileset *)tileset;

- (STTile *)tileAtIndex:(int)index;
- (int)convertCoordinateToGID:(STCoordinate*)coordinate;
- (STTile*)getObstacleRelativeToTile:(enum RelativePosition)position tile:(STTile*)tile;
- (NSMutableArray*)getTilesInRowOfTile:(STTile*)tile;
- (NSMutableArray*)getTilesInColumnOfTile:(STTile*)tile;
- (void)moveTileTo:(STTile*)tile coordinate:(STCoordinate*)coordinate;



@end