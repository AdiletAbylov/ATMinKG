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


- (CardTypeFilter)cardTypeFilterFromSegmentedControl
{
    switch (_cardsSegmentedControl.selectedSegmentIndex)
    {
        case 0:
            return CardTypeFilterAll;
        case 1:
            return CardTypeFilterVisa;
        case 2:
            return CardTypeFilterMaster;
    }
    return CardTypeFilterAll;
}

- (IBAction)didTouchApply:(id)sender
{
    [_delegate filterViewDidApplyFilterForCards:[self cardTypeFilterFromSegmentedControl] bank:self.selectedBank];
}

- (void)setBanks:(NSArray *)banks
{
    _banks = banks;
    [_banksPickerView reloadAllComponents];
}

- (CardTypeFilter)selectedCardTypeFilter
{
    return [self cardTypeFilterFromSegmentedControl];
}

- (NSString *)selectedBank
{
    return [_banks objectAtIndex:[_banksPickerView selectedRowInComponent:0]];
}
@end