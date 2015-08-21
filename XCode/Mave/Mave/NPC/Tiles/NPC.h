//
//  Person.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-08-14.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//


#import "STTile.h"
#import "TBXML.h"


@interface NPC : STTile {
    
}

@property(nonatomic, readonly) NSString* filename;
@property(nonatomic, readonly) NSString* npcID;
@property(nonatomic, readonly) NSString* displayName;
@property(nonatomic, readonly) NSMutableArray* speeches;

- (id)initWithType:(enum STType)type texture:(SPTexture*)texture coordinate:(STCoordinate*)coordinate filename:(NSString*)filename;
- (BOOL)npcIDEquals:(NSString*)npcID;


@end