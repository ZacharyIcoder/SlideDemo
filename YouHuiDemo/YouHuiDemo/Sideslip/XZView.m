//
//  XZView.m
//  YouHuiDemo
//
//  Created by ZIKong on 2017/6/5.
//  Copyright © 2017年 youhuikeji. All rights reserved.
//

#define DebugLog( s, ... ) printf( "<%s:(%d)> %s %s\n\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] cStringUsingEncoding:NSUTF8StringEncoding], __LINE__,__func__, [[NSString stringWithFormat:(s), ##__VA_ARGS__] cStringUsingEncoding:NSUTF8StringEncoding])

#import "XZView.h"
#import "GPFsliderViewController.h"

@implementation XZView

- (id)initWithType:(CGRect)frame type:(int)typeObj;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        type = typeObj;
        //        [self addTarget:self action:@selector(goAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)goAction
{
    if (type==1) {
        [[GPFsliderViewController sharedSliderController] showLeftViewController];
         }else{
        [[GPFsliderViewController sharedSliderController]showRightViewController];
      }
}
static int x = 0;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    DebugLog(@"touchesBegan");
    x = 0;
    [GPFsliderViewController sharedSliderController].panGestureRec.enabled = YES;
    //    DebugLog(@"xxxxxxxxxxx0 %d",x);
    if (type==1) {
//        [self setImage:[UIImage imageNamed:@"左侧浮动"]];
        [self setImage:[UIImage imageNamed:@""]];

        if (x<0) {
            return;
        }
        [[GPFsliderViewController sharedSliderController] moveViewTouch:x state:0 type:type];
    }else{
//        [self setImage:[UIImage imageNamed:@"右侧浮动"]];
        [self setImage:[UIImage imageNamed:@""]];

        if (x>0) {
            return;
        }
        [[GPFsliderViewController sharedSliderController] moveViewTouch:x state:0 type:type];
    }
    // 这里可以做子view自己想做的事，做完后，事件继续上传，就可以让其父类，甚至父viewcontroller获取到这个事件了
    //    [[self nextResponder]touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    DebugLog(@"touchesMoved");
    for(UITouch *touch in event.allTouches) {
        CGPoint location = [ touch locationInView: self ];
        CGPoint oldLocation = [ touch previousLocationInView: self ];
        x += (location.x - oldLocation.x);
        //        DebugLog(@"xxxxxxxxxxx1 %d",x);
        if (x==0) {
            return;
        }
        if (type==1) {
            if (x<0) {
                return;
            }
            [[GPFsliderViewController sharedSliderController] moveViewTouch:x state:1 type:type];
        }else{
            if (x>0) {
                return;
            }
            [[GPFsliderViewController sharedSliderController] moveViewTouch:x state:1 type:type];
        }
    }
    //    [[self nextResponder] touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setImage:nil];
    
    DebugLog(@"touchesEnded");
//    [GPFsliderViewController sharedSliderController].panGestureRec.enabled = YES;
//    [GPFsliderViewController sharedSliderController].tapGestureRec.enabled = YES;

    for(UITouch *touch in event.allTouches) {
        CGPoint location = [ touch locationInView: self ];
        CGPoint oldLocation = [ touch previousLocationInView: self ];
        x += (location.x - oldLocation.x);
        DebugLog(@"xxxxxxxxxxx2 %d",x);
        
        if (x==0) {
            return;
        }
        if (type==1) {
            //            if (x<0) {
            //                return;
            //            }
            [[GPFsliderViewController sharedSliderController] moveViewTouch:x state:2 type:type];
        }else{
            //            if (x>0) {
            //                return;
            //            }
            [[GPFsliderViewController sharedSliderController] moveViewTouch:x-320 state:2 type:type];
        }
        
    }
    //    [[self nextResponder]touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
}


@end
