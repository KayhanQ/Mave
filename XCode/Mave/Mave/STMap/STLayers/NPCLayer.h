//
//  CharacterLayer.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-17.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import "STLayer.h"

@interface NPCLayer : STLayer
{
    
}

- (Player*)getPlayer;
- (void)moveNPCTo:(STCoordinate*)coordinate;

@end