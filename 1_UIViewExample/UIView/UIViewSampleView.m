//
//  UIViewSampleView.m
//  iosStudy
//
//  Created by tigi on 2018. 1. 10..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "UIViewSampleView.h"

@implementation UIViewSampleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        ISDebugLog();
        
        // set the sample view background color
        [self setBackgroundColor:[UIColor darkGrayColor]];
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    ISDebugLog();
}

- (CGSize)sizeThatFits:(CGSize)size
{
    // excute when called 'sizeToFits' method
    ISDebugLog(@"%@", NSStringFromCGSize(size));
    return CGSizeMake(200, 200);
}


@end
