//
//  BasicTile.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-14.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import "BasicTile.h"

@implementation BasicTile

- (id)initWithType:(enum TileType)type texture:(SPTexture *)texture {
    if (self = [super initWithType:type]) {
        SPImage* image = [SPImage imageWithTexture:texture];
        [self addChild:image];
    }
    return self;
}

@end