//
//  SampleSubCollectionViewCell.m
//  5_CollectionVIewExample
//
//  Created by tigi on 2018. 2. 14..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "SampleSubCollectionViewCell.h"

@interface SampleSubCollectionViewCell()
@property (nonatomic, readwrite) UILabel *titleLabel;
@property (nonatomic, readwrite) UILabel *valueLabel;
@end

@implementation SampleSubCollectionViewCell

- (instancetype)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
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
    [_titleLabel setText:@""];
    [_valueLabel setText:@""];
}

@end
