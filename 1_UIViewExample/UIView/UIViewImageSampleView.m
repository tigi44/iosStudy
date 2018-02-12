//
//  UIViewImageSampleView.m
//  iosStudy
//
//  Created by tigi on 2018. 1. 10..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "UIViewImageSampleView.h"

@interface UIViewImageSampleView()

@property (nonatomic, readwrite) UIImageView *imageView;
@property (nonatomic, readwrite) UILabel *descriptionLabel;
@property (nonatomic, readwrite) CALayer *imageSubLayer;

@end

@implementation UIViewImageSampleView

- (instancetype)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    if (self) {
        ISDebugLog();
        
        [self setupSubview];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    ISDebugLog();
    
    // set the imageView layout
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
    
    // set the label layout
    [_descriptionLabel sizeToFit];
    CGRect sDescriptionLabelFrame = [_descriptionLabel frame];
    sDescriptionLabelFrame.origin.x = (NSInteger)(([[_descriptionLabel superview] frame].size.width - sDescriptionLabelFrame.size.width) / 2); // MoveToHorizontalCenter
    sDescriptionLabelFrame.origin.y = sImageViewFrame.origin.y + sImageViewFrame.size.height + 10.0f; // MoveToBottomOf 'ImageView'
    [_descriptionLabel setFrame:sDescriptionLabelFrame];
}

- (void)setupSubview
{
    // init the image view
    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_imageView setContentMode:UIViewContentModeScaleAspectFill];
    [_imageView setBackgroundColor:[UIColor redColor]];
    
    // init the subLayer
    _imageSubLayer = [[CALayer alloc] init];
    CALayer *sImageLayer = _imageSubLayer;
    [sImageLayer setBackgroundColor:[[UIColor blueColor] CGColor]];
    [sImageLayer setShadowOffset:CGSizeMake(10, 10)];
    [sImageLayer setShadowRadius:5];
    [sImageLayer setShadowOpacity:0.8];
    [[_imageView layer] addSublayer: sImageLayer];
    
    [self addSubview:_imageView];
    
    // init the label
    _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_descriptionLabel setNumberOfLines:1];
    [_descriptionLabel setFont:[UIFont boldSystemFontOfSize:24.0f]];
    [_descriptionLabel setTextColor:[UIColor whiteColor]];
    [_descriptionLabel setText:@"...."];

    [self addSubview:_descriptionLabel];  
}

@end
