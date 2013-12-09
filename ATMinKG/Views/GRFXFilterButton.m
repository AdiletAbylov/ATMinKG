//
// Created by Adilet Abylov on 12/9/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//

#import "GRFXFilterButton.h"


@implementation GRFXFilterButton
{
    UIImageView *_visaCardImageView;
    UIImageView *_masterCardImageView;
    UILabel *_bankNameLabel;

@private
    CardType _selectedCardType;
    NSString *_selectedBank;
}
@synthesize selectedCardType = _selectedCardType;
@synthesize selectedBank = _selectedBank;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initCards];
        [self initLabel];
        [self applyCardTypes];
        [self setBackgroundImage:[UIImage imageNamed:@"filterBarBg.png"] forState:UIControlStateNormal];
    }

    return self;
}

- (void)initCards
{
    _visaCardImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconVisa.png"]];
    _visaCardImageView.frame = (CGRect) {12, 9, 37, 22};

    _masterCardImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconMastercard.png"]];
    _masterCardImageView.frame = (CGRect) {_visaCardImageView.frame.origin.x + _visaCardImageView.frame.size.width + 5, 9, 37, 22};

    [self addSubview:_visaCardImageView];
    [self addSubview:_masterCardImageView];
}


- (void)initLabel
{
    CGFloat labeOffset = _masterCardImageView.frame.origin.x + _masterCardImageView.frame.size.width + 5;
    _bankNameLabel = [[UILabel alloc] initWithFrame:(CGRect) {labeOffset, 9, self.frame.size.width - labeOffset, 22}];
    _bankNameLabel.text = _selectedBank;
    _bankNameLabel.font = [UIFont systemFontOfSize:15];
    _bankNameLabel.textColor = [UIColor colorWithRed:0 green:121 / 255.0 blue:1 alpha:1];
    _bankNameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_bankNameLabel];
}

- (void)applyCardTypes
{
    switch (_selectedCardType)
    {
        case CardTypeVisa:
            _visaCardImageView.alpha = 1;
            _masterCardImageView.alpha = 0.1;
            break;

        case CardTypeMasterCard:
            _visaCardImageView.alpha = 0.1;
            _masterCardImageView.alpha = 1;
            break;

        case CardTypeVisaMasterCard:
            _visaCardImageView.alpha = 1;
            _masterCardImageView.alpha = 1;
            break;
    }
}

- (void)setSelectedBank:(NSString *)selectedBank
{
    _selectedBank = selectedBank;
    _bankNameLabel.text = selectedBank;
}


- (void)setSelectedCardType:(CardType)selectedCardType
{
    _selectedCardType = selectedCardType;
    [self applyCardTypes];
}
@end