//
//  ViewController.m
//  GifView
//
//  Created by sbxfc on 16/7/25.
//  Copyright © 2016年 me.rungame.sbxfc. All rights reserved.
//

#import "ViewController.h"
#import "GifView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURL *gifURL = [[NSBundle mainBundle] URLForResource:@"1" withExtension:@"gif"];
    GifView* gif = [[GifView alloc] initWithGif:gifURL];
    [gif setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
    [gif play];
    [self.view addSubview:gif];
}


@end
