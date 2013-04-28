//
//  SJOSideTabItem.m
//  SJOSideTabBarController
//
//  Created by Sam Oakley on 28/04/2013.
//  Copyright (c) 2013 Sam Oakley. All rights reserved.
//

#import "SJOSideTabItem.h"

@implementation SJOSideTabSpaceItem
@end

@implementation SJOSideTabItem

+ (SJOSideTabItem*) tabItemWithTitle:(NSString*) title andIconNamed:(NSString*)iconName andViewController: (UIViewController*) controller
{
    if (!title || !iconName || !controller) {
        return nil;
    }
    
    SJOSideTabItem *item = [[SJOSideTabItem alloc] init];
    item.title = title;
    item.iconName = iconName;
    item.viewController = controller;
    return item;
}

+ (SJOSideTabItem*) tabItemWithTitle:(NSString*) title andIconNamed:(NSString*)iconName andSelectionBlock: (OnTabSelectBlock) block
{
    if (!title || !iconName || !block) {
        return nil;
    }
    
    SJOSideTabItem *item = [[SJOSideTabItem alloc] init];
    item.title = title;
    item.iconName = iconName;
    item.onSelect = block;
    return item;
}

+ (SJOSideTabItem*) tabItemFixedSpace
{    
    static dispatch_once_t pred;
    static SJOSideTabItem *item = nil;
    dispatch_once(&pred, ^{
        item = [[SJOSideTabSpaceItem alloc] init];
    });
    return item;
}


-(void)dealloc
{
    _title = nil;
    _iconName = nil;
    _viewController = nil;
    _onSelect = nil;
}

@end


