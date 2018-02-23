//
//  SampleTableViewController.m
//  3_TableViewExample
//
//  Created by tigi on 2018. 2. 13..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "SampleTableViewController.h"
#import "SampleTableViewCell.h"

static NSMutableArray *gMockupData = nil;
static NSArray *gCellColor = nil;

@interface SampleTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, readwrite) UITableView *tableView;
@property (nonatomic, readwrite) UIRefreshControl *refreshControl;

@end

@implementation SampleTableViewController

+ (void)initialize
{
    [super initialize];
    ISDebugLog();
    
    gMockupData = [@[@[@"1_1", @"1_2", @"1_3"], @[@"2_1", @"2_2", @"2_3"], @[@"3_1", @"3_2", @"3_3"]] mutableCopy];
    gCellColor = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
}

- (void)loadView
{
    ISDebugLog();
    
    // set table view
    [self setTableView:[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped]];
    [_tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [_tableView registerClass:[SampleTableViewCell class] forCellReuseIdentifier:NSStringFromClass([SampleTableViewCell class])];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [self setView:_tableView];
    
    // set refresh control for table view
    [self setRefreshControl:[[UIRefreshControl alloc] init]];
    [_refreshControl setAttributedTitle:[[NSAttributedString alloc]initWithString:@"Pull to Refresh"]];
    [_refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged]; // can use 'scrollViewDidEndDecelerating' method to refresh data
    [_tableView setRefreshControl:_refreshControl];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ISDebugLog();
    
    // set edit button for table view
    UINavigationItem *sNavItem = [self navigationItem];
    sNavItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Implements UITableViewDataSource Methods.

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
    return [gMockupData count];
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)aSection
{
    return [gMockupData[aSection] count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)aIndexPath
{
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

// to move row
- (void)tableView:(UITableView *)aTableView moveRowAtIndexPath:(NSIndexPath *)aFromIndexPath toIndexPath:(NSIndexPath *)aToIndexPath {
    
    ISDebugLog(@"from indexpath : %@, to indexpath : %@", aFromIndexPath, aToIndexPath)

    NSString *fromRow = gMockupData[[aFromIndexPath section]][[aFromIndexPath row]];
    
    NSMutableArray *toSectionData = [gMockupData[[aToIndexPath section]] mutableCopy];
    [toSectionData insertObject:fromRow atIndex:[aToIndexPath row]];
    [gMockupData replaceObjectAtIndex:[aToIndexPath section] withObject:toSectionData];
    
    NSMutableArray *fromSectionData = [gMockupData[[aFromIndexPath section]] mutableCopy];
    [fromSectionData removeObjectAtIndex:[aFromIndexPath row]];
    [gMockupData replaceObjectAtIndex:[aFromIndexPath section] withObject:fromSectionData];
    [aTableView reloadData];
}

// to edit
- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)aEditingStyle forRowAtIndexPath:(NSIndexPath *)aIndexPath
{
    if (aEditingStyle == UITableViewCellEditingStyleDelete)
    {
        ISDebugLog(@"delete indexpath : %@", aIndexPath)

        NSMutableArray *sectionData = [gMockupData[[aIndexPath section]] mutableCopy];
        [sectionData removeObjectAtIndex:[aIndexPath row]];
        [gMockupData replaceObjectAtIndex:[aIndexPath section] withObject:sectionData];
        [aTableView reloadData];
    }
}

#pragma mark - Implements UITableViewDelegate Methods.

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)aIndexPath
{
    return 80.0f;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)aIndexPath
{
    ISDebugLog(@"selected indexpath : %@", aIndexPath);
}

#pragma mark - UIViewController (UIViewControllerEditing)

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [_tableView setEditing:editing animated:animated];
}

#pragma mark - methods for refresh control

// refresh view when did scroll (instead of adding target on the UIRefreshControl)
- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView
{
//    if ([_refreshControl isRefreshing]) {
//        ISDebugLog(@"%@", @"refresh table view");
//        [_refreshControl endRefreshing];
//
//        // call a self class method
//        [[self class] initialize];
//
//        [_tableView reloadData];
//    }
}

#pragma mark -

- (void)refreshView: (UIRefreshControl *)aSender
{
    ISDebugLog(@"%@", @"refresh table view");
    [_refreshControl endRefreshing];

    // call a self class method
    [[self class] initialize];

    [_tableView reloadData];
}


@end
