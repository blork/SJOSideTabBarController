//
//  SJOSideTabBarController.m
//  SJOSideTabBarController
//
//  Created by Sam Oakley on 27/04/2013.
//  Copyright (c) 2013 Sam Oakley. All rights reserved.
//

#import "SJOSideTabBarController.h"
#import "SJOSideTabItem.h"
#import "SJOSideTabCell.h"
#import "UIImage+IPImageUtils.h"
#import <QuartzCore/QuartzCore.h>

@interface SJOSideTabBarController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *sideTabBarView;
@property (strong, nonatomic) UIView *contentContainerView;
@property (strong, nonatomic) UIView *borderView;
@end


@implementation SJOSideTabBarController

@synthesize backgroundColor = _backgroundColor;
@synthesize selectedBackgroundColor = _selectedBackgroundColor;
@synthesize iconSelectedColor = _iconSelectedColor;
@synthesize iconUnselectedColor = _iconUnselectedColor;


- (id)init {
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
        [NSException raise:NSInvalidArgumentException format:@"CKSideBarController is only supported when running under UIUserInterfaceIdiomPad"];
        return nil;
    }
    
    self = [super init];
    if (self) {
        [self.view setBackgroundColor:self.backgroundColor];
        
        self.sideTabBarView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100 + 6, self.view.bounds.size.height) style:UITableViewStylePlain];
        self.sideTabBarView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
        self.sideTabBarView.backgroundColor = [UIColor clearColor];
        self.sideTabBarView.scrollEnabled = YES;
        self.sideTabBarView.dataSource = self;
        self.sideTabBarView.delegate = self;
        self.sideTabBarView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.sideTabBarView.rowHeight = 100;
        
        [self.view addSubview:self.sideTabBarView];
        
        self.contentContainerView = [[UIView alloc] initWithFrame:CGRectMake(100, 0, self.view.bounds.size.width - 100, self.view.bounds.size.height)];
        self.contentContainerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.contentContainerView.clipsToBounds = YES;
        self.contentContainerView.layer.cornerRadius = 6;
        
        [self.view addSubview:self.contentContainerView];
    }
    return self;
}

-(UIColor *)backgroundColor
{
    if (!_backgroundColor) {
        _backgroundColor = [UIColor darkGrayColor];
    }
    return _backgroundColor;
}

-(void)setBackgroundColor:(UIColor *)backgroundColor
{
    _backgroundColor = backgroundColor;
    [self.sideTabBarView setBackgroundColor:_backgroundColor];
}

-(UIColor *)selectedBackgroundColor
{
    if (!_selectedBackgroundColor) {
        _selectedBackgroundColor = [UIColor lightGrayColor];
    }
    return _selectedBackgroundColor;
}

-(void)setSelectedBackgroundColor:(UIColor *)selectedBackgroundColor{
    _selectedBackgroundColor = selectedBackgroundColor;
    [self.sideTabBarView reloadData];
}


-(UIColor *)iconSelectedColor
{
    if (!_iconSelectedColor) {
        _iconSelectedColor = [UIColor darkGrayColor];
    }
    return _iconSelectedColor;
}

-(void)setIconSelectedColor:(UIColor *)iconSelectedColor
{
    _iconSelectedColor = iconSelectedColor;
    [self.sideTabBarView reloadData];
}

-(UIColor *)iconUnselectedColor
{
    if (!_iconUnselectedColor) {
        _iconUnselectedColor = [UIColor whiteColor];
    }
    return _iconUnselectedColor;
}

-(void)setIconUnelectedColor:(UIColor *)iconUnselectedColor
{
    _iconUnselectedColor = iconUnselectedColor;
    [self.sideTabBarView reloadData];
}

#pragma mark - Autorotation
// iOS 6+
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate {
    return YES;
}

#pragma mark - public

