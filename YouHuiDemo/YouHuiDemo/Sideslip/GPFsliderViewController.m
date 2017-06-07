//
//  GPFsliderViewController.m
//  YouHuiDemo
//
//  Created by ZIKong on 2017/6/5.
//  Copyright © 2017年 youhuikeji. All rights reserved.
//

#define BOUNDS [[UIScreen mainScreen] bounds]

#import "GPFsliderViewController.h"
#import <sys/utsname.h>
#import <objc/runtime.h>
#import "XZView.h"

typedef NS_ENUM(NSInteger, RMoveDirection) {
    RMoveDirectionLeft = 0,
    RMoveDirectionRight
};


@interface GPFsliderViewController ()<UIGestureRecognizerDelegate>{
    UIView *_mainContentView;
    UIView *_leftSideView;
    UIView *_rightSideView;
    
    NSMutableDictionary *_controllersDict;
    
    UITapGestureRecognizer *tapGestureRec;
    UIPanGestureRecognizer *panGestureRec;
    
    BOOL showingLeft;
    BOOL showingRight;
    
    XZView *leftButton;
//    XZView *rightButton;
}


@end

@implementation GPFsliderViewController
@synthesize panGestureRec;
@synthesize tapGestureRec;
-(void)dealloc{
#if __has_feature(objc_arc)
    _mainContentView = nil;
    _leftSideView = nil;
    _rightSideView = nil;
    
    _controllersDict = nil;
    
    self.tapGestureRec = nil;
    self.panGestureRec = nil;
    
    _LeftVC = nil;
    _RightVC = nil;
    _MainVC = nil;
#else
    [_mainContentView release];
    [_leftSideView release];
    [_rightSideView release];
    
    [_controllersDict release];
    
    [self.tapGestureRec release];
    [self.panGestureRec release];
    
    [_LeftVC release];
    [_RightVC release];
    [_MainVC release];
    [super dealloc];
#endif
    
}

+ (GPFsliderViewController *)sharedSliderController{
    
    static GPFsliderViewController *sharedSVC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSVC = [[self alloc] init];
    });
    
    return sharedSVC;
    
}
- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super initWithCoder:decoder])) {
        _LeftSContentOffset=160;
        _RightSContentOffset=160;
        _LeftSContentScale=0.85;
        _RightSContentScale=0.85;
        _LeftSJudgeOffset=0;
        _RightSJudgeOffset=0;
        _LeftSOpenDuration=0.4;
        _RightSOpenDuration=0.4;
        _LeftSCloseDuration=0.3;
        _RightSCloseDuration=0.3;
        _canShowLeft=YES;
        _canShowRight=YES;
    }
    return self;
}

- (id)init{
    if (self = [super init]){
        _LeftSContentOffset=160;
        _RightSContentOffset=160;
        _LeftSContentScale=0.85;
        _RightSContentScale=0.85;
        _LeftSJudgeOffset=100;
        _RightSJudgeOffset=100;
        _LeftSOpenDuration=0.4;
        _RightSOpenDuration=0.4;
        _LeftSCloseDuration=0.3;
        _RightSCloseDuration=0.3;
        _canShowLeft=YES;
        _canShowRight=YES;
        
        //self.view.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.userInteractionEnabled = YES;
    _slider =  self.view.userInteractionEnabled;
    self.view.backgroundColor = [UIColor whiteColor];
//    self.view.backgroundColor = [UIColor yellowColor];
    
    _controllersDict = [[NSMutableDictionary alloc] init];
    
    [self initSubviews];
    
    [self initChildControllers:_LeftVC rightVC:_RightVC];
    
    [self showContentControllerWithModel:_MainVC!=nil?NSStringFromClass([_MainVC class]):@"ViewController"];
    
    self.tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSideBar)];
    self.tapGestureRec.delegate=self;
    [_mainContentView addGestureRecognizer:self.tapGestureRec];
    self.tapGestureRec.enabled = NO;
    
    self.panGestureRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGesture:)];
    [_mainContentView addGestureRecognizer:self.panGestureRec];
    self.panGestureRec.enabled = NO;
}

#pragma mark - Init

- (void)initSubviews
{
    _rightSideView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_rightSideView];
    
    _leftSideView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_leftSideView];
    
    _mainContentView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_mainContentView];
    
}

