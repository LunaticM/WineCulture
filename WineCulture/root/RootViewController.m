//
//  RootViewController.m
//  WineCulture
//
//  Created by miao on 14-6-26.
//  Copyright (c) 2014年 miao. All rights reserved.
//

#import "RootViewController.h"
#import "MainViewController.h"
#import "PokerViewController.h"
#import "SlieveViewController.h"
#import "SettingViewController.h"
#import "RouletteViewController.h"
#import "SlotViewController.h"
#import "AppDelegate.h"
@interface RootViewController ()

@end

@implementation RootViewController

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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bg.png"] forBarMetrics:UIBarMetricsDefault];
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStyleBordered target:self action:@selector(showMenu)];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark Button actions

- (void)showMenu
{
    if (!_sideMenu) {
        RESideMenuItem *homeItem = [[RESideMenuItem alloc] initWithTitle:@"首页" action:^(RESideMenu *menu, RESideMenuItem *item) {
            MainViewController *viewController = [[MainViewController alloc] init];
            viewController.title = item.title;
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
            [menu setRootViewController:navigationController];
        }];
        RESideMenuItem *exploreItem = [[RESideMenuItem alloc] initWithTitle:@"筛子" action:^(RESideMenu *menu, RESideMenuItem *item) {
            SlieveViewController *secondViewController = [[SlieveViewController alloc] init];
            secondViewController.title = item.title;
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
            [menu setRootViewController:navigationController];
        }];
        RESideMenuItem *activityItem = [[RESideMenuItem alloc] initWithTitle:@"扑克" action:^(RESideMenu *menu, RESideMenuItem *item) {
            [menu hide];
            
            PokerViewController *secondViewController = [[PokerViewController alloc] init];
            secondViewController.title = item.title;
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
            [menu setRootViewController:navigationController];
            
            
        }];
        RESideMenuItem *roulette = [[RESideMenuItem alloc] initWithTitle:@"转盘" action:^(RESideMenu *menu, RESideMenuItem *item) {
            [menu hide];
            RouletteViewController *secondViewController = [[RouletteViewController alloc] init];
            secondViewController.title = item.title;
            BTSPieView *pieView = [secondViewController pieView];

            [secondViewController setPieView:pieView];
            
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
            [menu setRootViewController:navigationController];
        }];
        
        
        RESideMenuItem *slot = [[RESideMenuItem alloc] initWithTitle:@"老虎机" action:^(RESideMenu *menu, RESideMenuItem *item) {
            [menu hide];
            SlotViewController *secondViewController = [[SlotViewController alloc] init];
            secondViewController.title = item.title;
            
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
            [menu setRootViewController:navigationController];
        }];
        
        
        RESideMenuItem *setting = [[RESideMenuItem alloc] initWithTitle:@"设置" action:^(RESideMenu *menu, RESideMenuItem *item) {
            [menu hide];
            SettingViewController *secondViewController = [[SettingViewController alloc] init];
            secondViewController.title = item.title;
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
            [menu setRootViewController:navigationController];
        }];
        
        
//        RESideMenuItem *aroundMeItem = [[RESideMenuItem alloc] initWithTitle:@"Around Me" action:^(RESideMenu *menu, RESideMenuItem *item) {
//            [menu hide];
//            NSLog(@"Item %@", item);
//        }];
//        
//        RESideMenuItem *helpPlus1 = [[RESideMenuItem alloc] initWithTitle:@"How to use" action:^(RESideMenu *menu, RESideMenuItem *item) {
//            NSLog(@"Item %@", item);
//            [menu hide];
//        }];
//        
//        RESideMenuItem *helpPlus2 = [[RESideMenuItem alloc] initWithTitle:@"Helpdesk" action:^(RESideMenu *menu, RESideMenuItem *item) {
//            NSLog(@"Item %@", item);
//            [menu hide];
//        }];
//        
//        RESideMenuItem *helpCenterItem = [[RESideMenuItem alloc] initWithTitle:@"Help +" action:^(RESideMenu *menu, RESideMenuItem *item) {
//            NSLog(@"Item %@", item);
//        }];
//        helpCenterItem.subItems  = @[helpPlus1,helpPlus2];
//        
//        RESideMenuItem *itemWithSubItems = [[RESideMenuItem alloc] initWithTitle:@"Sub items +" action:^(RESideMenu *menu, RESideMenuItem *item) {
//            NSLog(@"Item %@", item);
//        }];
//        itemWithSubItems.subItems = @[aroundMeItem,helpCenterItem];
        
      /*  RESideMenuItem *logOutItem = [[RESideMenuItem alloc] initWithTitle:@"Log out" action:^(RESideMenu *menu, RESideMenuItem *item) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Confirmation" message:@"Are you sure you want to log out?" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Log Out", nil];
            [alertView show];
        }];
       */
        
        _sideMenu = [[RESideMenu alloc] initWithItems:@[homeItem, exploreItem, activityItem,roulette,slot,setting]];
        _sideMenu.verticalOffset = IS_WIDESCREEN ? 110 : 76;
        _sideMenu.hideStatusBarArea = [AppDelegate OSVersion] < 7;
    }
    
    [_sideMenu show];
}
@end
