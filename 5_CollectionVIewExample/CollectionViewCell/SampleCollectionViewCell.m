//
//  SampleCollectionViewCell.m
//  5_CollectionVIewExample
//
//  Created by tigi on 2018. 2. 14..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "SampleCollectionViewCell.h"

@interface SampleCollectionViewCell()

@property (nonatomic, readwrite) UIImageView *imageView;

@end

@implementation SampleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    if (self) {        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_imageView setContentMode:UIViewContentModeScaleAspectFit];
        [_imageView setBackgroundColor:[UIColor redColor]];
        [[self contentView] addSubview:_imageView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGRect sImageViewFrame = [_imageView frame];
    sImageViewFrame.size = [self bounds].size;                                                                                  // SetSize
    sImageViewFrame.origin.x = (NSInteger)(([[_imageView superview] frame].size.width - sImageViewFrame.size.width) / 2);       // MoveToHorizontalCenter
    sImageViewFrame.origin.y = (NSInteger)(([[_imageView superview] frame].size.height - sImageViewFrame.size.height) / 2);     // MoveToVerticalCenter
    [_imageView setFrame:sImageViewFrame];
}

- (void)prepareForReuse
{
    [_imageView setImage:nil];
    [self setSelected:NO];
}


@end