- (void)initChildControllers:(UIViewController*)leftVC rightVC:(UIViewController*)rightVC
{
    if (_canShowRight&&rightVC!=nil) {
        [self addChildViewController:rightVC];
        rightVC.view.frame=CGRectMake(0, 0, rightVC.view.frame.size.width, rightVC.view.frame.size.height);
        [_rightSideView addSubview:rightVC.view];
    }
    if (_canShowLeft&&leftVC!=nil) {
        [self addChildViewController:leftVC];
        leftVC.view.frame=CGRectMake(0, 0, leftVC.view.frame.size.width, leftVC.view.frame.size.height);
        [_leftSideView addSubview:leftVC.view];
    }
}

- (void)setupRightViewController {
    UIViewController *rightVc = [[UIViewController alloc] init];

    [GPFsliderViewController sharedSliderController].RightVC = rightVc;
    [GPFsliderViewController sharedSliderController].RightSContentOffset=275;
    [GPFsliderViewController sharedSliderController].RightContentViewSContentOffset = -90;
    [GPFsliderViewController sharedSliderController].RightSContentScale=0.77;
    
    [GPFsliderViewController sharedSliderController].RightSJudgeOffset=160;
    [GPFsliderViewController sharedSliderController].changeRightView = ^(CGFloat sca, CGFloat transX)
    {
        CGAffineTransform ltransS = CGAffineTransformMakeScale(sca, sca);
        CGAffineTransform ltransT = CGAffineTransformMakeTranslation(transX, 0);
        CGAffineTransform lconT = CGAffineTransformConcat(ltransT, ltransS);
        rightVc.view.transform = lconT;
    };
    
    [GPFsliderViewController sharedSliderController].canShowRight = NO;


}

#pragma mark - Actions

- (void)showContentControllerWithModel:(NSString *)className
{
    //恢复主视图状态
    [self closeSideBar];
    
    UIViewController *controller = _controllersDict[className];
    
    if (!controller)
    {
        Class c = NSClassFromString(className);
        
#if __has_feature(objc_arc)
        controller = [[c alloc] init];
#else
        controller = [[[c alloc] init] autorelease];
#endif
        [_controllersDict setObject:controller forKey:className];
        
    }
    
    if (_mainContentView.subviews.count > 0)
    {
        UIView *view = [_mainContentView.subviews firstObject];
        [view removeFromSuperview];
    }
    
    controller.view.frame = _mainContentView.frame;
    [_mainContentView addSubview:controller.view];
    
//    controller.view.backgroundColor= [UIColor redColor];
    
    self.MainVC=controller;
    
    leftButton = [[XZView alloc]initWithType:CGRectMake(0, (BOUNDS.size.height)/2-100, 15, 200) type:1];
    //    leftButton.backgroundColor = [UIColor blueColor];
    leftButton.userInteractionEnabled = YES;
    [self.MainVC.view addSubview:leftButton];
    
    
//    rightButton = [[XZView alloc]initWithType:CGRectMake(320-15, (BOUNDS.size.height)/2-100, 15, 200) type:2];
//    //    rightButton.backgroundColor = [UIColor blueColor];
//    rightButton.userInteractionEnabled = YES;
//    [self.MainVC.view addSubview:rightButton];
}

- (void)showLeftViewController
{
    if (showingLeft) {
        //恢复主视图状态
        [self closeSideBar];
        return;
    }
    if (!_canShowLeft||_LeftVC==nil) {
        return;
    }
    CGAffineTransform conT = [self transformWithDirection:RMoveDirectionRight];
    
    [self.view sendSubviewToBack:_rightSideView];
    //配置阴影
    [self configureViewShadowWithDirection:RMoveDirectionRight];
    [UIView animateWithDuration:_LeftSOpenDuration
                     animations:^{
                         _mainContentView.transform = conT;
                         self.changeLeftView(1, 0);
                     }
                     completion:^(BOOL finished) {
                         self.tapGestureRec.enabled = YES;
                         showingLeft=YES;
                         _MainVC.view.userInteractionEnabled=YES;
                     }];
}

