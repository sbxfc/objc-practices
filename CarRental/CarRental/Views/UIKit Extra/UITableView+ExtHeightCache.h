//
//  UITableView+ExtHeightCache.h
//  CarRental
//
//  Created by sbxfc on 16/7/29.
//  Copyright © 2016年 me.rungame.sbxfc. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UITableView_ExtHeightCache : NSObject

-(BOOL)exitsHeightForKey:(id<NSCopying>) key;
-(void)cacheHeight:(CGFloat)height byKey:(id<NSCopying>) key;
-(CGFloat)heightForKey:(id<NSCopying>) key;


@end


@interface UITableView(ExtHeightCache)

@property (nonatomic, strong, readonly) UITableView_ExtHeightCache *cellHeightCache;

-(CGFloat) heightForCellWithIdentifier:(NSString *)identifier cacheByKey:(id<NSCopying>)key configuration:(void (^)(id cell))configuration;

@end
