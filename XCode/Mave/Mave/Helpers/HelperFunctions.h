//
//  HelperFunctions.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-09-17.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

typedef NS_OPTIONS(NSUInteger, Direction) {
    DirectionRight = 1 << 0,
    DirectionLeft  = 1 << 1,
    DirectionUp    = 1 << 2,
    DirectionDown  = 1 << 3
};

@interface HelperFunctions : NSObject
{
    
}

+ (BOOL)stringToBool:(NSString*)string;
+ (Direction)directionFromString:(NSString*)string;
+ (Direction)directionFromUISwipeGestureRecognizerDirection:(UISwipeGestureRecognizerDirection)swipeDirection;


@end