- (void)showRightViewController
{
    if (showingRight) {
        //恢复主视图状态
        [self closeSideBar];
        return;
    }
    if (!_canShowRight||_RightVC==nil) {
        return;
    }
    CGAffineTransform conT = [self transformWithDirection:RMoveDirectionLeft];
    
    [self.view sendSubviewToBack:_leftSideView];
    //配置阴影
    [self configureViewShadowWithDirection:RMoveDirectionLeft];
    
    [UIView animateWithDuration:_RightSOpenDuration
                     animations:^{
                         self.changeRightView(1, 0);
                         _mainContentView.transform = conT;
                     }
                     completion:^(BOOL finished) {
                         self.tapGestureRec.enabled = YES;
                         showingRight=YES;
                         _MainVC.view.userInteractionEnabled=YES;
                     }];
}
//恢复主视图状态
- (void)closeSideBar
{
    //恢复主视图状态
    [self closeSideBarWithAnimate:YES complete:^(BOOL finished) {}];
    
}
//恢复主视图状态
- (void)closeSideBarWithAnimate:(BOOL)bAnimate complete:(void(^)(BOOL finished))complete
{
    CGAffineTransform oriT = CGAffineTransformIdentity;
    if (bAnimate)
    {
        [UIView animateWithDuration:_mainContentView.transform.tx==_LeftSContentOffset?_LeftSCloseDuration:_RightSCloseDuration
                         animations:^{
                             [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:nil];
                             
                             _mainContentView.transform = oriT;
                         }
                         completion:^(BOOL finished) {
                             //[[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:nil];
                             self.changeRightView(0, 0);
                             self.changeLeftView (0, 0);
                             self.tapGestureRec.enabled = NO;
                             showingRight=NO;
                             showingLeft=NO;
                             _MainVC.view.userInteractionEnabled=YES;
                             complete(finished);
                         }];
    }else
    {
        _mainContentView.transform = oriT;
        self.tapGestureRec.enabled = NO;
        showingRight=NO;
        showingLeft=NO;
        _MainVC.view.userInteractionEnabled=YES;
        complete(YES);
    }
}


-(void)moveViewTouch:(int)x state:(int)flag type:(int)type;
{
    //    CGPoint ppoint = [panGes locationInView:self.view];
    //
    //    DebugLog(@"point.x===%f,point.y==%f",ppoint.x,ppoint.y);
    static CGFloat currentTranslateX;
    if (flag == 0)
    {
        currentTranslateX = _mainContentView.transform.tx;
    }
    if (flag == 1)
    {
        CGFloat transX = x;
        transX = transX + currentTranslateX;
        CGFloat sca=0;
        CGFloat ltransX = (transX - _LeftSContentOffset)/_LeftSContentOffset * _LeftContentViewSContentOffset;//左滑偏移量
        CGFloat rtransX = (transX + _RightSContentOffset)/_RightSContentOffset * _LeftContentViewSContentOffset;//右滑偏移量
        CGFloat lsca = 1;
        if (transX > 0)
        {
            if (!_canShowLeft||_LeftVC==nil) {
                return;
            }
            
            [self.view sendSubviewToBack:_rightSideView];
            _rightSideView.hidden = NO;// = YES;
            [self configureViewShadowWithDirection:RMoveDirectionRight];
            
            if (_mainContentView.frame.origin.x < _LeftSContentOffset)
            {
                sca = 1 - (_mainContentView.frame.origin.x/_LeftSContentOffset) * (1-_LeftSContentScale);
                lsca = 1 - sca + _LeftSContentScale;
            }
            else
            {
                sca = _LeftSContentScale;
            }
            self.changeLeftView(lsca, ltransX);
        }
        else    //transX < 0
        {
            if (!_canShowRight||_RightVC==nil) {
                return;
            }
            [self.view sendSubviewToBack:_leftSideView];
            _leftSideView.hidden = NO;// = YES;
            [self configureViewShadowWithDirection:RMoveDirectionLeft];
            
            if (_mainContentView.frame.origin.x > -_RightSContentOffset)
            {
                sca = 1 - (-_mainContentView.frame.origin.x/_RightSContentOffset) * (1-_RightSContentScale);
                lsca = 1 - sca + _RightSContentScale;
            }
            else
            {
                sca = _RightSContentScale;
            }
            self.changeRightView(lsca, rtransX);
        }
        CGAffineTransform transS = CGAffineTransformMakeScale(sca, sca);
        CGAffineTransform transT = CGAffineTransformMakeTranslation(transX, 0);
        CGAffineTransform conT = CGAffineTransformConcat(transT, transS);
        
        _mainContentView.transform = conT;
    }
    else if (flag == 2)
    {
        CGFloat panX = x;
        CGFloat finalX = currentTranslateX + panX;
        if (finalX > _LeftSJudgeOffset)
        {
            if (!_canShowLeft||_LeftVC==nil) {
                return;
            }
            
            CGAffineTransform conT = [self transformWithDirection:RMoveDirectionRight];
            [UIView beginAnimations:nil context:nil];
            _mainContentView.transform = conT;
            [UIView commitAnimations];
            
            showingLeft=YES;
            _MainVC.view.userInteractionEnabled=NO;
            
            self.tapGestureRec.enabled = YES;
            
            [self showLeft:YES];
            
            return;
        }
        if (finalX < -_RightSJudgeOffset)
        {
            
            if (!_canShowRight || _RightVC==nil) {
                return;
            }
            [self showRightViewController];
            //            CGAffineTransform conT = [self transformWithDirection:RMoveDirectionLeft];
            //            [UIView beginAnimations:nil context:nil];
            //            _mainContentView.transform = conT;
            //            [UIView commitAnimations];
            //
            //            showingRight=YES;
            //
            //            _MainVC.view.userInteractionEnabled=NO;
            //
            //            self.tapGestureRec.enabled = YES;
            //
            //            [self showRight:YES];
            
            return;
        }
        else
        {
            CGAffineTransform oriT = CGAffineTransformIdentity;
            [UIView beginAnimations:nil context:nil];
            _mainContentView.transform = oriT;
            [UIView commitAnimations];
            _leftSideView.hidden = NO;// = NO;
            _rightSideView.hidden = NO;// = NO;
            [self showLeft:NO];
            [self showRight:NO];
            showingRight=NO;
            showingLeft=NO;
            _MainVC.view.userInteractionEnabled=YES;
            self.tapGestureRec.enabled = NO;
            self.panGestureRec.enabled = NO;
        }
    }
    
}

