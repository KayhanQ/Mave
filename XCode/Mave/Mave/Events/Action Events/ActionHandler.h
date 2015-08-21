//
//  NPCTouchedEvent.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-16.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

@class ActionEvent;

@interface ActionHandler : NSObject
{
    
}

+ (ActionEvent*)makeActionEvent:(NSString*)string;

@end