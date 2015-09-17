//
//  HelperFunctions.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-09-17.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HelperFunctions.h"

@implementation HelperFunctions

+ (BOOL)stringToBool:(NSString*)string {
    string = [string lowercaseString];
    if ([string isEqualToString:@"true"]) return true;
    if ([string isEqualToString:@"false"]) return false;
    if ([string isEqualToString:@"yes"]) return true;
    if ([string isEqualToString:@"no"]) return false;
    
    return nil;
}

+ (Direction)directionFromString:(NSString *)string {
    Direction direction;
    if ([string isEqualToString:@"up"]) direction = DirectionUp;
    else if ([string isEqualToString:@"right"]) direction = DirectionRight;
    else if ([string isEqualToString:@"down"]) direction = DirectionDown;
    else if ([string isEqualToString:@"left"]) direction = DirectionLeft;
    return direction;
}

+ (Direction)directionFromUISwipeGestureRecognizerDirection:(UISwipeGestureRecognizerDirection)swipeDirection {
    Direction direction;
    switch (swipeDirection) {
        case UISwipeGestureRecognizerDirectionUp:
        {
            direction = DirectionUp;
            break;
        }
        case UISwipeGestureRecognizerDirectionRight:
        {
            direction = DirectionRight;
            break;
        }
        case UISwipeGestureRecognizerDirectionDown:
        {
            direction = DirectionDown;
            break;
        }
        case UISwipeGestureRecognizerDirectionLeft:
        {
            direction = DirectionLeft;
            break;
        }
        default:
            break;
    }
    
    return direction;
}

@end