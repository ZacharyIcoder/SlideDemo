//
//  YHKJLoginViewController.m
//  YouHuiDemo
//
//  Created by ZIKong on 2017/6/6.
//  Copyright © 2017年 youhuikeji. All rights reserved.
//

#import "YHKJLoginViewController.h"
#import "GPFLeftViewController.h"
#import "GPFsliderViewController.h"
#import "AppDelegate.h"
@interface YHKJLoginViewController ()

@end

@implementation YHKJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"login";
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(100, 120, 60, 40);
    [button setTitle:@"login" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClick ) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClick {
    [GPFsliderViewController sharedSliderController].LeftVC.view.hidden = YES;
    [self.navigationController popViewControllerAnimated:NO];
    
    __block YHKJLoginViewController *weakSelf = self;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [weakSelf setTabbar];
    });
}

-(void)setTabbar
{
    UINavigationController *nav = (UINavigationController *)[GPFsliderViewController sharedSliderController].MainVC;
    nav.navigationBarHidden  = YES;
    nav.navigationBar.hidden = YES;
    [nav setViewControllers:[NSArray arrayWithObject:[[NSClassFromString(@"YHKJTabBarViewController") alloc] init]] animated:NO];
    
    [GPFsliderViewController sharedSliderController].LeftVC.view.hidden = NO;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
