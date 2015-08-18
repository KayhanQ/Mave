//
//  TileTouchedEvent.h
//  Bastion
//
//  Created by Kayhan Feroze Qaiser on 10/02/2015.
//
//

#import "BasicEvent.h"

#define EVENT_TYPE_LOAD_LEVEL @"loadLevel"

@interface LoadLevelEvent : BasicEvent
{
    
}

@property(nonatomic, readonly) NSString* levelName;

- (id)initWithType:(NSString *)type levelName:(NSString*)levelName;


@end