//
//  BasicTile.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-14.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import "BasicTile.h"

@implementation BasicTile

- (id)initWithType:(enum STType)type texture:(SPTexture *)texture coordinate:(STCoordinate*)coordinate {
    if (self = [super initWithType:type coordinate:coordinate]) {
        SPImage* image = [SPImage imageWithTexture:texture];
        [self addChild:image];
    }
    return self;
}

@end