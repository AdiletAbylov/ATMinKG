//
// Created by Adilet Abylov on 11/1/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import "GRFXATMDetailsViewController.h"
#import "GRFXATM.h"
#import "GMSCameraPosition.h"
#import "GMSMapView.h"
#import "GMSMarker.h"


@implementation GRFXATMDetailsViewController
{
    GMSMapView *_mapView;
@private
    __weak UILabel *_bankNameLabel;
    __weak UILabel *_addressLabel;
    GRFXATM *_atm;
    __weak UIImageView *_visaCardImageView;
    __weak UIImageView *_masterCardImageView;
    __weak UITableViewCell *_mapCell;
}
@synthesize bankNameLabel = _bankNameLabel;
@synthesize addressLabel = _addressLabel;

@synthesize atm = _atm;

@synthesize visaCardImageView = _visaCardImageView;
@synthesize masterCardImageView = _masterCardImageView;

@synthesize mapCell = _mapCell;

- (void)viewDidLoad
{
    _bankNameLabel.text = _atm.bankName;
    _addressLabel.text = _atm.address;
    switch (_atm.cardType)
    {
        case CardTypeMasterCard:
            _masterCardImageView.alpha = 1.0;
            _visaCardImageView.alpha = 0.1;
            break;

        case CardTypeVisa:
            _masterCardImageView.alpha = 0.1;
            _visaCardImageView.alpha = 1;
            break;

        case CardTypeVisaMasterCard:
            _masterCardImageView.alpha = 1;
            _visaCardImageView.alpha = 1;
            break;
    }

    [self initMap];
}


- (void)initMap
{
    GMSCameraPosition *cameraPosition = [GMSCameraPosition cameraWithTarget:_atm.coordinate zoom:15];
    _mapView = [GMSMapView mapWithFrame:(CGRect) {0, 0, 320, 95} camera:cameraPosition];

    _mapView.delegate = self;
    [_mapCell.contentView addSubview:_mapView];

    GMSMarker *marker = [GMSMarker markerWithPosition:_atm.coordinate];
    marker.title = _atm.bankName;
    marker.snippet = _atm.address;
    marker.icon = [UIImage imageNamed:@"iconAtm.png"];
    marker.map = _mapView;
}

- (void)viewDidAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}
@end