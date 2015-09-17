//
//  FinishTile.h
//  Mave
//
//  Created by Kayhan Qaiser on 2015-09-17.
//  Copyright (c) 2015 Kayhan Qaiser. All rights reserved.
//

#import "STTile.h"

@interface FinishTile : STTile
{
    
}

@property(nonatomic, readonly)NSString* nextLevelName;
@property(nonatomic)BOOL functional;

- (id)initWithTexture:(SPTexture*)texture coordinate:(STCoordinate*)coordinate nextLevelName:(NSString*)nextLevelName functional:(BOOL)functional;

@end
