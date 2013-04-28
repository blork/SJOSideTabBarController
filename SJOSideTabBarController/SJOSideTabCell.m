//
//  SJOSideTabCell.m
//  SJOSideTabBarController
//
//  Created by Sam Oakley on 28/04/2013.
//  Copyright (c) 2013 Sam Oakley. All rights reserved.
//

#import "SJOSideTabCell.h"

@implementation SJOSideTabCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {        
        [self.textLabel setTextAlignment:NSTextAlignmentCenter];
        [self.textLabel setBackgroundColor:[UIColor clearColor]];
        [self.textLabel setFont:[UIFont boldSystemFontOfSize:11]];
        [self.textLabel setTextColor:[UIColor whiteColor]];
        
        UIView* backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        [backgroundView setBackgroundColor:[UIColor lightGrayColor]];

        [self setSelectedBackgroundView:backgroundView];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat spacing = 6.0;
    CGFloat width = self.bounds.size.width - 6;
    CGFloat height = self.bounds.size.height;
    self.imageView.frame = CGRectMake((width / 2) - 14, (height / 2) - 14 - ((spacing + 11) / 2), 28, 28);
    self.textLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + spacing, width, 11);
}


@end
