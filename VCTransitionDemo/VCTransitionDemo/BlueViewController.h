//
//  BlueViewController.h
//  VCTransitionDemo
//
//  Created by sbx_fc on 15/6/12.
//  Copyright (c) 2015年 SF. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BlueViewController;
@protocol BlueViewControllerDelegate <NSObject>
-(void) blueViewControllerDidClickedDismissButton:(BlueViewController *)viewController;
@end

@interface BlueViewController : UIViewController
@property (nonatomic, weak) id<BlueViewControllerDelegate> delegate;
@end
