//
//  STTile.m
//  SparrowTiled
//
//  Created by Shilo White on 2/19/11.
//  Copyright 2011 Shilocity Productions & Brian Ensor Apps. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "STTile.h"


@implementation STTile

@synthesize type = _type;

- (id)initWithType:(enum TileType)type {
	if (self = [super init]) {
        _type = type;
	}
	return self;
}

@end
