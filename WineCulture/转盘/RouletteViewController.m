//
//  RouletteViewController.m
//  WineCulture
//
//  Created by miao on 14-6-26.
//  Copyright (c) 2014年 miao. All rights reserved.
//

#import "RouletteViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "math.h"
#import "UIView+ZXQuartz.h"
#import "Canvas.h"
@interface BTSSliceData : NSObject

@property (nonatomic) int value;
@property (nonatomic, strong) UIColor *color;

+ (id)sliceDataWithValue:(int)value color:(UIColor *)color;

@end
@interface RouletteViewController () <BTSPieViewDataSource, BTSPieViewDelegate>

{
    NSArray *_availableSliceColors;
    NSMutableArray *_slices;
    UIButton *btn_start;
}
@end

@implementation RouletteViewController
@synthesize pieView = _pieView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //添加转盘
//    UIImageView *image_disk = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yuan.png"]];
//    image_disk.frame = CGRectMake(0.0, 60.0, 320.0, 320.0);
//    image1 = image_disk;
//    [self.view addSubview:image1];
  //  [self Makecircle];

    Canvas *canvas = [[Canvas alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:canvas];
    //[canvas loadData:1];
    //添加转针
    UIImageView *image_start = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"start.png"]];
    image_start.frame = CGRectMake(103.0, 115, 120.0, 210.0);
    image2 = image_start;
   [self.view addSubview:image2];
//    _slices = [[NSMutableArray alloc] init];
//    
//    _availableSliceColors = @[
//                              [UIColor colorWithRed:93.0f / 255.0f green:150.0f / 255.0f blue:72.0f / 255.0f alpha:1.0f],
//                              [UIColor colorWithRed:46.0f / 255.0f green:87.0f / 255.0f blue:140.0f / 255.0f alpha:1.0f],
//                              [UIColor colorWithRed:231.0f / 255.0f green:161.0f / 255.0f blue:61.0f / 255.0f alpha:1.0f],
//                              [UIColor colorWithRed:188.0f / 255.0f green:45.0f / 255.0f blue:48.0f / 255.0f alpha:1.0f],
//                              [UIColor colorWithRed:111.0f / 255.0f green:61.0f / 255.0f blue:121.0f / 255.0f alpha:1.0f],
//                              [UIColor colorWithRed:125.0f / 255.0f green:128.0f / 255.0f blue:127.0f / 255.0f alpha:1.0f],
//                              ];
//    
//    [_pieView setDataSource:self];
//    [_pieView setDelegate:self];
//    
//    
    //添加按钮
    btn_start = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_start.frame = CGRectMake((320-150)/2, 400, 150, 40);
    [btn_start setTitle:@"抽奖" forState:UIControlStateNormal];
    [btn_start setTintColor:[UIColor whiteColor]];
    [btn_start setBackgroundImage:[UIImage imageNamed:@"StartBtn_H@2x.png"] forState:UIControlStateNormal];
    [btn_start addTarget:self action:@selector(choujiang) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_start];
    btn_start.enabled = YES;
    
//    [self loadPieView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Perspective Methods (Hacks)

- (void)updateSublayerTransform:(CATransform3D)transform zPosition:(int)zPosition
{
    CALayer *pieLayer = [_pieView layer];
    
    CALayer *lineLayerGroup = [[pieLayer sublayers] objectAtIndex:0];
    [lineLayerGroup setSublayerTransform:transform];
    
    CALayer *sliceLayerGroup = [[pieLayer sublayers] objectAtIndex:1];
    [sliceLayerGroup setSublayerTransform:transform];
    [[sliceLayerGroup sublayers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj setZPosition:zPosition];
    }];
    
    CALayer *labelLayerGroup = [[pieLayer sublayers] objectAtIndex:2];
    [labelLayerGroup setSublayerTransform:transform];
    [[labelLayerGroup sublayers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj setZPosition:zPosition * 2];
        
        UIColor *color = zPosition == 0 ? [UIColor clearColor] : [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        [(CALayer *) obj setBackgroundColor:[color CGColor]];
    }];
}

