//
//  FirstLeftViewController.m
//  YouHuiDemo
//
//  Created by ZIKong on 2017/6/6.
//  Copyright © 2017年 youhuikeji. All rights reserved.
//

#import "FirstLeftViewController.h"
#import "GPFsliderViewController.h"
@interface FirstLeftViewController ()

@end

@implementation FirstLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navTitle = @"firstLeft";
//    self.view.backgroundColor = [UIColor greenColor];
    
    //[self setupNavUI];
    
    [GPFsliderViewController sharedSliderController].panGestureRec.enabled = NO;
    [GPFsliderViewController sharedSliderController].tapGestureRec.enabled = NO;
    
}

//- (void)setupNavUI {
////    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:17/255. green:183/255. blue:243/255. alpha:1];
//    
//    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftButton.frame = CGRectMake(100, 200, 19, 20);
//    leftButton.tag = 101;
//    [leftButton setBackgroundImage:[UIImage imageNamed:@"gobackBtn"] forState:UIControlStateNormal];
//    [leftButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:leftButton];
////    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
//}

- (void)buttonClickAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
