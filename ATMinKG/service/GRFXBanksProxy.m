//
// Created by Adilet Abylov on 12/6/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import "GRFXBanksProxy.h"
#import "AFHTTPRequestOperation.h"


@implementation GRFXBanksProxy
{

@private
    __weak id <GRFXBanksProxyDelegate> _delegate;
}
@synthesize delegate = _delegate;

- (void)fetchBanks
{

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:BANKS_URL]]];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSMutableArray *mutableArray = [NSMutableArray new];
        for (id bankData in responseObject)
        {
            [mutableArray addObject:[bankData objectForKey:@"name"]];
        }
        [_delegate banksProxySuccesWithBanks:mutableArray];
    }                                failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"fetchBanks error: %@", error);
        [_delegate banksProxyFailedWithMessage:@"Ошибка"];
    }];
    [operation start];
}

@end