//
//  RootViewController.h
//  WineCulture
//
//  Created by miao on 14-6-26.
//  Copyright (c) 2014年 miao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface RootViewController : UIViewController

@property (strong, readonly, nonatomic) RESideMenu *sideMenu;

@end
