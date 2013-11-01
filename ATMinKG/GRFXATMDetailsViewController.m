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
    __weak UILabel *_cardTypeLabel;
    GRFXATM *_atm;
}
@synthesize bankNameLabel = _bankNameLabel;
@synthesize addressLabel = _addressLabel;
@synthesize cardTypeLabel = _cardTypeLabel;
@synthesize atm = _atm;

- (void)viewDidLoad
{
    _bankNameLabel.text = _atm.bankName;
    _addressLabel.text = _atm.address;
    _cardTypeLabel.text = _atm.cardTypeString;
}
- (void)viewDidAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}
@end