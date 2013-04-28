//
//  ExampleViewController.m
//  SJOSideTabBarController
//
//  Created by Sam Oakley on 27/04/2013.
//  Copyright (c) 2013 Sam Oakley. All rights reserved.
//

#import "ExampleViewController.h"

@interface ExampleViewController ()
@property (strong, nonatomic) UILabel* label;
@end

@implementation ExampleViewController

-(void)loadView
{
    self.view = [[UIView alloc] initWithFrame:self.parentViewController.view.bounds];
    [self.view setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];

    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.label = [[UILabel alloc] init];
    [self.label setText:self.title];
    [self.label sizeToFit];
    [self.label setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin];
    [self.view addSubview:self.label];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismiss)];
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.label setCenter:CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds))];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
