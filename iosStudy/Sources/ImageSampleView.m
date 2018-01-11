//
//  ImageSampleView.m
//  iosStudy
//
//  Created by tigi on 2018. 1. 10..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "ImageSampleView.h"

@interface ImageSampleView()

@property (nonatomic, readwrite) UIImageView *imageView;
@property (nonatomic, readwrite) UILabel *descriptionLabel;
@property (nonatomic, readwrite) CALayer *imageSubLayer;
@property (nonatomic, readwrite) UIButton *button;

@end

@implementation ImageSampleView

- (instancetype)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    if (self) {
        [self setupSubview];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIImageView *sImageView = [self imageView];
    
    CGRect sImageViewFrame = [sImageView frame];
    sImageViewFrame.size = CGSizeMake(200, 200);
    sImageViewFrame.origin.x = (NSInteger)(([[sImageView superview] frame].size.width - sImageViewFrame.size.width) / 2); // MoveToHorizontalCenter
    sImageViewFrame.origin.y = (NSInteger)(([[sImageView superview] frame].size.height - sImageViewFrame.size.height) / 2); // MoveToVerticalCenter
    [sImageView setFrame:sImageViewFrame];

    [[sImageView layer] setCornerRadius:100.f];
    [[sImageView layer] setMasksToBounds:YES];
    
    CGRect sImageViewBound = [sImageView bounds];
    [_imageSubLayer setFrame:CGRectMake(sImageViewBound.origin.x + sImageViewBound.size.width/4,
                                        sImageViewBound.origin.y,
                                        sImageViewBound.size.width/2,
                                        sImageViewBound.size.height/4)];
    //    [_imageSubLayer setCornerRadius:10.f];
    //    [_imageSubLayer setMasksToBounds:YES];
    
    
    //UILabel *sLabel = [self descriptionLabel];
    [_descriptionLabel sizeToFit];
    CGRect sDescriptionLabelFrame = [_descriptionLabel frame];
    sDescriptionLabelFrame.origin.x = (NSInteger)(([[_descriptionLabel superview] frame].size.width - sDescriptionLabelFrame.size.width) / 2); // MoveToHorizontalCenter
    sDescriptionLabelFrame.origin.y = sImageViewFrame.origin.y + sImageViewFrame.size.height + 10.0f; // MoveToBottomOf 'ImageView'
    [_descriptionLabel setFrame:sDescriptionLabelFrame];
    
    CGRect sButtonFrame = [_button frame];
    sButtonFrame.origin.x = (NSInteger)(([[_button superview] frame].size.width - sButtonFrame.size.width) / 2); // MoveToHorizontalCenter
    sButtonFrame.origin.y = sDescriptionLabelFrame.origin.y + sDescriptionLabelFrame.size.height + 10.0f; // MoveToBottomOf 'DescriptionLabel'
    [_button setFrame:sButtonFrame];
}

- (void)setupSubview
{
    [self setImageView:[[UIImageView alloc] initWithFrame:CGRectZero]];
    
    UIImageView *sImageView = [self imageView];
    [sImageView setContentMode:UIViewContentModeScaleAspectFill];
    [sImageView setBackgroundColor:[UIColor redColor]];
    
    [self setImageSubLayer:[[CALayer alloc] init]];
    
    CALayer *sImageLayer = _imageSubLayer;
    [sImageLayer setBackgroundColor:[[UIColor blueColor] CGColor]];
    [sImageLayer setShadowOffset:CGSizeMake(10, 10)];
    [sImageLayer setShadowRadius:5];
    [sImageLayer setShadowOpacity:0.8];
    [[sImageView layer] addSublayer: sImageLayer];
    
    [self addSubview:sImageView];
    
    [self setDescriptionLabel:[[UILabel alloc] initWithFrame:CGRectZero]];
    
    UILabel *sLabel = [self descriptionLabel];
    [sLabel setNumberOfLines:1];
    [sLabel setFont:[UIFont boldSystemFontOfSize:24.0f]];
    [sLabel setTextColor:[UIColor whiteColor]];
    [sLabel setText:@"...."];

    [self addSubview:sLabel];
    
    [self setButton:[UIButton buttonWithType:(UIButtonTypeContactAdd)]];
    
    UIButton *sButton = [self button];
    [self addSubview:sButton];
    
}

@end
