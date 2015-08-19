//
//  PlayerAction.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-15.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

@interface Condition : NSObject
{

}

@property(nonatomic, readonly) NSString* condition;
@property(nonatomic, readonly) NSArray* values;



- (id)initWithString:(NSString*)string;


@end
