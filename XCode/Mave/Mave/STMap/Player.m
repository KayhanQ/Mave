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

- (id)initWithType:(enum STType)type texture:(SPTexture*)texture coordinate:(STCoordinate*)coordinate filename:(NSString*)filename {
    if ((self = [super initWithType:STCHARACTER texture:texture coordinate:coordinate filename:filename])) {

        
    }
    return self;
}

@end