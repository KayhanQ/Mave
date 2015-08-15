//
//  TileTouchedEvent.h
//  Bastion
//
//  Created by Kayhan Feroze Qaiser on 10/02/2015.
//
//

#import "BaseEvent.h"

#define EVENT_TYPE_LOAD_LEVEL @"loadLevel"

@interface LoadLevelEvent : BaseEvent
{
    
}

@property(nonatomic) NSString* levelName;

- (id)initWithType:(NSString *)type levelName:(NSString*)levelName;


@end