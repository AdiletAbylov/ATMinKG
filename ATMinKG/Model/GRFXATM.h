//
// Created by Adilet Abylov on 10/29/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef enum CardType
{
    CardTypeVisa,
    CardTypeMasterCard,
    CardTypeVisaMasterCard
} CardType;

@interface GRFXATM : NSObject
@property NSString *atmId;
@property NSString *address;
@property double lng;
@property double lat;
@property(readonly) CLLocationCoordinate2D coordinate;
@property(readonly) CardType cardType;
@property NSString *cardTypeString;
@property NSString *bankName;
@end