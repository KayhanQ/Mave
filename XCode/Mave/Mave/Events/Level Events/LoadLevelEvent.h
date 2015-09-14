//
//  TileTouchedEvent.h
//  Bastion
//
//  Created by Kayhan Feroze Qaiser on 10/02/2015.
//
//

#import "LevelEvent.h"

#define EVENT_TYPE_LOAD_LEVEL @"loadLevel"

@interface LoadLevelEvent : LevelEvent
{
    
}

- (id)initWithLevelName:(NSString*)levelName;


@end