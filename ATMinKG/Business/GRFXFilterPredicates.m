//
// Created by Adilet Abylov on 12/10/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//

#import "GRFXFilterPredicates.h"


@implementation GRFXFilterPredicates
{

}
+ (NSPredicate *)predicateForCardTypeFilter:(CardTypeFilter)cardTypeFilter bankName:(NSString *)bankName
{
    NSPredicate *cardPredicate;
    switch (cardTypeFilter)
    {
        case  CardTypeFilterAll:
            cardPredicate = [NSPredicate predicateWithValue:YES];
            break;

        case CardTypeFilterMaster:
            cardPredicate = [NSPredicate predicateWithFormat:@"cardType = %d OR cardType = %d", CardTypeVisaMasterCard, CardTypeMasterCard];
            break;

        case CardTypeFilterVisa:
            cardPredicate = [NSPredicate predicateWithFormat:@"cardType = %d OR cardType = %d", CardTypeVisaMasterCard, CardTypeVisa];
            break;
    }

    NSPredicate *bankNamePredicate;
    if ([bankName isEqualToString:@"All Banks"])
    {
        bankNamePredicate = [NSPredicate predicateWithValue:YES];
    } else
    {
        bankNamePredicate = [NSPredicate predicateWithFormat:@"bankName = %@", bankName];
    }
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:cardPredicate, bankNamePredicate, nil]];
    return predicate;
}

@end