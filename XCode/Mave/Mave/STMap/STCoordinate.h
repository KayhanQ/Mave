//
//  STCoordinate.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-15.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STCoordinate : NSObject {

}

@property (nonatomic, readonly) int x;
@property (nonatomic, readonly) int y;

- (id)initWithX:(int)x y:(int)y;

@end