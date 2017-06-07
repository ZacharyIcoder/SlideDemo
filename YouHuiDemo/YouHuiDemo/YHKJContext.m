//
//  YHKJContext.m
//  YouHuiDemo
//
//  Created by ZIKong on 2017/6/6.
//  Copyright © 2017年 youhuikeji. All rights reserved.
//

#import "YHKJContext.h"

@implementation YHKJContext

static YHKJContext *_sharedInstance;

+ (YHKJContext *)sharedInstance;
{
    @synchronized(self)
    {
        if (!_sharedInstance)
            _sharedInstance = [[YHKJContext alloc] init];
        return _sharedInstance;
    }
}

@end
