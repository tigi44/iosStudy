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
#import "SampleTableViewCell.h"

static NSArray *gMockupData = nil;
static NSArray *gCellColor = nil;

@interface TestTouchViewController () <TestProtocol, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, readonly) TestTouchView *touchView;
@property (nonatomic, readwrite) UITableView *tableView;

@end

@implementation TestTouchViewController

- (TestTouchView *)touchView
{
    NSAssert([[self view] isKindOfClass:[TestTouchView class]], @"unexpected type");
    return (TestTouchView *)[self view];
}

- (void)loadView
{
    // TestProtocol EX.
//    TestTouchView *sTouchView = [[TestTouchView alloc] initWithFrame:CGRectZero];
//    [sTouchView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
//    [self setView:sTouchView];

    [self setTableView:[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped]];
    [_tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [_tableView registerClass:[SampleTableViewCell class] forCellReuseIdentifier:NSStringFromClass([SampleTableViewCell class])];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [self setView:_tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"TestTouchViewController - viewWillAppear");
    // TestProtocol EX.
//    [[self touchView] setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"TestTouchViewController - viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"TestTouchViewController - viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"TestTouchViewController - viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"TestTouchViewController - viewDidDisappear");
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    NSLog(@"TestTouchViewController - viewWillLayoutSubviews");
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    NSLog(@"TestTouchViewController - viewDidLayoutSubviews");
}

- (void) didTap
{
    NSLog(@"%@", @"didTap protocol");
}

#pragma mark - Implements UITableViewDataSource Methods.

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)aSection
{
    NSLog(@"%@", @"numberOfRowsInSection");
    return [gMockupData count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)aIndexPath
{
    NSLog(@"%@", @"cellForRowAtIndexPath");
    NSInteger sIndex = [aIndexPath row];
    NSInteger sSection = [aIndexPath section];
    SampleTableViewCell *sTableViewCell = (SampleTableViewCell *)[aTableView dequeueReusableCellWithIdentifier:NSStringFromClass([SampleTableViewCell class])];
    
    NSAssert(sTableViewCell != nil, @"unexpected condition");
    NSAssert(sIndex < [gMockupData count], @"unexpected condition");
    
    [sTableViewCell setBackgroundColor:gCellColor[sSection]];
    [[sTableViewCell textLabel] setText:gMockupData[sIndex]];
    [sTableViewCell setNeedsLayout];
    //[sTableViewCell layoutIfNeeded];
    
    return sTableViewCell;
}

#pragma mark - Implements UITableViewDelegate Methods.

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)aIndexPath
{
    return 80.0f;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)aIndexPath
{
    
}

+ (void)initialize
{
    [super initialize];
    gMockupData = @[@"1", @"2", @"3"];
    gCellColor = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
}


@end
