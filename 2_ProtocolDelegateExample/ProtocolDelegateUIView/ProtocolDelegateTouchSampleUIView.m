//
//  ProtocolDelegateTouchSampleUIView.m
//  ProtocolDelegateExample
//
//  Created by tigi on 2018. 2. 9..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "ProtocolDelegateTouchSampleUIView.h"

@interface ProtocolDelegateTouchSampleUIView()

@property (nonatomic, readwrite) UILabel *descriptionLabel;

@end

@implementation ProtocolDelegateTouchSampleUIView

- (instancetype)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    if (self) {
        ISDebugLog();
        [self setBackgroundColor:[UIColor lightGrayColor]];
        
        // init the label
        _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_descriptionLabel setNumberOfLines:1];
        [_descriptionLabel setFont:[UIFont boldSystemFontOfSize:24.0f]];
        [_descriptionLabel setTextColor:[UIColor whiteColor]];
        [_descriptionLabel setText:@"TAP DELEGATE TEST!!"];
        [self addSubview:_descriptionLabel];
        
        [self setupGesture];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    ISDebugLog();
    
    // set the label layout
    [_descriptionLabel sizeToFit];
    CGRect sDescriptionLabelFrame = [_descriptionLabel frame];
    sDescriptionLabelFrame.origin.x = (NSInteger)(([[_descriptionLabel superview] frame].size.width - sDescriptionLabelFrame.size.width) / 2);      // MoveToHorizontalCenter
    sDescriptionLabelFrame.origin.y = (NSInteger)(([[_descriptionLabel superview] frame].size.height - sDescriptionLabelFrame.size.height) / 2);    // MoveToVerticalCenter
    [_descriptionLabel setFrame:sDescriptionLabelFrame];
}

- (void)setupGesture
{
    UITapGestureRecognizer *sTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    [self addGestureRecognizer:sTapGestureRecognizer];
}

// user the protocol delegate
- (void) didTap
{
    ISDebugLog();
    
    // check the protocol and selector (protect against app crash)
    if ([_delegate conformsToProtocol:@protocol(TouchSampleProtocol)] &&
        [_delegate respondsToSelector:@selector(didTap)])
    {
        [_delegate didTap];
    }
}
@end
