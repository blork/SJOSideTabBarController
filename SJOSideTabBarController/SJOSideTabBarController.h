//
//  SJOSideTabBarController.h
//  SJOSideTabBarController
//
//  Created by Sam Oakley on 27/04/2013.
//  Copyright (c) 2013 Sam Oakley. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SJOSideTabBarControllerDelegate;
@class SJOSideTabItem;
@interface SJOSideTabBarController : UIViewController

@property (strong, nonatomic, readonly) NSArray *tabItems;
@property (strong, nonatomic, readonly) SJOSideTabItem *selectedTabItem;
@property (weak, nonatomic) UIViewController<SJOSideTabBarControllerDelegate> *delegate;

@property (strong, nonatomic) UIColor *backgroundColor;
@property (strong, nonatomic) UIColor *selectedBackgroundColor;
@property (strong, nonatomic) UIColor *iconSelectedColor;
@property (strong, nonatomic) UIColor *iconUnselectedColor;


- (void)setTabItems:(NSArray *)tabItems;
- (void)setSelectedTabItem:(SJOSideTabItem *)selectedTabItem;
- (NSUInteger)selectedIndex;
- (void)setSelectedIndex:(NSUInteger)selectedIndex;

@end

@protocol SJOSideTabBarControllerDelegate <NSObject>

@optional
- (BOOL)sideBarController:(SJOSideTabBarController *)sideBarController shouldSelectViewController:(UIViewController *)viewController;
- (void)sideBarController:(SJOSideTabBarController *)sideBarController didSelectViewController:(UIViewController *)viewController;
@end