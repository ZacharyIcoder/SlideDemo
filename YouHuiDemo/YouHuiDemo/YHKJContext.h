//
//  YHKJContext.h
//  YouHuiDemo
//
//  Created by ZIKong on 2017/6/6.
//  Copyright © 2017年 youhuikeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface YHKJContext : NSObject
@property (strong, nonatomic) UINavigationController *rootViewController;
+ (YHKJContext *)sharedInstance;
@end