- (void)loadPieView
{
    
    
    NSUInteger sliceCount = 5;
    for (int i = 0 ; i < sliceCount; i++) {
        UIColor *sliceColor = [_availableSliceColors objectAtIndex:(NSUInteger)i];
        BTSSliceData *sliceData = [BTSSliceData sliceDataWithValue:10 color:sliceColor];
        [_slices insertObject:sliceData atIndex:i];
    }
    
        [_pieView reloadData];
//
//    if ([_slices count] < sliceCount) { // "+" pressed
//        
//        NSUInteger insertIndex = (NSUInteger) 5 + 1;
//        
//        //        _nextColorIndex = _nextColorIndex + 1 < [_availableSliceColors count] ? 5 + 1 : 0;
//        UIColor *sliceColor = [_availableSliceColors objectAtIndex:(NSUInteger) 5];
//        
//        BTSSliceData *sliceData = [BTSSliceData sliceDataWithValue:10 color:sliceColor];
//        [_slices insertObject:sliceData atIndex:insertIndex];
//        
//        [_pieView insertSliceAtIndex:insertIndex animate:YES];
//    } else if ([_slices count] > sliceCount) { // "-" pressed
//        
//        //        // The user wants to remove the selected layer. We only allow the user to remove a selected layer
//        //        // if there is a known selection.
//        //        if (_selectedSliceIndex > -1) {
//        //
//        //            [_slices removeObjectAtIndex:(NSUInteger) _selectedSliceIndex];
//        //            [_pieView removeSliceAtIndex:(NSUInteger) _selectedSliceIndex animate:shouldAnimate];
//        //
//        //            // As mentioned in the class level notes, any time a wedge is deleted the view controller's
//        //            // selection index is set to -1 (no selection). This keeps the user from pressing the "-"
//        //            // stepper button really fast and causing the pie view to go nuts. Yes, this is a problem
//        //            // with this version of the BTSPieView.
//        //            _selectedSliceIndex = -1;
//        //        } else {
//        //
//        //            // no selection... reset the stepper... no need to reload the pie view.
//        //            [_sliceStepper setValue:sliceCount + 1];
//        //            [self updateSliceCount:_sliceStepper];
//        //        }
//    }
}
- (void)choujiang
{
    
    if ( btn_start.enabled ==YES) {
        //******************旋转动画******************
        //产生随机角度
        srand((unsigned)time(0));  //不加这句每次产生的随机数不变
        random = (rand() % 20) / 10.0;
        //设置动画
        CABasicAnimation *spin = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        [spin setFromValue:[NSNumber numberWithFloat:M_PI * (0.0+orign)]];
        [spin setToValue:[NSNumber numberWithFloat:M_PI * (10.0+random+orign)]];
        [spin setDuration:2.5];
        [spin setDelegate:self];//设置代理，可以相应animationDidStop:finished:函数，用以弹出提醒框
        //速度控制器
        [spin setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        //添加动画
        [[image2 layer] addAnimation:spin forKey:nil];
        //锁定结束位置
        image2.transform = CGAffineTransformMakeRotation(M_PI * (10.0+random+orign));
        //锁定fromValue的位置
        orign = 10.0+random+orign;
        orign = fmodf(orign, 2.0);
        btn_start.enabled = NO;
    }

    


}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    btn_start.enabled = YES;
    //判断抽奖结果
    if (orign >= 0.0 && orign < (0.5/3.0)) {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 数字：3 ！ " delegate:self cancelButtonTitle:@"ok！" otherButtonTitles: nil];
        [result show];
       
    }
    else if (orign >= (0.5/3.0) && orign < ((0.5/3.0)*2))
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 数字：4 ！ " delegate:self cancelButtonTitle:@"ok！" otherButtonTitles: nil];
        [result show];

    }else if (orign >= ((0.5/3.0)*2) && orign < ((0.5/3.0)*3))
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 数字：4 ！ " delegate:self cancelButtonTitle:@"ok！" otherButtonTitles: nil];
        [result show];
      
    }else if (orign >= (0.0+0.5) && orign < ((0.5/3.0)+0.5))
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 数字：5 ！ " delegate:self cancelButtonTitle:@"ok！" otherButtonTitles: nil];
        [result show];
  
    }else if (orign >= ((0.5/3.0)+0.5) && orign < (((0.5/3.0)*2)+0.5))
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 数字：5 ！ " delegate:self cancelButtonTitle:@"ok！" otherButtonTitles: nil];
        [result show];
      
    }else if (orign >= (((0.5/3.0)*2)+0.5) && orign < (((0.5/3.0)*3)+0.5))
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 数字：6 ！" delegate:self cancelButtonTitle:@"ok！" otherButtonTitles: nil];
        [result show];
       
    }else if (orign >= (0.0+1.0) && orign < ((0.5/3.0)+1.0))
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 数字：6 ！ " delegate:self cancelButtonTitle:@"ok！" otherButtonTitles: nil];
        [result show];
      
    }else if (orign >= ((0.5/3.0)+1.0) && orign < (((0.5/3.0)*2)+1.0))
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 数字：1 ！ " delegate:self cancelButtonTitle:@"ok！" otherButtonTitles: nil];
        [result show];
      
    }else if (orign >= (((0.5/3.0)*2)+1.0) && orign < (((0.5/3.0)*3)+1.0))
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 数字：1 ！  " delegate:self cancelButtonTitle:@"ok！" otherButtonTitles: nil];
        [result show];
      
    }else if (orign >= (0.0+1.5) && orign < ((0.5/3.0)+1.5))
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 数字：2 ！ " delegate:self cancelButtonTitle:@"ok！" otherButtonTitles: nil];
        [result show];
    
    }else if (orign >= ((0.5/3.0)+1.5) && orign < (((0.5/3.0)*2)+1.5))
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 数字：2 ！  " delegate:self cancelButtonTitle:@"ok！" otherButtonTitles: nil];
        [result show];
  
    }else if (orign >= (((0.5/3.0)*2)+1.5) && orign < (((0.5/3.0)*3)+1.5))
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 数字：3 ！ " delegate:self cancelButtonTitle:@"ok！" otherButtonTitles: nil];
        [result show];
      
    }
}

