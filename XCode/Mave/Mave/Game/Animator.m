//
//  Animator.m
//  Mave
//
//  Created by Kayhan Qaiser on 2015-09-30.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Animator.h"

@implementation Animator

@synthesize mainJuggler = _mainJuggler;

#pragma mark Singleton Methods

+ (id)sharedAnimator {
    static Animator *sharedAnimator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAnimator = [[self alloc] init];
    });
    return sharedAnimator;
}

- (id)init {
    if (self = [super init]) {
        _mainJuggler = [[SPJuggler alloc] init];
    }
    return self;
}



@end