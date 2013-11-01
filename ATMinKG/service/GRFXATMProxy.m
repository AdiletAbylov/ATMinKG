//
// Created by Adilet Abylov on 10/31/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import "GRFXATMProxy.h"
#import "AFHTTPRequestOperationManager.h"
#import "DCKeyValueObjectMapping.h"
#import "GRFXParsers.h"

#define ATMS_URL @"http://atm.spalmalo.com/atms.json"

@implementation GRFXATMProxy
{

@private
    __weak id <GRFXATMProxyDelegate> _delegate;
}
@synthesize delegate = _delegate;

- (void)fetchAllTAMs
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[[NSURL alloc] initWithString:ATMS_URL]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        DCKeyValueObjectMapping *parser = [GRFXParsers atmsParser];

        NSArray *atms = [parser parseArray:responseObject];
        [_delegate atmProxyCompleteWithATMS:atms];
    }                                failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"fetchAllTAMs error: %@", error);
        [_delegate proxyRequestFailedWithError:error];
    }];
    [operation start];
}

- (void)fetchATMById:(NSString *)atmId
{

}

@end