//
// Created by Adilet Abylov on 12/6/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import <Foundation/Foundation.h>

#define BANKS_URL @"http://atm.spalmalo.com/banks.json"

@protocol GRFXBanksProxyDelegate <NSObject>
- (void)banksProxySuccesWithBanks:(NSArray *)banks;

- (void)banksProxyFailedWithMessage:(NSString *)message;
@end

@interface GRFXBanksProxy : NSObject
- (void)fetchBanks;

@property(weak) id <GRFXBanksProxyDelegate> delegate;
@end