//
//  GPFLeftViewController.m
//  YouHuiDemo
//
//  Created by ZIKong on 2017/6/6.
//  Copyright © 2017年 youhuikeji. All rights reserved.
//

#import "GPFLeftViewController.h"
#import "FirstLeftViewController.h"
#import "SecondLeftViewController.h"
#import "ThirdLeftViewController.h"
#import "GPFsliderViewController.h"

@interface GPFLeftViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation GPFLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-100, self.view.frame.size.height)];
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];

//    imageview.image = [UIImage imageNamed:@"leftbackiamge"];
    imageview.image = [UIImage imageNamed:@"leftSkid"];

    [self.view addSubview:imageview];
//    imageview.backgroundColor = [UIColor yellowColor];
    
    UITableView *tableview    = [[UITableView alloc] init];
    self.tableView            = tableview;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.frame           = CGRectMake(0, 0, self.view.frame.size.width-50, self.view.frame.size.height);
    tableview.dataSource      = self;
    tableview.delegate        = self;
    tableview.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType       = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font      = [UIFont systemFontOfSize:20.0f];
    cell.backgroundColor     = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"开通会员";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"QQ钱包";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"网上营业厅";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"个性装扮";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"我的收藏";
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"我的相册";
    } else if (indexPath.row == 6) {
        cell.textLabel.text = @"我的文件";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [[GPFsliderViewController sharedSliderController] closeSideBar];

    if (indexPath.row == 0) {
//        FirstLeftViewController *firstLeftVC = [[FirstLeftViewController alloc] init];
        NSLog(@"%@",(UINavigationController *)[GPFsliderViewController sharedSliderController].MainVC);

          [((UINavigationController *)[GPFsliderViewController sharedSliderController].MainVC ) pushViewController:[[FirstLeftViewController alloc] init] animated:YES];
//            [((UINavigationController*)[GPFsliderViewController sharedSliderController].MainVC) setViewControllers:[NSArray arrayWithObject:[[NSClassFromString(@"FirstLeftViewController") alloc] init]]];
//                    FirstLeftViewController *testVc = [[FirstLeftViewController alloc] init];
//                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:testVc];
//                    [(UINavigationController *)[GPFsliderViewController sharedSliderController].MainVC pushViewController:nav animated:YES];

    }
    else if (indexPath.row == 1) {
         [((UINavigationController *)[GPFsliderViewController sharedSliderController].MainVC ) pushViewController:[[SecondLeftViewController alloc] init] animated:YES];
    }
    else if (indexPath.row == 2) {
         [((UINavigationController *)[GPFsliderViewController sharedSliderController].MainVC ) pushViewController:[[ThirdLeftViewController alloc] init] animated:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 180;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 180)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
