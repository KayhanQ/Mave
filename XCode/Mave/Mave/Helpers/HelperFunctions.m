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

@end