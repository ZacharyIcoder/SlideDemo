//
//  XZView.h
//  YouHuiDemo
//
//  Created by ZIKong on 2017/6/5.
//  Copyright © 2017年 youhuikeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZView : UIImageView
{
    int type;
}
- (id)initWithType:(CGRect)frame type:(int)type;

@end
