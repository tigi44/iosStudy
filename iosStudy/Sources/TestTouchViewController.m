//
//  TestTouchViewController.m
//  iosStudy
//
//  Created by tigi on 2018. 1. 11..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "TestTouchViewController.h"
#import "TestProtocol.h"
#import "TestTouchView.h"

@interface TestTouchViewController () <TestProtocol>

@property (nonatomic, readonly) TestTouchView *touchView;

@end

@implementation TestTouchViewController

- (TestTouchView *)touchView
{
    NSAssert([[self view] isKindOfClass:[TestTouchView class]], @"unexpected type");
    return (TestTouchView *)[self view];
}

- (void)loadView
{
    TestTouchView *sTouchView = [[TestTouchView alloc] initWithFrame:CGRectZero];
    [sTouchView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self setView:sTouchView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self touchView] setDelegate:self];
}

- (void) didTap
{
    NSLog(@"%@", @"didTap protocol");
}


@end
