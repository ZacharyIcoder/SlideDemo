//
//  YHKJTabBarViewController.m
//  YouHuiDemo
//
//  Created by ZIKong on 2017/6/6.
//  Copyright © 2017年 youhuikeji. All rights reserved.
//

#import "YHKJTabBarViewController.h"
#import "FirstTabViewController.h"
#import "SecondTabViewController.h"

@interface YHKJTabBarViewController ()

@end

@implementation YHKJTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //first
    FirstTabViewController *orderVC = [[FirstTabViewController alloc] init];
    UINavigationController *orderNav = [[UINavigationController alloc] initWithRootViewController:orderVC];
    orderNav.viewControllers = @[orderVC];
    orderNav.tabBarItem.enabled = YES;
    orderVC.title = @"First";
    orderVC.tabBarItem.title = @"First";
    //    orderVC.navigationController.navigationBar.hidden = YES;
    orderVC.tabBarItem.image = [[UIImage imageNamed:@"底部菜单-苗企求购off"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    orderVC.tabBarItem.selectedImage =[[UIImage imageNamed:@"底部菜单-苗企求购on"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //second
    SecondTabViewController *buyVC = [[SecondTabViewController alloc] init];
    UINavigationController *buyNav = [[UINavigationController alloc] initWithRootViewController:buyVC];
    //    buyVC.navigationController.navigationBar.hidden = YES;
    buyNav.viewControllers = @[buyVC];
    buyNav.tabBarItem.enabled = YES;
    buyVC.title = @"Second";
    buyVC.tabBarItem.title = @"Second";
    //    buyVC.navigationController.navigationBar.hidden = YES;
    buyVC.tabBarItem.image = [[UIImage imageNamed:@"底部菜单-苗企供应off"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    buyVC.tabBarItem.selectedImage =[[UIImage imageNamed:@"底部菜单-苗企供应on"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableArray *list = [[NSMutableArray alloc] initWithObjects:orderNav,buyNav,nil];
    self.viewControllers = list;
//    self.delegate = self;
    UIColor *normalColor = [UIColor colorWithRed:88/255.0 green:88/255.0 blue:88/255.0 alpha:1];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       normalColor,           NSForegroundColorAttributeName,
                                                       [UIFont fontWithName:@"Helvetica" size:12.0], NSFontAttributeName,
                                                       nil] forState:UIControlStateNormal];
    UIColor *titleHighlightedColor =  [UIColor colorWithRed:107/255.0f green:188/255.0f blue:85/255.0f alpha:1.0f];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, NSForegroundColorAttributeName,
                                                       [UIFont fontWithName:@"Helvetica" size:12.0], NSFontAttributeName,
                                                       nil] forState:UIControlStateSelected];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
