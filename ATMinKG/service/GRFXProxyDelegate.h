//
// Created by Adilet Abylov on 10/31/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import <Foundation/Foundation.h>

@protocol GRFXProxyDelegate <NSObject>
-(void)proxyRequestFailedWithError:(NSError *)error;
@end