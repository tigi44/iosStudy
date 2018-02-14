//
//  ViewController.m
//  4_MultiCellTableViewExample
//
//  Created by tigi on 2018. 2. 13..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "ViewController.h"
#import "SampleMainViewModel.h"
#import "SampleSubViewModel.h"
#import "ISDebugLog.h"

static NSArray *gMockupData = nil;

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, readwrite) UITableView *tableView;
@property(nonatomic, readwrite) NSArray<id<SampleViewModelProtocol>> *viewModels;

@end

@implementation ViewController

+ (void)initialize
{
    [super initialize];
    ISDebugLog();
    
    gMockupData = @[
                    [[SampleMainVO alloc] initWithName:@"지수" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F133%2F201706191754547821.jpg"],
                    [[SampleSubVO alloc] initWithTitle:@"birthday" value:@"1995. 01. 03"],
                    
                    [[SampleMainVO alloc] initWithName:@"제니" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F15%2F201706191752248631.jpg"],
                    [[SampleSubVO alloc] initWithTitle:@"birthday" value:@"1996. 01. 16"],
                    
                    
                    [[SampleMainVO alloc] initWithName:@"로제" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F119%2F201706191755398991.jpg"],
                    [[SampleSubVO alloc] initWithTitle:@"birthday" value:@"1997. 02. 11"],
                    
                    [[SampleMainVO alloc] initWithName:@"리사" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F120%2F201706191756263751.jpg"],
                    [[SampleSubVO alloc] initWithTitle:@"birthday" value:@"1997. 03. 27"],
                    [[SampleSubVO alloc] initWithTitle:@"company" value:@"YG"]
                    
                    ,
                    
                    [[SampleMainVO alloc] initWithName:@"지수" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F133%2F201706191754547821.jpg"],
                    [[SampleSubVO alloc] initWithTitle:@"birthday" value:@"1995. 01. 03"],
                    
                    [[SampleMainVO alloc] initWithName:@"제니" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F15%2F201706191752248631.jpg"],
                    [[SampleSubVO alloc] initWithTitle:@"birthday" value:@"1996. 01. 16"],
                    
                    [[SampleMainVO alloc] initWithName:@"로제" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F119%2F201706191755398991.jpg"],
                    [[SampleSubVO alloc] initWithTitle:@"birthday" value:@"1997. 02. 11"],
                    
                    [[SampleMainVO alloc] initWithName:@"리사" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F120%2F201706191756263751.jpg"],
                    [[SampleSubVO alloc] initWithTitle:@"birthday" value:@"1997. 03. 27"],
                    [[SampleSubVO alloc] initWithTitle:@"company" value:@"YG"]
                    ];
}

- (void)loadView
{
    ISDebugLog();

    // set table view
    [self setTableView:[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain]];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [self setView:_tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ISDebugLog();
    
    // add view models to the table view
    [self reloadTableView:_tableView addViewModels:[self mockDatasConvertToViewModels]];
}

#pragma mark - Implements UITableViewDataSource Methods.

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)aSection
{
    return [_viewModels count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)aIndexPath
{
    ISDebugLog(@"row : %ld", (long)[aIndexPath row]);
    
    id<SampleViewModelProtocol> viewModel = [_viewModels objectAtIndex:[aIndexPath row]];
    UITableViewCell *sTabelViewCell = [_tableView dequeueReusableCellWithIdentifier:NSStringFromClass([[viewModel class] tableViewCellClass])];
    [viewModel generateTableViewCell:sTabelViewCell];
    
    //[sTabelViewCell setNeedsLayout];
    [sTabelViewCell layoutIfNeeded];
    
    return sTabelViewCell;
}

#pragma mark - Implements UITableViewDelegate Methods.

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)aIndexPath
{
    id<SampleViewModelProtocol> viewModel = [_viewModels objectAtIndex:[aIndexPath row]];
    return [viewModel heightForRow];
}

- (void)tableView:(UITableView *)aTableView willDisplayCell:(UITableViewCell *)aCell forRowAtIndexPath:(NSIndexPath *)aIndexPath
{
    ISDebugLog(@"row : %ld", (long)[aIndexPath row]);
}

- (void)tableView:(UITableView *)aTableView didEndDisplayingCell:(UITableViewCell *)aCell forRowAtIndexPath:(NSIndexPath *)aIndexPath
{
    ISDebugLog(@"row : %ld", (long)[aIndexPath row]);
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)aIndexPath
{
    ISDebugLog(@"row : %ld", (long)[aIndexPath row]);
    
    id<SampleViewModelProtocol> viewModel = [_viewModels objectAtIndex:[aIndexPath row]];
    if ([viewModel respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)])
    {
        [viewModel tableView:aTableView didSelectRowAtIndexPath:aIndexPath];
    }
}

#pragma mark - Implements UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float scrollViewHeight = scrollView.frame.size.height;
    float scrollContentSizeHeight = scrollView.contentSize.height;
    float scrollOffset = scrollView.contentOffset.y;
    
    if (scrollOffset == 0)
    {
        // top
    }
    else if (scrollOffset + scrollViewHeight == scrollContentSizeHeight)
    {
        // bottom
        ISDebugLog();
        [self reloadTableView:_tableView addViewModels:[self mockDatasConvertToViewModels]];
    }
}

#pragma mark -

/**
 data converts to view model
 */
- (NSArray<id<SampleViewModelProtocol>> *)mockDatasConvertToViewModels
{
    NSMutableArray<id<SampleViewModelProtocol>> *sViewModels = [NSMutableArray array];
    for (id data in gMockupData)
    {
        if ([data isKindOfClass:[SampleMainVO class]])
        {
            SampleMainViewModel *viewModel = [[SampleMainViewModel alloc] initWithData:data];
            [sViewModels addObject:viewModel];
        }
        else if ([data isKindOfClass:[SampleSubVO class]])
        {
            SampleSubViewModel *viewModel = [[SampleSubViewModel alloc] initWithData:data];
            [sViewModels addObject:viewModel];
        }
        else
        {
            
        }
    }
    return [sViewModels copy];
}

/**
 reload and add view model to the table view
 */
- (void)reloadTableView:(UITableView *)aTableView addViewModels:(NSArray<id<SampleViewModelProtocol>> *)aViewModels
{
    NSMutableArray *viewModelProtocols = [NSMutableArray array];
    for (id<SampleViewModelProtocol> viewModel in aViewModels)
    {
        if ([viewModel conformsToProtocol:@protocol(SampleViewModelProtocol)])
        {
            Class sTableViewModelClass = [[viewModel class] tableViewCellClass];
            id sTabelViewCell = [aTableView dequeueReusableCellWithIdentifier:NSStringFromClass(sTableViewModelClass)];
            if (!sTabelViewCell) {
                [aTableView registerClass:sTableViewModelClass forCellReuseIdentifier:NSStringFromClass(sTableViewModelClass)];
            }
            [viewModelProtocols addObject:viewModel];
        }
    }
    if (!_viewModels)
    {
        _viewModels = [NSArray array];
    }
    _viewModels = [_viewModels arrayByAddingObjectsFromArray:viewModelProtocols];
    [aTableView reloadData];
}


@end
