//
//  SlotViewController.h
//  WineCulture
//
//  Created by miao on 14-6-27.
//  Copyright (c) 2014年 miao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "ZCSlotMachine.h"
@interface SlotViewController : RootViewController<ZCSlotMachineDelegate, ZCSlotMachineDataSource>

@end
