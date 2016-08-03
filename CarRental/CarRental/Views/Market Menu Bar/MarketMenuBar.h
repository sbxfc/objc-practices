//
//  MarketMenuBar.h
//  CarRental
//
//  Created by sbxfc on 16/7/29.
//  Copyright © 2016年 me.rungame.sbxfc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MARKET_MENU_BAR_HEIGHT_DEFAULT 50

@protocol MarketMenuBarDelegate
- (void) marketMenuBarTouched:(NSInteger)menuType withTag:(NSInteger)tag;
@end

@interface MarketMenuBar : UIView
@property (nonatomic, weak) id <MarketMenuBarDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame dictionary:(NSDictionary*)dict andType:(NSInteger)type;
@end
