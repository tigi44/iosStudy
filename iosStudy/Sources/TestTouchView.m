//
//  TestTouchView.m
//  iosStudy
//
//  Created by tigi on 2018. 1. 11..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "TestTouchView.h"

@implementation TestTouchView

- (instancetype)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    if (self) {
        [self setBackgroundColor:[UIColor lightGrayColor]];
        [self setupGesture];
    }
    
    return self;
}

- (void)setupGesture
{
    UITapGestureRecognizer *sTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    [self addGestureRecognizer:sTapGestureRecognizer];
}

- (void) didTap
{
    NSLog(@"%@", @"didTap tapGesture");
    if ([_delegate conformsToProtocol:@protocol(TestProtocol)] &&
        [_delegate respondsToSelector:@selector(didTap)])
    {
        [_delegate didTap];
    }
}

@end
