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

static NSMutableArray *gMockupData = nil;
static NSArray *gCellColor = nil;

@interface TestTouchViewController () <TestProtocol, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, readonly) TestTouchView *touchView;
@property (nonatomic, readwrite) UITableView *tableView;
@property (nonatomic, readwrite) UIRefreshControl *refreshControl;

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
    
    [self setRefreshControl:[[UIRefreshControl alloc] init]];
    [_refreshControl setAttributedTitle:[[NSAttributedString alloc]initWithString:@"Pull to Refresh"]];
//    [_refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    [_tableView setRefreshControl:_refreshControl];
    
    [self setView:_tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"TestTouchViewController - viewWillAppear");
    // TestProtocol EX.
//    [[self touchView] setDelegate:self];
    
    UINavigationItem *sNavItem = [self navigationItem];
    sNavItem.rightBarButtonItem = self.editButtonItem;
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

// refresh view when did scroll (instead of adding target on the UIRefreshControl)
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([_refreshControl isRefreshing]) {
        NSLog(@"%@", @"refresh table view");
        [_refreshControl endRefreshing];
        
        // call a self class method
        [[self class] initialize];
        
        [_tableView reloadData];
    }
}

//- (void)refreshView: (UIRefreshControl *)sender
//{
//    NSLog(@"%@", @"refresh table view");
//    [_refreshControl endRefreshing];
//
//    // call a self class method
//    [[self class] initialize];
//
//    [_tableView reloadData];
//}

#pragma mark - Implements UITableViewDataSource Methods.

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [gMockupData count];
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)aSection
{
    NSLog(@"%@", @"numberOfRowsInSection");
    return [gMockupData[aSection] count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)aIndexPath
{
    NSLog(@"%@", @"cellForRowAtIndexPath");
    NSInteger sIndex = [aIndexPath row];
    NSInteger sSection = [aIndexPath section];
    SampleTableViewCell *sTableViewCell = (SampleTableViewCell *)[aTableView dequeueReusableCellWithIdentifier:NSStringFromClass([SampleTableViewCell class])];
    
    NSAssert(sTableViewCell != nil, @"unexpected condition");
    NSAssert(sIndex < [gMockupData[sSection] count], @"unexpected condition");
    
    [sTableViewCell setBackgroundColor:gCellColor[sSection]];
    [[sTableViewCell textLabel] setText:gMockupData[sSection][sIndex]];
    //[sTableViewCell setNeedsLayout];
    //[sTableViewCell layoutIfNeeded];
    
    return sTableViewCell;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [_tableView setEditing:editing animated:animated];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    NSLog(@"%@ - %@ - %@", @"moveRowAtIndexPath", fromIndexPath, toIndexPath);
    NSString *fromRow = gMockupData[[fromIndexPath section]][[fromIndexPath row]];
    
    NSMutableArray *toSectionData = [gMockupData[[toIndexPath section]] mutableCopy];
    [toSectionData insertObject:fromRow atIndex:[toIndexPath row]];
    [gMockupData replaceObjectAtIndex:[toIndexPath section] withObject:toSectionData];
    
    NSMutableArray *fromSectionData = [gMockupData[[fromIndexPath section]] mutableCopy];
    [fromSectionData removeObjectAtIndex:[fromIndexPath row]];
    [gMockupData replaceObjectAtIndex:[fromIndexPath section] withObject:fromSectionData];
    [tableView reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSLog(@"%@ - %@", @"delete commit", indexPath);
        NSMutableArray *sectionData = [gMockupData[[indexPath section]] mutableCopy];
        [sectionData removeObjectAtIndex:[indexPath row]];
        [gMockupData replaceObjectAtIndex:[indexPath section] withObject:sectionData];
        [tableView reloadData];
    }
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
    gMockupData = [@[@[@"1", @"2", @"3"], @[@"11", @"22", @"33"], @[@"111", @"222", @"333"]] mutableCopy];
    gCellColor = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
}


@end
