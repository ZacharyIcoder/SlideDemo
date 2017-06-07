//
//  GPFsliderViewController.h
//  YouHuiDemo
//
//  Created by ZIKong on 2017/6/5.
//  Copyright © 2017年 youhuikeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GPFsliderViewController : UIViewController
@property(nonatomic,strong)UIViewController *LeftVC;
@property(nonatomic,strong)UIViewController *RightVC;
@property(nonatomic,strong)UIViewController *MainVC;

@property(nonatomic,strong)NSMutableDictionary *controllersDict;
@property(nonatomic,strong)UIPanGestureRecognizer *panGestureRec;
@property(nonatomic,strong)UITapGestureRecognizer *tapGestureRec;

@property(nonatomic,assign)float LeftSContentOffset;
@property(nonatomic,assign)float LeftContentViewSContentOffset;
@property(nonatomic,assign)float RightSContentOffset;
@property(nonatomic,assign)float RightContentViewSContentOffset;
@property(nonatomic,assign)float LeftSContentScale;
@property(nonatomic,assign)float RightSContentScale;

@property(nonatomic,assign)float LeftSJudgeOffset;
@property(nonatomic,assign)float RightSJudgeOffset;

@property(nonatomic,assign)float LeftSOpenDuration;
@property(nonatomic,assign)float RightSOpenDuration;

@property(nonatomic,assign)float LeftSCloseDuration;
@property(nonatomic,assign)float RightSCloseDuration;

@property(nonatomic,assign)BOOL canShowLeft;
@property(nonatomic,assign)BOOL canShowRight;

@property (nonatomic, copy) void(^changeLeftView)(CGFloat sca, CGFloat transX);
@property (nonatomic,copy) void(^changeRightView)(CGFloat sca, CGFloat transX);


@property (nonatomic ,assign)BOOL slider;

@property (nonatomic, assign, getter = isSpringAnimationOn) BOOL springAnimationOn;
@property (nonatomic, readonly) UIScrollView *scrollView;



+ (GPFsliderViewController *)sharedSliderController;


/**
 设置右侧视图
 */
- (void)setupRightViewController;

- (void)downTouch;

- (void)showContentControllerWithModel:(NSString*)className;
- (void)showLeftViewController;
- (void)showRightViewController;

- (void)moveViewWithGesture:(UIPanGestureRecognizer *)panGes;
- (void)moveViewTouch:(int)x state:(int)flag type:(int)type;
- (void)closeSideBar;
- (void)closeSideBarWithAnimate:(BOOL)bAnimate complete:(void(^)(BOOL finished))complete;

@end

@interface UIViewController (GPFsliderViewController)

@property (nonatomic, readonly) GPFsliderViewController *gpf_SliderController;
@end
