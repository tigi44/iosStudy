//
//  ImageSampleView.h
//  iosStudy
//
//  Created by tigi on 2018. 1. 10..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SampleView.h"

@interface ImageSampleView : SampleView

@property (nonatomic, readonly) UIImageView *imageView;
@property (nonatomic, readonly) UILabel *descriptionLabel;
@property (nonatomic, readonly) CALayer *imageSubLayer;
@property (nonatomic, readonly) UIButton *button;

@end
