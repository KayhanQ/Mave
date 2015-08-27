//
//  PlayerAction.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-15.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

@interface Condition : NSObject
{
    enum ConditionType {CTNONE = 0, CTHASITEM, CTLEVELPROGRESS, CTCUSTOM, CTINPOSITION};

}

@property(nonatomic, readonly) enum ConditionType conditionType;
@property(nonatomic, readonly) NSArray* values;



- (id)initWithString:(NSString*)string;


@end
