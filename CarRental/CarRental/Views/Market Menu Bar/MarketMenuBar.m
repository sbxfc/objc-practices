//
//  MarketMenuBar.m
//  CarRental
//
//  Created by sbxfc on 16/7/29.
//  Copyright © 2016年 me.rungame.sbxfc. All rights reserved.
//

#import "MarketMenuBar.h"

#define MARKET_MENU_BAR_HORIZONTAL_GAP 5.0
#define MARKET_MENU_BAR_ARROW_WIDTH 40.0
#define MARKET_MENU_BAR_LEFT 10.0
#define MARKET_MENU_BAR_TOP 10.0

@interface MarketMenuBar()
@property (nonatomic) CGFloat menuType;
@end

@implementation MarketMenuBar

- (instancetype)initWithFrame:(CGRect)frame dictionary:(NSDictionary*)dict andType:(NSInteger)type{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.menuType = type;
        CGFloat x = MARKET_MENU_BAR_LEFT;
        CGFloat y = MARKET_MENU_BAR_TOP;
        
        //箭头标识
        UIImage* img = [UIImage imageNamed:@"img_arrow_right"];
        UIImageView* imageView = [[UIImageView alloc] initWithImage:img];
        [imageView setFrame:CGRectMake(x, y, img.size.width, img.size.height)];
        [self addSubview:imageView];
        x += (img.size.width + MARKET_MENU_BAR_HORIZONTAL_GAP);
        
        //文字
        NSString* text = @"区域";
        UIFont* font = [UIFont boldSystemFontOfSize:16];
        CGSize textSize = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
        CGFloat width = textSize.width + 5;
        CGFloat height = textSize.height + 5;
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        label.text = text;
        label.textAlignment = NSTextAlignmentLeft;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.font = [UIFont boldSystemFontOfSize:16];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        [self addSubview:label];
        x += (textSize.width + MARKET_MENU_BAR_HORIZONTAL_GAP);

        //按钮列表
        for (NSNumber *key in [dict keyEnumerator]) {
            NSString* title = dict[key];
            NSInteger tag = key.integerValue;
            if(x < self.frame.size.width){
                UIButton* button = [self createButton:title withTag:tag];
                UIFont* textFont = button.titleLabel.font;
                CGSize textSize = [title sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:textFont,NSFontAttributeName, nil]];
                CGFloat width = textSize.width + 5;
                CGFloat height = textSize.height + 5;
                [button setFrame:CGRectMake(x, y, width, height)];
                x += (MARKET_MENU_BAR_HORIZONTAL_GAP + width);
                [self addSubview:button];
            }
        }
    }
    return self;
}

-(UIButton*)createButton:(NSString*)title withTag:(NSInteger)tag{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTag:tag];
    [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside ];
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

-(void)action:(id)sender
{
    UIButton* button = sender;
    [self.delegate marketMenuBarTouched:self.menuType withTag:[button tag]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
