//
//  MainViewController.m
//  VCTransitionDemo
//
//  Created by sbx_fc on 15/6/12.
//  Copyright (c) 2015年 SF. All rights reserved.
//

#import "MainViewController.h"
#import "BlueViewController.h"
#import "VCPopAnimation.h"
#import "VCPushAnimation.h"
#import "SwipeUpInteractiveTransition.h"

@interface MainViewController ()<BlueViewControllerDelegate,UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) VCPushAnimation *presentAnimation;
@property (nonatomic, strong) VCPopAnimation *dismissAnimation;
@property (nonatomic, strong) SwipeUpInteractiveTransition *transitionController;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _presentAnimation = [VCPushAnimation new];
        _dismissAnimation = [VCPopAnimation new];
        _transitionController = [SwipeUpInteractiveTransition new];


    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [button setTitle:@"Click me" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void) buttonClicked:(id)sender
{
    BlueViewController *mvc =  [[BlueViewController alloc] init];
    mvc.transitioningDelegate = self;
    mvc.delegate = self;
    [self.transitionController wireToViewController:mvc];
    [self presentViewController:mvc animated:YES completion:nil];
}

-(void)blueViewControllerDidClickedDismissButton:(BlueViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self.presentAnimation;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.dismissAnimation;
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.transitionController.interacting ? self.transitionController : nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
