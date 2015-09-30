//
//  Animator.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-09-30.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

@interface Animator : NSObject {

}

@property (nonatomic, retain) SPJuggler *mainJuggler;

+ (id)sharedAnimator;

@end
