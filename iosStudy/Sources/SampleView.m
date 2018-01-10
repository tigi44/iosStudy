//
//  SampleView.m
//  iosStudy
//
//  Created by tigi on 2018. 1. 10..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "SampleView.h"

@implementation SampleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"initWithFrame");
        // sample view 백그라운드 컬러 지정
        [self setBackgroundColor:[UIColor darkGrayColor]];
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    NSLog(@"layoutSubviews");
}


// 해당 뷰의 sizeToFits 호출시 실행 되는 부분
- (CGSize)sizeThatFits:(CGSize)size
{
    NSLog(@"sizeThatFits : %@", NSStringFromCGSize(size));
    return CGSizeMake(200, 200);
}


@end