- (void)moveViewWithGesture:(UIPanGestureRecognizer *)panGes
{
    
    //   CGPoint ppoint = [panGes locationInView:self.view];
    
    //    DebugLog(@"point.x===%f,point.y==%f,height%f",ppoint.x,ppoint.y,self.view.frame.size.height);
    static CGFloat currentTranslateX;
    if (panGes.state == UIGestureRecognizerStateBegan)
    {
        currentTranslateX = _mainContentView.transform.tx;
    }
    if (panGes.state == UIGestureRecognizerStateChanged)
    {
        CGFloat transX = [panGes translationInView:_mainContentView].x;
        transX = transX + currentTranslateX;
        CGFloat sca=0;
        CGFloat ltransX = (transX - _LeftSContentOffset)/_LeftSContentOffset * _LeftContentViewSContentOffset;//左滑偏移量
        CGFloat rtransX = (transX + _RightSContentOffset)/_RightSContentOffset * _LeftContentViewSContentOffset;//右滑偏移量
        CGFloat lsca = 1;
        if (transX > 0)
        {
            if (!_canShowLeft||_LeftVC==nil) {
                return;
            }
            [self.view sendSubviewToBack:_rightSideView];
            _rightSideView.hidden = NO;// = YES;
            //配置阴影
            [self configureViewShadowWithDirection:RMoveDirectionRight];
            if (_mainContentView.frame.origin.x < _LeftSContentOffset)
            {
                sca = 1 - (_mainContentView.frame.origin.x/_LeftSContentOffset) * (1-_LeftSContentScale);
                lsca = 1 - sca + _LeftSContentScale;
            }
            else
            {
                sca = _LeftSContentScale;
            }
            self.changeLeftView(lsca, ltransX);
        }
        else    //transX < 0
        {
            if (!_canShowRight||_RightVC==nil) {
                return;
            }
            [self.view sendSubviewToBack:_leftSideView];
            _leftSideView.hidden = NO;// = YES;
            //配置阴影
            [self configureViewShadowWithDirection:RMoveDirectionLeft];
            
            if (_mainContentView.frame.origin.x > -_RightSContentOffset)
            {
                sca = 1 - (-_mainContentView.frame.origin.x/_RightSContentOffset) * (1-_RightSContentScale);
                lsca = 1 - sca + _RightSContentScale;
            }
            else
            {
                sca = _RightSContentScale;
            }
            self.changeRightView(lsca, rtransX);
        }
        CGAffineTransform transS = CGAffineTransformMakeScale(sca, sca);
        CGAffineTransform transT = CGAffineTransformMakeTranslation(transX, 0);
        CGAffineTransform conT = CGAffineTransformConcat(transT, transS);
        
        _mainContentView.transform = conT;
    }
    else if (panGes.state == UIGestureRecognizerStateEnded)
    {
        [leftButton setImage:nil];
//        [rightButton setImage:nil];
        CGFloat panX = [panGes translationInView:_mainContentView].x;
        CGFloat finalX = currentTranslateX + panX;
        
        if (finalX > _LeftSJudgeOffset)
        {
            if (!_canShowLeft||_LeftVC==nil) {
                return;
            }
            
            CGAffineTransform conT = [self transformWithDirection:RMoveDirectionRight];
            [UIView beginAnimations:nil context:nil];
            _mainContentView.transform = conT;
            [UIView commitAnimations];
            
            showingLeft=YES;
            _MainVC.view.userInteractionEnabled=NO;
            
            self.tapGestureRec.enabled = YES;
            
            [self showLeft:YES];
            
            return;
        }
        if (finalX < -_RightSJudgeOffset)
        {
            
            if (!_canShowRight || _RightVC==nil) {
                return;
            }
            
            CGAffineTransform conT = [self transformWithDirection:RMoveDirectionLeft];
            [UIView beginAnimations:nil context:nil];
            _mainContentView.transform = conT;
            [UIView commitAnimations];
            
            showingRight=YES;
            
            _MainVC.view.userInteractionEnabled=NO;
            
            self.tapGestureRec.enabled = YES;
            
            [self showRight:YES];
            
            return;
        }
        else
        {
            _leftSideView.hidden = NO;// = NO;
            _rightSideView.hidden = NO;// = NO;
            CGAffineTransform oriT = CGAffineTransformIdentity;
            [UIView beginAnimations:nil context:nil];
            _mainContentView.transform = oriT;
            [UIView commitAnimations];
            
            [self showLeft:NO];
            [self showRight:NO];
            showingRight=NO;
            showingLeft=NO;
            _MainVC.view.userInteractionEnabled=YES;
            self.tapGestureRec.enabled = NO;
            self.panGestureRec.enabled = NO;
        }
    }
}




