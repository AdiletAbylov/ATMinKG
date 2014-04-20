//
// Created by Adilet Abylov on 10/29/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


typedef enum CardType
{
    CardTypeVisa,
    CardTypeMasterCard,
    CardTypeVisaMasterCard
} CardType;

@interface GRFXATM : NSObject <MKAnnotation>
@property NSString *atmId;
@property NSString *address;
@property double lng;
@property double lat;
@property(readonly, nonatomic) CLLocationCoordinate2D coordinate;
@property(readonly) CardType cardType;
@property NSString *cardTypeString;
@property NSString *bankName;
@property(readonly, nonatomic) MKPointAnnotation *annotation;

@end