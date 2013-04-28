//
//  SJOSideTabItem.h
//  SJOSideTabBarController
//
//  Created by Sam Oakley on 28/04/2013.
//  Copyright (c) 2013 Sam Oakley. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^OnTabSelectBlock)(int index, UIViewController *selectedViewController);

@interface SJOSideTabItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSString *iconName;
@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, copy) OnTabSelectBlock onSelect;
@property (nonatomic, assign, readonly) BOOL isSpace;

+ (SJOSideTabItem*) tabItemWithTitle:(NSString*) title andIconNamed:(NSString*)iconName andViewController: (UIViewController*) controller;
+ (SJOSideTabItem*) tabItemWithTitle:(NSString*) title andIconNamed:(NSString*)iconName andSelectionBlock: (OnTabSelectBlock) block;
+ (SJOSideTabItem*) tabItemFixedSpace;
@end

@interface SJOSideTabSpaceItem : SJOSideTabItem
@end
