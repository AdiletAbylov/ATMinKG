//
// Created by Adilet Abylov on 12/6/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import "GRFXFilterView.h"



@implementation GRFXFilterView
{

@private
    __weak UISegmentedControl *_cardsSegmentedControl;
    __weak UIPickerView *_banksPickerView;
    __weak id <GRFXFilterViewDelegate> _delegate;
    NSArray *_banks;
    __weak UIImageView *_backgroundImageView;
}
@synthesize cardsSegmentedControl = _cardsSegmentedControl;
@synthesize banksPickerView = _banksPickerView;

@synthesize delegate = _delegate;

@synthesize banks = _banks;

@synthesize backgroundImageView = _backgroundImageView;

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _banks.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_banks objectAtIndex:row];
}



- (CardType)cardType
{
    switch (_cardsSegmentedControl.selectedSegmentIndex)
    {
        case 0:
            return CardTypeVisaMasterCard;
        case 1:
            return CardTypeVisa;
        case 2:
            return CardTypeMasterCard;
    }
    return CardTypeVisaMasterCard;
}

- (IBAction)didTouchApply:(id)sender
{
    [_delegate filterViewDidApplyFilterForCards:[self cardType] bank:[_banks objectAtIndex:[_banksPickerView selectedRowInComponent:0]]];
}

- (void)setBanks:(NSArray *)banks
{
    _banks = banks;
    [_banksPickerView reloadAllComponents];
}

- (void)setBlurredImage:(UIImage *)image
{
    _backgroundImageView.image = image;
}

@end