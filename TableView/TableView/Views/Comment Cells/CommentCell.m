//
//  CommentCell.m
//  TableView
//
//  Created by sbxfc on 16/7/22.
//  Copyright © 2016年 me.rungame.sbxfc. All rights reserved.
//

#import "CommentCell.h"
#import "Comment.h"

@interface CommentCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation CommentCell

- (void)setComment:(Comment *)data
{
    _comment = data;
    
    self.titleLabel.text = data.name;
    self.subtitleLabel.text = [NSString stringWithFormat:@"%@  %@",data.addr,data.time];
    self.contentLabel.text = data.content;
}

// If you are not using auto layout, override this method, enable it by setting
// "enforceFrameLayout" to YES.
- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat totalHeight = 121; //图片高度
    totalHeight += [self.contentLabel sizeThatFits:size].height;
    return CGSizeMake(size.width, totalHeight);
}


@end
