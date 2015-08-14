//
//  BasicTile.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-14.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STTile.h"

@interface BasicTile : STTile {
    
}


- (id)initWithType:(enum TileType)type texture:(SPTexture*)texture;

@end