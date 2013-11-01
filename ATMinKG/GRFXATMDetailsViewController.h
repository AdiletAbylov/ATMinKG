//
// Created by Adilet Abylov on 11/1/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import <Foundation/Foundation.h>

@class GRFXATM;


@interface GRFXATMDetailsViewController : UITableViewController
@property(weak) IBOutlet UILabel *bankNameLabel;
@property(weak) IBOutlet UILabel *addressLabel;
@property(weak) IBOutlet UILabel *cardTypeLabel;

@property GRFXATM *atm;

@end