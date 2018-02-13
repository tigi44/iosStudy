//
//  SampleSubTableViewCell.m
//  4_MultiCellTableViewExample
//
//  Created by tigi on 2018. 2. 13..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "SampleSubTableViewCell.h"

@interface SampleSubTableViewCell()

@property (nonatomic, readwrite) UILabel *titleLabel;
@property (nonatomic, readwrite) UILabel *valueLabel;

@end

@implementation SampleSubTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)aStyle reuseIdentifier:(NSString *)aReuseIdentifier
{
    self = [super initWithStyle:aStyle reuseIdentifier:aReuseIdentifier];
    if (self) {

        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_titleLabel setNumberOfLines:1];
        [_titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_titleLabel setTextColor:[UIColor grayColor]];
        [[self contentView] addSubview:_titleLabel];
        
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_valueLabel setNumberOfLines:1];
        [_valueLabel setFont:[UIFont systemFontOfSize:16]];
        [_valueLabel setTextColor:[UIColor grayColor]];
        [[self contentView] addSubview:_valueLabel];
        
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_titleLabel sizeToFit];
    CGRect sTitleLabelFrame = [_titleLabel frame];
    sTitleLabelFrame.origin.x = 20.0f;                                                                                            // SetXPosition
    sTitleLabelFrame.origin.y = (NSInteger)(([[_titleLabel superview] frame].size.height - sTitleLabelFrame.size.height) / 2);    // MoveToVerticalCenter
    [_titleLabel setFrame:sTitleLabelFrame];
    
    [_valueLabel sizeToFit];
    CGRect aValueLabelFrame = [_valueLabel frame];
    aValueLabelFrame.origin.x = (NSInteger)([[_valueLabel superview] frame].size.width - aValueLabelFrame.size.width - 20.0f);    // MoveToRightWithMargin
    aValueLabelFrame.origin.y = (NSInteger)(([[_valueLabel superview] frame].size.height - aValueLabelFrame.size.height) / 2);    // MoveToVerticalCenter
    [_valueLabel setFrame:aValueLabelFrame];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    _titleLabel.text = @"";
    _valueLabel.text = @"";
}

@end
