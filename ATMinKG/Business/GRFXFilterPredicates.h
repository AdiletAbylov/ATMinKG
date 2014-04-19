//
// Created by Adilet Abylov on 12/10/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GRFXFilterView.h"


@interface GRFXFilterPredicates : NSObject
+ (NSPredicate *)predicateForCardTypeFilter:(CardTypeFilter)cardTypeFilter bankName:(NSString *)bankName;
@end