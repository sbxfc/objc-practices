//
//  UITableView+ExtHeightCache.m
//  CarRental
//
//  Created by sbxfc on 16/7/29.
//  Copyright © 2016年 me.rungame.sbxfc. All rights reserved.
//

#import "UITableView+ExtHeightCache.h"
#import <objc/runtime.h>

@interface UITableView_ExtHeightCache()
@property (nonatomic, strong) NSMutableDictionary<id<NSCopying>, NSNumber *> *mutableHeightsByKeyForPortrait;
@property (nonatomic, strong) NSMutableDictionary<id<NSCopying>, NSNumber *> *mutableHeightsByKeyForLandscape;
@end

@implementation UITableView_ExtHeightCache

- (instancetype)init {
    self = [super init];
    if (self) {
        _mutableHeightsByKeyForPortrait = [NSMutableDictionary dictionary];
        _mutableHeightsByKeyForLandscape = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSMutableDictionary<id<NSCopying>, NSNumber *> *)mutableHeightsByKeyForCurrentOrientation {
    return UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation) ? self.mutableHeightsByKeyForPortrait: self.mutableHeightsByKeyForLandscape;
}

-(BOOL)exitsHeightForKey:(id<NSCopying>)key
{
    NSNumber *number = self.mutableHeightsByKeyForCurrentOrientation[key];
    return number && ![number isEqualToNumber:@-1];
}

-(void)cacheHeight:(CGFloat)height byKey:(id<NSCopying>)key
{
    self.mutableHeightsByKeyForCurrentOrientation[key] = @(height);
}

- (CGFloat)heightForKey:(id<NSCopying>)key {
#if CGFLOAT_IS_DOUBLE
    return [self.mutableHeightsByKeyForCurrentOrientation[key] doubleValue];
#else
    return [self.mutableHeightsByKeyForCurrentOrientation[key] floatValue];
#endif
}

@end



@implementation UITableView(ExtHeightCache)

- (__kindof UITableViewCell *)templateCellForReuseIdentifier:(NSString *)identifier {
    NSAssert(identifier.length > 0, @"Expect a valid identifier - %@", identifier);
    
    NSMutableDictionary<NSString *, UITableViewCell *> *templateCellsByIdentifiers = objc_getAssociatedObject(self, _cmd);
    if (!templateCellsByIdentifiers) {
        templateCellsByIdentifiers = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, templateCellsByIdentifiers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    UITableViewCell *templateCell = templateCellsByIdentifiers[identifier];
    
    if (!templateCell) {
        templateCell = [self dequeueReusableCellWithIdentifier:identifier];
        NSAssert(templateCell != nil, @"Cell must be registered to table view for identifier - %@", identifier);
        templateCellsByIdentifiers[identifier] = templateCell;
    }
    
    return templateCell;
}

- (CGFloat)heightForCellWithIdentifier:(NSString *)identifier configuration:(void (^)(id cell))configuration {
    if (!identifier) {
        return 0;
    }
    
    UITableViewCell *templateLayoutCell = [self templateCellForReuseIdentifier:identifier];
    
    // Manually calls to ensure consistent behavior with actual cells. (that are displayed on screen)
    [templateLayoutCell prepareForReuse];
    
    // Customize and provide content for our template cell.
    if (configuration) {
        configuration(templateLayoutCell);
    }
    
    return [self systemFittingHeightForConfiguratedCell:templateLayoutCell];
}

- (CGFloat)systemFittingHeightForConfiguratedCell:(UITableViewCell *)cell {
    CGFloat contentViewWidth = CGRectGetWidth(self.frame);
    CGFloat fittingHeight = [cell sizeThatFits:CGSizeMake(contentViewWidth, 0)].height;
    return fittingHeight;
}

- (UITableView_ExtHeightCache *)cellHeightCache {
    UITableView_ExtHeightCache *cache = objc_getAssociatedObject(self, _cmd);
    if (!cache) {
        cache = [UITableView_ExtHeightCache new];
        objc_setAssociatedObject(self, _cmd, cache, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return cache;
}

-(CGFloat) heightForCellWithIdentifier:(NSString *)identifier cacheByKey:(id<NSCopying>)key configuration:(void (^)(id))configuration
{
    CGFloat height;
    if([self.cellHeightCache exitsHeightForKey:key]){
        height = [self.cellHeightCache heightForKey:key];
    }
    else{
        height = [self heightForCellWithIdentifier:identifier configuration:configuration];
        [self.cellHeightCache cacheHeight:height byKey:key];
    }
    
    return height;
}

@end

