//
//  Player.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-14.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import "NPC.h"
@class Item;

@interface Player : NPC
{
    
}


- (id)initWithType:(enum STType)type texture:(SPTexture*)texture coordinate:(STCoordinate*)coordinate filename:(NSString*)filename;


@end