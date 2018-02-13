//
//  SampleMainTableViewCell.m
//  4_MultiCellTableViewExample
//
//  Created by tigi on 2018. 2. 13..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "SampleMainTableViewCell.h"

#define CELL_IMAGE_WIDTH 100.f
#define CELL_IMAGE_HEIGHT 100.f

@interface SampleMainTableViewCell()

@property (nonatomic, readwrite) UILabel *nameLabel;
@property (nonatomic, readwrite) UIImageView *profileImageView;

@end

@implementation SampleMainTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)aStyle reuseIdentifier:(NSString *)aReuseIdentifier
{
    self = [super initWithStyle:aStyle reuseIdentifier:aReuseIdentifier];
    if (self) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_nameLabel setNumberOfLines:1];
        [_nameLabel setFont:[UIFont systemFontOfSize:16]];
        [_nameLabel setTextColor:[UIColor darkGrayColor]];
        [[self contentView] addSubview:_nameLabel];
        
        _profileImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_profileImageView setContentMode:UIViewContentModeScaleAspectFit];
        [[self contentView] addSubview:_profileImageView];
        
        [self setSeparatorInset:UIEdgeInsetsZero];
        [[[self contentView] layer] setBorderColor:[[UIColor redColor] CGColor]];
        [[[self contentView] layer] setBorderWidth:2.f];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect sProfileImageViewFrame = [_profileImageView frame];
    sProfileImageViewFrame.origin.x = 20.0f;                                                                                                        // SetXPosition
    sProfileImageViewFrame.origin.y = (NSInteger)(([[_profileImageView superview] frame].size.height - sProfileImageViewFrame.size.height) / 2);    // MoveToVerticalCenter
    sProfileImageViewFrame.size = CGSizeMake(CELL_IMAGE_WIDTH, CELL_IMAGE_HEIGHT);                                                                  // SetSize
    [_profileImageView setFrame:sProfileImageViewFrame];
    
    [_nameLabel sizeToFit];
    CGRect sNameLabelFrame = [_nameLabel frame];
    sNameLabelFrame.origin.x = sProfileImageViewFrame.origin.x + sProfileImageViewFrame.size.width + 10.0f;                                         // MoveToRightOf _profileImageView
    sNameLabelFrame.origin.y = (NSInteger)(([[_nameLabel superview] frame].size.height - sNameLabelFrame.size.height) / 2);                         // MoveToVerticalCenter
    [_nameLabel setFrame:sNameLabelFrame];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    _profileImageView.image = nil;
    _nameLabel.text = @"";
}

@end
