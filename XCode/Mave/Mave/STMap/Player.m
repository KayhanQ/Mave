//
//  Player.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-14.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@implementation Player

- (id)initWithType:(enum TileType)type texture:(SPTexture *)texture
{
    if ((self = [super initWithType:CHARACTER texture:texture])) {

        
    }
    return self;
}

@end