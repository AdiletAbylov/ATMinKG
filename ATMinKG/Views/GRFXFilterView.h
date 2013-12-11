//
// Created by Adilet Abylov on 12/6/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "GRFXATM.h"


typedef enum CardTypeFilter
{
    CardTypeFilterAll,
    CardTypeFilterVisa,
    CardTypeFilterMaster

} CardTypeFilter;

@protocol GRFXFilterViewDelegate <NSObject>
- (void)filterViewDidApplyFilterForCards:(CardTypeFilter)cardTypeFilter bank:(NSString *)bank;
@end


@interface GRFXFilterView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

@property(weak) IBOutlet UISegmentedControl *cardsSegmentedControl;
@property(weak) IBOutlet UIPickerView *banksPickerView;
@property(weak) IBOutlet UIImageView *backgroundImageView;
@property(weak) id <GRFXFilterViewDelegate> delegate;
@property(nonatomic) NSArray *banks;
@property(nonatomic) NSString *selectedBank;
@property(nonatomic) CardTypeFilter selectedCardTypeFilter;

- (IBAction)didTouchApply:(id)sender;
@end