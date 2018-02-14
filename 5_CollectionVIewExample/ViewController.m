//
//  ViewController.m
//  5_CollectionVIewExample
//
//  Created by tigi on 2018. 2. 13..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "ViewController.h"
#import "ISDebugLog.h"
#import "SampleCollectionViewModel.h"
#import "SampleSubCollectionViewModel.h"

static NSArray *gMockupData = nil;

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, readwrite) UICollectionView *collectionView;
@property(nonatomic, readwrite) NSArray<id<SampleCollectionViewModelProtocol>> *viewModels;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    ISDebugLog();
    
    [self setCollectionView:[[UICollectionView alloc] initWithFrame:[[self view] frame] collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]]];
    
    UICollectionViewFlowLayout *sLayout = (UICollectionViewFlowLayout *)[_collectionView collectionViewLayout];
    [sLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [sLayout setFooterReferenceSize:CGSizeZero];
    [sLayout setHeaderReferenceSize:CGSizeZero];
    [sLayout setMinimumLineSpacing:0.0f];
    [sLayout setMinimumInteritemSpacing:0.0f];
    
    [_collectionView setPagingEnabled:YES];
    [_collectionView registerClass:[SampleCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([SampleCollectionViewCell class])];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView setFrame:CGRectMake(0.0, 0.0, [[self view] bounds].size.width, 500.0f)];
    
    [[self view] addSubview:_collectionView];

    [self reloadCollectionView:_collectionView addViewModels:[self mockDatasConvertToViewModels]];
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)aCollectionView numberOfItemsInSection:(NSInteger)aSection
{
    return [_viewModels count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)aCollectionView cellForItemAtIndexPath:(NSIndexPath *)aIndexPath
{
    ISDebugLog(@"row : %ld", (long)[aIndexPath row]);
    
    id<SampleCollectionViewModelProtocol> sViewModel = [_viewModels objectAtIndex:[aIndexPath row]];
    if ([sViewModel conformsToProtocol:@protocol(SampleCollectionViewModelProtocol)] &&
        [sViewModel respondsToSelector:@selector(collectionView:cellForItemAtIndexPath:)])
    {
        return [sViewModel collectionView:aCollectionView cellForItemAtIndexPath:aIndexPath];
    }
    return nil;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)aCollectionView layout:(UICollectionViewLayout *)aCollectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)aIndexPath
{
    ISDebugLog(@"row : %ld", (long)[aIndexPath row]);

    id<SampleCollectionViewModelProtocol> sViewModel = [_viewModels objectAtIndex:[aIndexPath row]];
    if ([sViewModel conformsToProtocol:@protocol(SampleCollectionViewModelProtocol)] &&
        [sViewModel respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)])
    {
        return [sViewModel collectionView:aCollectionView layout:aCollectionViewLayout sizeForItemAtIndexPath:aIndexPath];
    }
    return CGSizeZero;
}

#pragma mark -

/**
 data converts to view model
 */
- (NSArray<id<SampleCollectionViewModelProtocol>> *)mockDatasConvertToViewModels
{
    NSMutableArray<id<SampleCollectionViewModelProtocol>> *sViewModels = [NSMutableArray array];
    for (id data in gMockupData)
    {
        if ([data isKindOfClass:[SampleMainVO class]])
        {
            SampleCollectionViewModel *viewModel = [[SampleCollectionViewModel alloc] initWithData:data];
            [sViewModels addObject:viewModel];
        }
        else if ([data isKindOfClass:[SampleSubVO class]])
        {
            SampleSubCollectionViewModel *viewModel = [[SampleSubCollectionViewModel alloc] initWithData:data];
            [sViewModels addObject:viewModel];
        }
        else
        {
            
        }
    }
    return [sViewModels copy];
}

/**
 reload and add view model to the collection view
 */
- (void)reloadCollectionView:(UICollectionView *)aCollectionView addViewModels:(NSArray<id<SampleCollectionViewModelProtocol>> *)aViewModels
{
    NSMutableArray *sViewModelProtocols = [NSMutableArray array];
    for (id<SampleCollectionViewModelProtocol> viewModel in aViewModels)
    {
        if ([viewModel conformsToProtocol:@protocol(SampleCollectionViewModelProtocol)])
        {
            Class sCollectionViewModelClass = [[viewModel class] collectionViewCellClass];
            [aCollectionView registerClass:sCollectionViewModelClass forCellWithReuseIdentifier:NSStringFromClass(sCollectionViewModelClass)];
            [sViewModelProtocols addObject:viewModel];
        }
    }
    if (!_viewModels)
    {
        _viewModels = [NSArray array];
    }
    _viewModels = [_viewModels arrayByAddingObjectsFromArray:sViewModelProtocols];
    [aCollectionView reloadData];
}
@end
