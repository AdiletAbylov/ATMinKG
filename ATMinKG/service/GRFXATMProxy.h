//
// Created by Adilet Abylov on 10/31/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface GRFXATMProxy : NSObject
-(void)fetchAllTAMs;
-(void)fetchATMById:(NSString *)atmId;
@end