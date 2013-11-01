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
    double _lng;
    double _lat;
}
@synthesize address = _address;
@synthesize coordinate = _coordinate;
@synthesize cardType = _cardType;
@synthesize cardTypeString = _cardTypeString;
@synthesize bankName = _bankName;

@synthesize atmId = _atmId;

@synthesize lng = _lng;
@synthesize lat = _lat;

- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(_lat, _lng);
}

- (CardType)cardType
{
    if ([_cardTypeString isEqualToString:@"Visa"])
    {
        return CardTypeVisa;
    }
    if ([_cardTypeString isEqualToString:@"MasterCard"])
    {
        return CardTypeMasterCard;
    }
    if ([_cardTypeString isEqualToString:@"Both"])
    {
        return CardTypeVisaMasterCard;
    }
    return nil;
}
@end