//
//  CarMarketTableViewCell.m
//  CarRental
//
//  Created by sbxfc on 16/7/29.
//  Copyright © 2016年 me.rungame.sbxfc. All rights reserved.
//

#import "CarMarketTableViewCell.h"
#import "CarMarket.h"

@interface CarMarketTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end

@implementation CarMarketTableViewCell

- (void)setMarketData:(CarMarket *)data
{
    _marketData = data;
    
    self.titleLabel.text = data.title;
    self.subtitleLabel.text = [NSString stringWithFormat:@"%@/%@",data.mileage,data.date];
    self.priceLabel.text = data.price;
    self.timeLabel.text = data.time;
}

// If you are not using auto layout, override this method, enable it by setting
// "enforceFrameLayout" to YES.
- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat totalHeight = 120; //图片高度
    return CGSizeMake(size.width, totalHeight);
}

@end