- (void)setTabItems:(NSArray *)tabItems
{
    if (tabItems != _tabItems) {
        BOOL isSelectedControllerPresent = [tabItems containsObject:_selectedTabItem];
        NSUInteger previousSelectedIndex = self.selectedIndex;
        
        for (SJOSideTabItem *tabItem in _tabItems) {
            if (tabItem.viewController != _selectedTabItem.viewController || !isSelectedControllerPresent) {
                [tabItem.viewController.view removeFromSuperview];
                [tabItem.viewController removeFromParentViewController];
            }
        }
        
        _tabItems = tabItems;
        
        for (SJOSideTabItem *tabItem in _tabItems) {
            if (tabItem.viewController) {
                [self addChildViewController:tabItem.viewController];
            }
        }
        
        if (_selectedTabItem && [_tabItems containsObject:self.selectedTabItem]) {
            // we cool
        } else {
            self.selectedTabItem = _tabItems[previousSelectedIndex];
        }
        
        [self.view setNeedsLayout];
    }
}

- (void)setSelectedTabItem:(SJOSideTabItem *)selectedTabItem
{
    if (selectedTabItem.viewController) {
        BOOL delegateRespondsToSelector = [self.delegate respondsToSelector:@selector(sideBarController:shouldSelectViewController:)];
        BOOL shouldSelectController = delegateRespondsToSelector ? [self.delegate sideBarController:self shouldSelectViewController:selectedTabItem.viewController] : YES;
        if (shouldSelectController && _selectedTabItem.viewController != selectedTabItem.viewController) {
            UIViewController *oldController = _selectedTabItem.viewController;
            _selectedTabItem = selectedTabItem;
            
            [self.contentContainerView addSubview:_selectedTabItem.viewController.view];
            [oldController.view removeFromSuperview];
            
            [self.view setNeedsLayout];
            
            [self.sideTabBarView selectRowAtIndexPath:[NSIndexPath indexPathForItem:[_tabItems indexOfObject:_selectedTabItem] inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
            
            if ([self.delegate respondsToSelector:@selector(sideBarController:didSelectViewController:)]) {
                [self.delegate sideBarController:self didSelectViewController:_selectedTabItem.viewController];
            }
        }
    } else if (selectedTabItem.onSelect) {
        selectedTabItem.onSelect([_tabItems indexOfObject:_selectedTabItem], _selectedTabItem.viewController);
        _selectedTabItem = selectedTabItem;
    }
        
    NSIndexPath *ipath = [self.sideTabBarView indexPathForSelectedRow];
    [self.sideTabBarView reloadData];
    [self.sideTabBarView selectRowAtIndexPath:ipath animated:YES scrollPosition:UITableViewScrollPositionNone];

}

- (NSUInteger)selectedIndex
{
    if (self.selectedTabItem) {
        return [self.tabItems indexOfObject:self.selectedTabItem];
    } else {
        return 0;
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    self.selectedTabItem = self.tabItems[selectedIndex];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tabItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseId = @"sideBar";
    
    SJOSideTabCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    
    if (!cell) {
        cell = [[SJOSideTabCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    
    [cell.selectedBackgroundView setBackgroundColor:self.selectedBackgroundColor];

    SJOSideTabItem *tabItem = self.tabItems[indexPath.row];
    
    if ([tabItem isKindOfClass:[SJOSideTabSpaceItem class]]) {
        [cell.textLabel setText:nil];
        [cell.imageView setImage:nil];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setUserInteractionEnabled:NO];
    } else {
        if (tabItem == _selectedTabItem) {
            [cell.imageView setImage:[UIImage ipMaskedImageNamed:tabItem.iconName color:self.iconSelectedColor]];
        } else {
            [cell.imageView setImage:[UIImage ipMaskedImageNamed:tabItem.iconName color:self.iconUnselectedColor]];
        }
        [cell.textLabel setText:tabItem.title];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];

    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedTabItem = self.tabItems[indexPath.row];
    NSIndexPath *ipath = [self.sideTabBarView indexPathForSelectedRow];
    [self.sideTabBarView reloadData];
    [self.sideTabBarView selectRowAtIndexPath:ipath animated:YES scrollPosition:UITableViewScrollPositionNone];
}


-(void)dealloc
{
    _tabItems = nil;
    _selectedTabItem = nil;
    _delegate = nil;
    _sideTabBarView = nil;
    _contentContainerView = nil;
    _borderView = nil;

}

@end
