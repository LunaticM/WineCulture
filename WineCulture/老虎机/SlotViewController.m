//
//  SlotViewController.m
//  WineCulture
//
//  Created by miao on 14-6-27.
//  Copyright (c) 2014年 miao. All rights reserved.
//

#import "SlotViewController.h"

@interface SlotViewController ()
{
@private
    ZCSlotMachine *_slotMachine;
    UIButton *_startButton;
    
    UIView *_slotContainerView;
    UIImageView *_slotOneImageView;
    UIImageView *_slotTwoImageView;
    UIImageView *_slotThreeImageView;
    UIImageView *_slotFourImageView;
    
    NSArray *_slotIcons;
    UILabel *infoLable;
    int count;
}
@end

@implementation SlotViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _slotIcons = [NSArray arrayWithObjects:
                      [UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"], [UIImage imageNamed:@"3"],[UIImage imageNamed:@"4"], nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   	
    _slotMachine = [[ZCSlotMachine alloc] initWithFrame:CGRectMake(0, 0, 291, 193)];
    _slotMachine.center = CGPointMake(self.view.frame.size.width / 2, 120);
    _slotMachine.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    _slotMachine.contentInset = UIEdgeInsetsMake(5, 8, 5, 8);
    _slotMachine.backgroundImage = [UIImage imageNamed:@"SlotMachineBackground"];
    _slotMachine.coverImage = [UIImage imageNamed:@"SlotMachineCover"];
    
    _slotMachine.delegate = self;
    _slotMachine.dataSource = self;
    
    [self.view addSubview:_slotMachine];
    
    _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *btnImageN = [UIImage imageNamed:@"StartBtn_N"];
    UIImage *btnImageH = [UIImage imageNamed:@"StartBtn_H"];
    _startButton.frame = CGRectMake(0, 0, btnImageN.size.width, btnImageN.size.height);
    _startButton.center = CGPointMake(self.view.frame.size.width / 2, 270);
    _startButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    _startButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [_startButton setBackgroundImage:btnImageN forState:UIControlStateNormal];
    [_startButton setBackgroundImage:btnImageH forState:UIControlStateHighlighted];
    [_startButton setTitle:@"Start" forState:UIControlStateNormal];
    [_startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_startButton];
    
    
    _slotContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 45)];
    _slotContainerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    _slotContainerView.center = CGPointMake(self.view.frame.size.width / 2, 350);
    
    [self.view addSubview:_slotContainerView];
    
    
    
    
    //结果显示
    infoLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    infoLable.contentMode = UIViewContentModeCenter;
    infoLable.backgroundColor = [UIColor blackColor];
    infoLable.textColor = [UIColor redColor];
    infoLable.font = [UIFont boldSystemFontOfSize:21.0f];
    infoLable.textAlignment = NSTextAlignmentCenter;
    [_slotContainerView addSubview:infoLable];
//    _slotOneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
//    _slotOneImageView.contentMode = UIViewContentModeCenter;
//    
//    _slotTwoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(45, 0, 45, 45)];
//    _slotTwoImageView.contentMode = UIViewContentModeCenter;
    //
    //    _slotThreeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(90, 0, 45, 45)];
    //    _slotThreeImageView.contentMode = UIViewContentModeCenter;
    //
    //    _slotFourImageView = [[UIImageView alloc] initWithFrame:CGRectMake(135, 0, 45, 45)];
    //    _slotFourImageView.contentMode = UIViewContentModeCenter;
    
//    [_slotContainerView addSubview:_slotOneImageView];
//    [_slotContainerView addSubview:_slotTwoImageView];
//    [_slotContainerView addSubview:_slotThreeImageView];
//    [_slotContainerView addSubview:_slotFourImageView];
}
#pragma mark - Private Methods

- (void)start {
    count = 0;
    NSUInteger slotIconCount = [_slotIcons count];
    
    int slotOneIndex = abs(rand() % slotIconCount);
    int slotTwoIndex = abs(rand() % slotIconCount);
    int slotThreeIndex = abs(rand() % slotIconCount);
    int slotFourIndex = abs(rand() % slotIconCount);
    
    
    count = slotOneIndex + slotTwoIndex + slotThreeIndex + slotFourIndex+4;
    
//    _slotOneImageView.image = [_slotIcons objectAtIndex:slotOneIndex];
//    _slotTwoImageView.image = [_slotIcons objectAtIndex:slotTwoIndex];
//    _slotThreeImageView.image = [_slotIcons objectAtIndex:slotThreeIndex];
//    _slotFourImageView.image = [_slotIcons objectAtIndex:slotFourIndex];
//    
    _slotMachine.slotResults = [NSArray arrayWithObjects:
                                [NSNumber numberWithInteger:slotOneIndex],
                                [NSNumber numberWithInteger:slotTwoIndex],
                                [NSNumber numberWithInteger:slotThreeIndex],
                                [NSNumber numberWithInteger:slotFourIndex],
                                nil];
    
    [_slotMachine startSliding];
}

#pragma mark - UIResponder

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    _startButton.highlighted = YES;
    [_startButton performSelector:@selector(setHighlighted:) withObject:[NSNumber numberWithBool:NO] afterDelay:0.8];
    
    [self start];
}

#pragma mark - ZCSlotMachineDelegate

- (void)slotMachineWillStartSliding:(ZCSlotMachine *)slotMachine {
    _startButton.enabled = NO;
}

- (void)slotMachineDidEndSliding:(ZCSlotMachine *)slotMachine {
    _startButton.enabled = YES;
    infoLable.text = [NSString stringWithFormat:@"%d",count];
    
}

#pragma mark - ZCSlotMachineDataSource

- (NSArray *)iconsForSlotsInSlotMachine:(ZCSlotMachine *)slotMachine {
    return _slotIcons;
}

- (NSUInteger)numberOfSlotsInSlotMachine:(ZCSlotMachine *)slotMachine {
    return 4;
}

- (CGFloat)slotWidthInSlotMachine:(ZCSlotMachine *)slotMachine {
    return 65.0f;
}

- (CGFloat)slotSpacingInSlotMachine:(ZCSlotMachine *)slotMachine {
    return 5.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
