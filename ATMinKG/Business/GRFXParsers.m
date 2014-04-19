//
// Created by Adilet Abylov on 11/1/13.
// Copyright (c) 2013 Adilet Abylov. All rights reserved.
//


#import <DCKeyValueObjectMapping/DCKeyValueObjectMapping.h>
#import <DCKeyValueObjectMapping/DCObjectMapping.h>
#import <DCKeyValueObjectMapping/DCParserConfiguration.h>
#import "GRFXParsers.h"
#import "GRFXATM.h"
#import "DCCustomParser.h"


@implementation GRFXParsers
{

}

+ (DCKeyValueObjectMapping *)atmsParser
{
    DCParserConfiguration *config = [DCParserConfiguration configuration];

    DCObjectMapping *bankNameMapping = [DCObjectMapping mapKeyPath:@"bank" toAttribute:@"bankName" onClass:[GRFXATM class]];
    DCObjectMapping *idMapping = [DCObjectMapping mapKeyPath:@"id" toAttribute:@"atmId" onClass:[GRFXATM class]];
    DCObjectMapping *cardTypeMapping = [DCObjectMapping mapKeyPath:@"card_type" toAttribute:@"cardTypeString" onClass:[GRFXATM class]];
    [config addObjectMapping:bankNameMapping];
    [config addObjectMapping:idMapping];
    [config addObjectMapping:cardTypeMapping];

    return [DCKeyValueObjectMapping mapperForClass:[GRFXATM class] andConfiguration:config];
}

@end