//
//  LeftBaseViewController.m
//  YouHuiDemo
//
//  Created by ZIKong on 2017/6/6.
//  Copyright © 2017年 youhuikeji. All rights reserved.
//

#import "LeftBaseViewController.h"
#import "GPFsliderViewController.h"
@interface LeftBaseViewController ()
{
    UINavigationItem *myNavItem;
}
@end

@implementation LeftBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =  [UIColor whiteColor];
    [self setupNavUI];
    
    [GPFsliderViewController sharedSliderController].panGestureRec.enabled = NO;
    [GPFsliderViewController sharedSliderController].tapGestureRec.enabled = NO;
    [GPFsliderViewController sharedSliderController].canShowLeft = NO;
    [GPFsliderViewController sharedSliderController].canShowRight= NO;

}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [GPFsliderViewController sharedSliderController].canShowLeft = YES;

}

- (void)setupNavUI {
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:17/255. green:183/255. blue:243/255. alpha:1];
//    
//    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftButton.frame = CGRectMake(0, 0, 19, 20);
//    leftButton.tag = 101;
//    [leftButton setBackgroundImage:[UIImage imageNamed:@"gobackBtn"] forState:UIControlStateNormal];
//    [leftButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    UINavigationBar *myNav = [[UINavigationBar alloc] init];
    myNav.frame = CGRectMake(0, 0, self.view.frame.size.width, 64);
//    myNav.barTintColor = [UIColor cyanColor];
    myNav.translucent = YES;
    myNav.barTintColor = [UIColor colorWithRed:17/255. green:183/255. blue:243/255. alpha:1];
    myNavItem = [[UINavigationItem alloc] init];
    myNavItem.title = @"测试";
    myNav.items = @[myNavItem];
    [self.view addSubview:myNav];

    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 19, 20);
    leftButton.tag = 101;
    [leftButton setBackgroundImage:[UIImage imageNamed:@"gobackBtn"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    myNavItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];

}

-(void)setNavTitle:(NSString *)navTitle {
    _navTitle = navTitle;
    myNavItem.title = navTitle;
}

- (void)buttonClickAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
