//
//  UIViewImageSampleView.h
//  iosStudy
//
//  Created by tigi on 2018. 1. 10..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "UIViewSampleView.h"

@interface UIViewImageSampleView : UIViewSampleView

@property (nonatomic, readonly) UIImageView *imageView;
@property (nonatomic, readonly) UILabel *descriptionLabel;
@property (nonatomic, readonly) CALayer *imageSubLayer;

@end
