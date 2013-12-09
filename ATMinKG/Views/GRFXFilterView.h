//
// Created by Adilet Abylov on 12/6/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "GRFXATM.h"

@protocol GRFXFilterViewDelegate <NSObject>
- (void)filterViewDidApplyFilterForCards:(CardType)cardType bank:(NSString *)bank;
@end

@interface GRFXFilterView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

@property(weak) IBOutlet UISegmentedControl *cardsSegmentedControl;
@property(weak) IBOutlet UIPickerView *banksPickerView;
@property(weak) id <GRFXFilterViewDelegate> delegate;
@property(nonatomic) NSArray *banks;

- (IBAction)didTouchApply:(id)sender;
@end