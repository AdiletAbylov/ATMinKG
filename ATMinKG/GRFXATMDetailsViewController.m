//
// Created by Adilet Abylov on 11/1/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import "GRFXATMDetailsViewController.h"
#import "GRFXATM.h"


@implementation GRFXATMDetailsViewController
{

@private
    __weak UILabel *_bankNameLabel;
    __weak UILabel *_addressLabel;
    GRFXATM *_atm;
    __weak UIImageView *_visaCardImageView;
    __weak UIImageView *_masterCardImageView;
}
@synthesize bankNameLabel = _bankNameLabel;
@synthesize addressLabel = _addressLabel;

@synthesize atm = _atm;

@synthesize visaCardImageView = _visaCardImageView;
@synthesize masterCardImageView = _masterCardImageView;

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
}

- (void)viewDidAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}
@end