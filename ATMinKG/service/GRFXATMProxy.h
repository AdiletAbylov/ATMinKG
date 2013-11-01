//
// Created by Adilet Abylov on 10/31/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "GRFXProxyDelegate.h"

@protocol GRFXATMProxyDelegate <GRFXProxyDelegate>
-(void)atmProxyCompleteWithATMS:(NSArray *)array;
@end;

@interface GRFXATMProxy : NSObject
@property (weak) id<GRFXATMProxyDelegate> delegate;
-(void)fetchAllTAMs;
-(void)fetchATMById:(NSString *)atmId;
@end