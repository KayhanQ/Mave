//
//  STTileset.h
//  SparrowTiled
//
//  Created by Shilo White on 2/19/11.
//  Copyright 2011 Shilocity Productions & Brian Ensor Apps. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>

@class SPTexture;

@interface STTileset : SPTextureAtlas {
//	NSString *mName;
//    NSString *mFilename;
//	int mFirstGID;
//	int mTileWidth;
//	int mTileHeight;
//	int mSpacing;
//	int mMargin;
//	NSString *mTransparentColor;
//	int mWidth;
//	int mHeight;
}

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *filename;
@property (nonatomic, readonly) int firstGID;
@property (nonatomic, readonly) int tileWidth;
@property (nonatomic, readonly) int tileHeight;
@property (nonatomic, readonly) int spacing;
@property (nonatomic, readonly) int margin;
@property (nonatomic, strong, readonly) NSString *transparentColor;
@property (nonatomic, readonly) int width;
@property (nonatomic, readonly) int height;

- (id)initWithFile:(NSString *)filename name:(NSString *)name firstGID:(int)firstGID tileWidth:(int)tileWidth tileHeight:(int)tileHeight spacing:(int)spacing margin:(int)margin transparentColor:(NSString *)transparentColor width:(int)width height:(int)height;
- (SPTexture *)textureByGID:(int)gid;
@end
