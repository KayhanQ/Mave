//
//  STTileset.m
//  SparrowTiled
//
//  Created by Shilo White on 2/19/11.
//  Copyright 2011 Shilocity Productions & Brian Ensor Apps. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "STTileset.h"


@interface STTileset ()
- (void)setRegions;
- (SPTexture *)textureWithContentsOfFile:(NSString *)filename transparentColor:(NSString *)transparentColor width:(int)width height:(int)height;
@end

@implementation STTileset

@synthesize name = _name;
@synthesize filename = _fileName;
@synthesize firstGID = _firstGid;
@synthesize tileWidth = _tileWidth;
@synthesize tileHeight = _tileHeight;
@synthesize spacing = _spacing;
@synthesize margin = _margin;
@synthesize transparentColor = _transparentColor;
@synthesize width = _width;
@synthesize height = _height;

- (id)initWithFile:(NSString *)filename name:(NSString *)name firstGID:(int)firstGID tileWidth:(int)tileWidth tileHeight:(int)tileHeight spacing:(int)spacing margin:(int)margin transparentColor:(NSString *)transparentColor width:(int)width height:(int)height {
	if (self = [super initWithTexture:[self textureWithContentsOfFile:filename transparentColor:transparentColor width:width height:height]]) {
		_fileName = filename;
		_name = name;
		_firstGid = firstGID;
		_tileWidth = tileWidth;
		_tileHeight = tileHeight;
		_spacing = spacing;
		_margin = margin;
		_transparentColor = transparentColor;
		_width = width;
		_height = height;
		
		[self setRegions];
	}
	return self;
}

- (SPTexture *)textureWithContentsOfFile:(NSString *)filename transparentColor:(NSString *)transparentColor width:(int)width height:(int)height {
    //transparent colour code is broken. it wipes over everything
	if (transparentColor) {
		uint transColor;
		[[NSScanner scannerWithString:transparentColor] scanHexInt:&transColor];
		uint red = (((transColor) >> 16) & 0xff);
		uint green = (((transColor) >> 8) & 0xff);
		uint blue = ((transColor) & 0xff);
		
		return [SPTexture textureWithWidth:width height:height
			draw:^(CGContextRef context) {
				CGImageRef imageRef = [UIImage imageNamed:filename].CGImage;
				const CGFloat maskingColors[6] = {red, red, green, green, blue, blue};
				CGImageRef maskedImage = CGImageCreateWithMaskingColors(imageRef, maskingColors);
				CGContextTranslateCTM(context, 0, height);
				CGContextScaleCTM(context, 1.0, -1.0);
				CGContextDrawImage(context, CGRectMake(0, 0, width, height), maskedImage);
			}];
	} else {
		return [SPTexture textureWithContentsOfFile:filename];
	}
}

- (void)setRegions {
	int i = _firstGid;
	for (int y=_spacing; y+_tileHeight+_margin<=_height; y+=_tileHeight+_margin) {
		for (int x=_spacing; x+_tileWidth+_margin<=_width; x+=_tileWidth+_margin) {
			SPRectangle *region = [SPRectangle rectangleWithX:x y:y width:_tileWidth height:_tileHeight];
			[self addRegion:region withName:[NSString stringWithFormat:@"%i", i++]];
		}
	}
}

- (SPTexture *)textureByGID:(int)gid {
	return [self textureByName:[NSString stringWithFormat:@"%i", gid]];
}

- (void)dealloc {

    
}
@end
