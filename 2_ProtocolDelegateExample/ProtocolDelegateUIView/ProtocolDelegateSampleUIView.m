//
//  ProtocolDelegateSampleUIView.m
//  ProtocolDelegateExample
//
//  Created by tigi on 2018. 1. 26..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "ProtocolDelegateSampleUIView.h"

@interface ProtocolDelegateSampleUIView()

@property (nonatomic, readwrite) UIButton *button;

@end

@implementation ProtocolDelegateSampleUIView

- (instancetype)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    if (self) {
        ISDebugLog();
        
        // init the button
        [self setButton:[UIButton buttonWithType:(UIButtonTypeContactAdd)]];
        [self addSubview:_button];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    ISDebugLog();
    
    // label of super view
    UILabel *sLabel = [super descriptionLabel];
    CGRect sDescriptionLabelFrame = [sLabel frame];
    
    // set the button layout
    CGRect sButtonFrame = [_button frame];
    sButtonFrame.origin.x = (NSInteger)(([[_button superview] frame].size.width - sButtonFrame.size.width) / 2);    // MoveToHorizontalCenter
    sButtonFrame.origin.y = sDescriptionLabelFrame.origin.y + sDescriptionLabelFrame.size.height + 10.0f;           // MoveToBottomOf 'DescriptionLabel'
    [_button setFrame:sButtonFrame];
}
@end
