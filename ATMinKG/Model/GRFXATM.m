//
// Created by Adilet Abylov on 10/29/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import "GRFXATM.h"


@implementation GRFXATM
{

@private
    NSString *_address;
    CLLocationCoordinate2D _coordinate;
    CardType _cardType;
    NSString *_cardTypeString;
    NSString *_bankName;
    NSString *_atmId;
}
@synthesize address = _address;
@synthesize coordinate = _coordinate;
@synthesize cardType = _cardType;
@synthesize cardTypeString = _cardTypeString;
@synthesize bankName = _bankName;

@synthesize atmId = _atmId;

- (NSString *)bankName
{
    switch (_cardType)
    {
        case CardTypeMasterCard:
            return @"MasterCard";

        case CardTypeVisa:
            return @"Visa";

        default:
            return @"";
    }
}
@end