//
//  CarMarket.h
//  CarRental
//
//  Created by sbxfc on 16/7/29.
//  Copyright © 2016年 me.rungame.sbxfc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarMarket : UITableView

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic,copy,readonly) NSString* identifier;
@property (nonatomic,copy,readonly) NSString* title;
@property (nonatomic,copy,readonly) NSString* mileage;
@property (nonatomic,copy,readonly) NSString* time;
@property (nonatomic,copy,readonly) NSString* date;
@property (nonatomic,copy,readonly) NSString* photo;
@property (nonatomic,copy,readonly) NSString* price;


@end
