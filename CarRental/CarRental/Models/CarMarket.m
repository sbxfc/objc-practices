//
//  CarMarket.m
//  CarRental
//
//  Created by sbxfc on 16/7/29.
//  Copyright © 2016年 me.rungame.sbxfc. All rights reserved.
//

#import "CarMarket.h"

@implementation CarMarket

-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = super.init;
    if (self) {
        _identifier = [self uniqueIdentifier];
        _title = dict[@"title"];
        _time = dict[@"time"];
        _date = dict[@"date"];
        _photo = dict[@"photo"];
        _mileage = dict[@"mileage"];
        _price = dict[@"price"];
    }
    return self;
}

- (NSString *)uniqueIdentifier
{
    static NSInteger counter = 0;
    return [NSString stringWithFormat:@"unique-id-%@", @(counter++)];
}

@end
