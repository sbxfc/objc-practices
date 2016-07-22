//
//  CommentCell.h
//  TableView
//
//  Created by sbxfc on 16/7/22.
//  Copyright © 2016年 me.rungame.sbxfc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Comment;

@interface CommentCell : UITableViewCell
@property (nonatomic, strong) Comment *comment;
@end
