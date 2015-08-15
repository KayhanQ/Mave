//
//  STCoordinate.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-15.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import "STCoordinate.h"


@implementation STCoordinate

@synthesize x = _x;
@synthesize y = _y;

- (id)initWithX:(int)x y:(int)y {
    if (self = [super init]) {
        _x = x;
        _y = y;
    }
    return self;
}
@end