#pragma mark - BTSPieView Data Source

- (NSUInteger)numberOfSlicesInPieView:(BTSPieView *)pieView
{
    return [_slices count];
}

- (CGFloat)pieView:(BTSPieView *)pieView valueForSliceAtIndex:(NSUInteger)index
{
    return [(BTSSliceData *) [_slices objectAtIndex:index] value];
}

- (UIColor *)pieView:(BTSPieView *)pieView colorForSliceAtIndex:(NSUInteger)index sliceCount:(NSUInteger)sliceCount
{
    return [(BTSSliceData *) [_slices objectAtIndex:index] color];
}

#pragma mark - BTSPieView Delegate

- (void)pieView:(BTSPieView *)pieView willSelectSliceAtIndex:(NSInteger)index
{
}

- (void)pieView:(BTSPieView *)pieView didSelectSliceAtIndex:(NSInteger)index
{
    // save the index the user selected.
    //    _selectedSliceIndex = index;
    //
    //    // update the selected slice UI components with the model values
    //    BTSSliceData *sliceData = [_slices objectAtIndex:(NSUInteger) _selectedSliceIndex];
    //    [_selectedSliceValueLabel setText:[NSString stringWithFormat:@"%d", [sliceData value]]];
    //    [_selectedSliceValueLabel setAlpha:1.0];
    //
    //    [_selectedSliceValueSlider setValue:[sliceData value]];
    //    [_selectedSliceValueSlider setEnabled:YES];
    //    [_selectedSliceValueSlider setMinimumTrackTintColor:[sliceData color]];
    //    [_selectedSliceValueSlider setMaximumTrackTintColor:[sliceData color]];
}

- (void)pieView:(BTSPieView *)pieView willDeselectSliceAtIndex:(NSInteger)index
{
}

- (void)pieView:(BTSPieView *)pieView didDeselectSliceAtIndex:(NSInteger)index
{
//    [_selectedSliceValueSlider setMinimumTrackTintColor:nil];
//    [_selectedSliceValueSlider setMaximumTrackTintColor:nil];
//    
//    // nothing is selected... so turn off the "selected value" controls
//    _selectedSliceIndex = -1;
//    [_selectedSliceValueSlider setEnabled:NO];
//    [_selectedSliceValueSlider setValue:0.0];
//    [_selectedSliceValueLabel setAlpha:0.0];
//    
//    [self updateSelectedSliceValue:_selectedSliceValueSlider];
}
@end
@implementation BTSSliceData

+ (id)sliceDataWithValue:(int)value color:(UIColor *)color
{
    BTSSliceData *data = [[BTSSliceData alloc] init];
    [data setValue:value];
    [data setColor:color];
    return data;
}

@end
