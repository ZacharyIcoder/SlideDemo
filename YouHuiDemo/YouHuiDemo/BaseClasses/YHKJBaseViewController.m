//
//  YHKJBaseViewController.m
//  YouHuiDemo
//
//  Created by ZIKong on 2017/6/6.
//  Copyright © 2017年 youhuikeji. All rights reserved.
//

#import "YHKJBaseViewController.h"
#import "GPFsliderViewController.h"

@interface YHKJBaseViewController ()

@end

@implementation YHKJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavUI];
}

- (void)setupNavUI {
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:17/255. green:183/255. blue:243/255. alpha:1];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 19, 20);
    leftButton.tag = 101;
    [leftButton setBackgroundImage:[UIImage imageNamed:@"左侧图标"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];

}

- (void)buttonClickAction:(UIButton *)sender
{
    [GPFsliderViewController sharedSliderController].panGestureRec.enabled = YES;
    [GPFsliderViewController sharedSliderController].tapGestureRec.enabled = YES;
    long index = sender.tag-100;
    NSLog(@"button.tag=%ld",index);
    switch (index) {
        case 1:
            [[GPFsliderViewController sharedSliderController] showLeftViewController];
            break;
        case 2:
            [[GPFsliderViewController sharedSliderController] showRightViewController];
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
