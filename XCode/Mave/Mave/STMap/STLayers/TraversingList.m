//
//  TraversingList.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-09-16.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TraversingList.h"

@implementation TraversingList
{
    int _index;
    NSArray* _array;
}

- (id)initWithArray:(NSArray *)array {
    if (self = [super init]) {
        _index = 0;
        _array = [[NSArray alloc] initWithArray:array];
    }
    return self;
}

- (id)getNextObject {
    if (_index >= [_array count]) return nil;
    
    id objectToReturn = [_array objectAtIndex:_index];
    _index++;
    return objectToReturn;
}

@end