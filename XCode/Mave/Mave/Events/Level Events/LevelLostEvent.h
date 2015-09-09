//
//  LevelLostEvent.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-09-04.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import "BasicEvent.h"

#define EVENT_TYPE_LEVEL_LOST @"levelLost"

@interface LevelLostEvent : BasicEvent
{
    
}


- (id)initLevelLost;


@end