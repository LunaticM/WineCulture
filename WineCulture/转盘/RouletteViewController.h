//
//  RouletteViewController.h
//  WineCulture
//
//  Created by miao on 14-6-26.
//  Copyright (c) 2014年 miao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "BTSPieView.h"
@interface RouletteViewController : RootViewController
{
    UIImageView *image1,*image2;
    float random;
    float orign;
}

@property (nonatomic, weak, readwrite) BTSPieView *pieView;
@end
