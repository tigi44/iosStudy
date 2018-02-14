//
//  ProtocolDelegateViewController.m
//  ProtocolDelegateExample
//
//  Created by tigi on 2018. 2. 9..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "ProtocolDelegateViewController.h"
#import "ProtocolDelegateTouchSampleUIView.h"

@interface ProtocolDelegateViewController () <TouchSampleProtocol>

@property (nonatomic, readonly) ProtocolDelegateTouchSampleUIView *touchSampleView;

@end

@implementation ProtocolDelegateViewController

- (ProtocolDelegateTouchSampleUIView *)touchSampleView
{
    NSAssert([[self view] isKindOfClass:[ProtocolDelegateTouchSampleUIView class]], @"unexpected type");
    return (ProtocolDelegateTouchSampleUIView *)[self view];
}

- (void)loadView
{
    ISDebugLog();

    ProtocolDelegateTouchSampleUIView *sTouchSampleView = [[ProtocolDelegateTouchSampleUIView alloc] initWithFrame:CGRectZero];
    [sTouchSampleView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self setView:sTouchSampleView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    ISDebugLog();
    
    // 2. for testing delegate pattern
    // set delegate on the touchSampleView (use getter when get 'touchSampleView' for casting)
    [[self touchSampleView] setDelegate:self];
}

- (void) didTap
{
    ISDebugLog(@"%@", @"didTap delegate")
}

@end