#pragma mark -关掉touch
- (void)downTouch{
    self.view.userInteractionEnabled = NO;
}


- (void)showLeft:(BOOL)bShow
{
    if (bShow)
    {
        [UIView beginAnimations:nil context:nil];
        self.changeLeftView(1, 0);
        [UIView commitAnimations];
    }else
    {
        [UIView beginAnimations:nil context:nil];
        self.changeLeftView(_LeftSContentScale, -_LeftContentViewSContentOffset);
        [UIView commitAnimations];
    }
}
- (void)showRight:(BOOL)bShow
{
    if (bShow)
    {
        [UIView beginAnimations:nil context:nil];
        self.changeRightView(1, 0);
        [UIView commitAnimations];
    }
    else
    {
        [UIView beginAnimations:nil context:nil];
        self.changeRightView(_RightSContentScale, -_RightContentViewSContentOffset);
        [UIView commitAnimations];
    }
}
- (CGAffineTransform)transformWithDirection:(RMoveDirection)direction
{
    CGFloat translateX = 0;
    CGFloat transcale  = 0;
    switch (direction) {
        case RMoveDirectionLeft:
            translateX = -_RightSContentOffset;
            transcale  = _RightSContentScale;
            break;
        case RMoveDirectionRight:
            translateX = _LeftSContentOffset;
            transcale  = _LeftSContentScale;
            break;
        default:
            break;
    }
    
    CGAffineTransform transT = CGAffineTransformMakeTranslation(translateX, 0);
    CGAffineTransform scaleT = CGAffineTransformMakeScale(transcale, transcale);
    CGAffineTransform conT = CGAffineTransformConcat(transT, scaleT);
    return conT;
}

- (NSString*)deviceWithNumString{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    @try {
        return [deviceString stringByReplacingOccurrencesOfString:@"," withString:@""];
    }
    @catch (NSException *exception) {
        return deviceString;
    }
    @finally {
    }
}
//配置阴影
- (void)configureViewShadowWithDirection:(RMoveDirection)direction
{
    if ([[self deviceWithNumString] hasPrefix:@"iPhone"]&&[[[self deviceWithNumString] stringByReplacingOccurrencesOfString:@"iPhone" withString:@""] floatValue]<40) {
        return;
    }
    if ([[self deviceWithNumString] hasPrefix:@"iPod"]&&[[[self deviceWithNumString] stringByReplacingOccurrencesOfString:@"iPod" withString:@""] floatValue]<40) {
        return;
    }
    if ([[self deviceWithNumString] hasPrefix:@"iPad"]&&[[[self deviceWithNumString] stringByReplacingOccurrencesOfString:@"iPad" withString:@""] floatValue]<25) {
        return;
    }
    
    CGFloat shadowW;
    switch (direction)
    {
        case RMoveDirectionLeft:
            shadowW = 2.0f;
            break;
        case RMoveDirectionRight:
            shadowW = -2.0f;
            break;
        default:
            break;
    }
    _mainContentView.layer.shadowOffset = CGSizeMake(shadowW, 1.0);
    _mainContentView.layer.shadowColor = [UIColor blackColor].CGColor;
    _mainContentView.layer.shadowOpacity = 0.8f;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
    //        return NO;
    //    }
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIView"]) {
        return NO;
    }
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return  NO;
    }
    
    return  YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
