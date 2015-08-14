//
//  Person.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-14.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//


#import "STTile.h"

@interface Character : STTile {
    
}


- (id)initWithType:(enum TileType)type texture:(SPTexture*)texture;

@end