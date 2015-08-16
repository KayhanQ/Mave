//
//  Person.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-14.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//


#import "BasicTile.h"

#define ST_EXC_FILE_NOT_FOUND @"FileNotFoundOrInvalid"
#define ST_EXC_ELEMENT_NOT_FOUND @"ElementNotFound"

@interface NPC : BasicTile {
    
}

@property(nonatomic, readonly) NSString* filename;
@property(nonatomic, readonly) NSString* npcID;
@property(nonatomic, readonly) NSString* displayName;
@property(nonatomic, readonly) NSMutableArray* speeches;

- (id)initWithType:(enum STType)type texture:(SPTexture*)texture coordinate:(STCoordinate*)coordinate dialogueFileName:(NSString*)filename;

@end