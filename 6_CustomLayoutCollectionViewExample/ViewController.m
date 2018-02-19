//
//  ViewController.m
//  6_CustomLayoutCollectionViewExample
//
//  Created by tigi on 2018. 2. 14..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "ViewController.h"
#import "ISDebugLog.h"
#import "SampleCollectionViewModel.h"
#import "SampleSubCollectionViewModel.h"
#import "DSCircularLayoutCustom.h"

#define DID_SEL_TO_DELETE 1

static NSArray *gMockupData = nil;

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, readwrite) UICollectionView *collectionView;
@property(nonatomic, readwrite) NSArray *viewModels;
@property(nonatomic, readwrite) NSArray<id<SampleCollectionViewModelProtocol>> *firstSectionViewModels;
@property(nonatomic, readwrite) NSArray<id<SampleCollectionViewModelProtocol>> *secondSectionViewModels;

@end

@implementation ViewController

+ (void)initialize
{
    [super initialize];
    ISDebugLog();
    
    gMockupData = @[
                    [[SampleMainVO alloc] initWithName:@"지수" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F133%2F201706191754547821.jpg"],
                    [[SampleSubVO alloc] initWithTitle:@"" value:@"1995. 01. 03"],
                    
                    [[SampleMainVO alloc] initWithName:@"제니" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F15%2F201706191752248631.jpg"],
                    [[SampleSubVO alloc] initWithTitle:@"" value:@"1996. 01. 16"],
                    
                    
                    [[SampleMainVO alloc] initWithName:@"로제" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F119%2F201706191755398991.jpg"],
                    [[SampleSubVO alloc] initWithTitle:@"" value:@"1997. 02. 11"],
                    
                    [[SampleMainVO alloc] initWithName:@"리사" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F120%2F201706191756263751.jpg"],
                    [[SampleSubVO alloc] initWithTitle:@"" value:@"1997. 03. 27"]
                    
                    ,
                    
                    [[SampleMainVO alloc] initWithName:@"지수" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F133%2F201706191754547821.jpg"],
                    [[SampleSubVO alloc] initWithTitle:@"" value:@"1995. 01. 03"],
                    
                    [[SampleMainVO alloc] initWithName:@"제니" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F15%2F201706191752248631.jpg"],
                    [[SampleSubVO alloc] initWithTitle:@"" value:@"1996. 01. 16"],
                    
                    [[SampleMainVO alloc] initWithName:@"로제" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F119%2F201706191755398991.jpg"],
                    [[SampleSubVO alloc] initWithTitle:@"" value:@"1997. 02. 11"],
                    
                    [[SampleMainVO alloc] initWithName:@"리사" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F120%2F201706191756263751.jpg"],
                    [[SampleSubVO alloc] initWithTitle:@"" value:@"1997. 03. 27"]
                    
                    ,
                    
                    [[SampleMainVO alloc] initWithName:@"지수" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F133%2F201706191754547821.jpg"],
                    [[SampleSubVO alloc] initWithTitle:@"" value:@"1995. 01. 03"],
                    
                    [[SampleMainVO alloc] initWithName:@"제니" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F15%2F201706191752248631.jpg"],
                    [[SampleSubVO alloc] initWithTitle:@"" value:@"1996. 01. 16"],
                    
                    [[SampleMainVO alloc] initWithName:@"로제" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F119%2F201706191755398991.jpg"],
                    [[SampleSubVO alloc] initWithTitle:@"" value:@"1997. 02. 11"],
                    
                    [[SampleMainVO alloc] initWithName:@"리사" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F120%2F201706191756263751.jpg"],
                    [[SampleSubVO alloc] initWithTitle:@"" value:@"1997. 03. 27"]
                    
                    ,
                    
                    [[SampleMainVO alloc] initWithName:@"지수" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F133%2F201706191754547821.jpg"],
                    [[SampleSubVO alloc] initWithTitle:@"" value:@"1995. 01. 03"],
                    
                    [[SampleMainVO alloc] initWithName:@"제니" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F15%2F201706191752248631.jpg"],
                    [[SampleSubVO alloc] initWithTitle:@"" value:@"1996. 01. 16"],
                    
                    [[SampleMainVO alloc] initWithName:@"로제" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F119%2F201706191755398991.jpg"],
                    [[SampleSubVO alloc] initWithTitle:@"" value:@"1997. 02. 11"],
                    
                    [[SampleMainVO alloc] initWithName:@"리사" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F120%2F201706191756263751.jpg"],
                    [[SampleSubVO alloc] initWithTitle:@"" value:@"1997. 03. 27"]
                    ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ISDebugLog();
    
    DSCircularLayoutCustom *circularLayout = [[DSCircularLayoutCustom alloc] init];
    CGFloat sItemSize = 50.f;
    [circularLayout initWithCentre:CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height/2)
                            radius:[[UIScreen mainScreen] bounds].size.width/3
                          itemSize:CGSizeMake(sItemSize, sItemSize)
                 andAngularSpacing:sItemSize * 1.85f];
    [circularLayout setStartAngle:M_PI endAngle:0];
    circularLayout.mirrorX = NO;
    circularLayout.mirrorY = NO;
    circularLayout.rotateItems = YES;
    circularLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    [self setCollectionView:[[UICollectionView alloc] initWithFrame:[[self view] frame] collectionViewLayout:circularLayout]];
    
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];

    [[self view] addSubview:_collectionView];
    
    [self reloadCollectionView:_collectionView addViewModels:[self convertMockData:[SampleMainVO class]] secondSectionViewModels:[self convertMockData:[SampleSubVO class]]];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [_viewModels count];
}

-(NSInteger)collectionView:(UICollectionView *)aCollectionView numberOfItemsInSection:(NSInteger)aSection
{
    return [_viewModels[aSection] count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)aCollectionView cellForItemAtIndexPath:(NSIndexPath *)aIndexPath
{
    ISDebugLog(@"indexPath : %@", aIndexPath);
    
    NSArray *sViewModels = _viewModels[[aIndexPath section]];
    id<SampleCollectionViewModelProtocol> sViewModel = [sViewModels objectAtIndex:[aIndexPath row]];
    if ([sViewModel conformsToProtocol:@protocol(SampleCollectionViewModelProtocol)] &&
        [sViewModel respondsToSelector:@selector(collectionView:cellForItemAtIndexPath:)])
    {
        return [sViewModel collectionView:aCollectionView cellForItemAtIndexPath:aIndexPath];
    }
    return nil;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)aCollectionView didSelectItemAtIndexPath:(NSIndexPath *)aIndexPath
{
    ISDebugLog(@"indexPath : %@", aIndexPath);
    
#if DID_SEL_TO_DELETE
    UICollectionViewCell *sSelectedCell = [_collectionView cellForItemAtIndexPath:aIndexPath];
    [sSelectedCell setSelected:NO];
    
    [self deleteTwoViewModelAtRow:[aIndexPath row]];
    [_collectionView performBatchUpdates:^{
        [_collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:[aIndexPath row] inSection:0],
                                                   [NSIndexPath indexPathForRow:[aIndexPath row] inSection:1]]];
    } completion:nil];
#else
    NSIndexPath *sUpSectionIndexPath = [NSIndexPath indexPathForRow:[aIndexPath row] inSection:1];
    [_collectionView reloadItemsAtIndexPaths:@[sUpSectionIndexPath]];
#endif
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)aCollectionView layout:(UICollectionViewLayout *)aCollectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)aIndexPath
{
    ISDebugLog(@"indexPath : %@", aIndexPath);
    
    NSArray *sViewModels = _viewModels[[aIndexPath section]];
    id<SampleCollectionViewModelProtocol> sViewModel = [sViewModels objectAtIndex:[aIndexPath row]];
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
- (NSArray<id<SampleCollectionViewModelProtocol>> *)convertMockData:(Class)aClass
{
    NSMutableArray<id<SampleCollectionViewModelProtocol>> *sViewModels = [NSMutableArray array];
    
    for (id data in gMockupData)
    {
        if ([aClass isSubclassOfClass:[SampleMainVO class]] &&
            [data isKindOfClass:[SampleMainVO class]])
        {
            SampleCollectionViewModel *viewModel = [[SampleCollectionViewModel alloc] initWithData:data];
            [sViewModels addObject:viewModel];
        }
        else if ([aClass isSubclassOfClass:[SampleSubVO class]] &&
                 [data isKindOfClass:[SampleSubVO class]])
        {
            SampleSubCollectionViewModel *viewModel = [[SampleSubCollectionViewModel alloc] initWithData:data];
            [sViewModels addObject:viewModel];
        }
    }
    return [sViewModels copy];
}

/**
 reload and add view model to the collection view
 */
- (void)reloadCollectionView:(UICollectionView *)aCollectionView addViewModels:(NSArray<id<SampleCollectionViewModelProtocol>> *)aViewModels secondSectionViewModels:(NSArray<id<SampleCollectionViewModelProtocol>> *)aSecondViewModels
{
    // set
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
    if (!_firstSectionViewModels)
    {
        [self setFirstSectionViewModels:[NSArray array]];
    }
    [self setFirstSectionViewModels:[_firstSectionViewModels arrayByAddingObjectsFromArray:sViewModelProtocols]];
    
    // set
    sViewModelProtocols = [NSMutableArray array];
    for (id<SampleCollectionViewModelProtocol> viewModel in aSecondViewModels)
    {
        if ([viewModel conformsToProtocol:@protocol(SampleCollectionViewModelProtocol)])
        {
            Class sCollectionViewModelClass = [[viewModel class] collectionViewCellClass];
            [aCollectionView registerClass:sCollectionViewModelClass forCellWithReuseIdentifier:NSStringFromClass(sCollectionViewModelClass)];
            [sViewModelProtocols addObject:viewModel];
        }
    }
    if (!_secondSectionViewModels)
    {
        [self setSecondSectionViewModels:[NSArray array]];
    }
    [self setSecondSectionViewModels:[_secondSectionViewModels arrayByAddingObjectsFromArray:sViewModelProtocols]];
    
    // set
    [self setViewModels:@[_firstSectionViewModels, _secondSectionViewModels]];
    
    [aCollectionView reloadData];
}


/**
 delete view model
 */
- (void)deleteTwoViewModelAtRow:(NSInteger)aRow;
{
    NSMutableArray *sMutableFirstViewModels = [_firstSectionViewModels mutableCopy];
    NSMutableArray *sMutableSecondSectionViewModels = [_secondSectionViewModels mutableCopy];
    [sMutableFirstViewModels removeObjectAtIndex:aRow];
    [sMutableSecondSectionViewModels removeObjectAtIndex:aRow];
    [self setFirstSectionViewModels:[sMutableFirstViewModels copy]];
    [self setSecondSectionViewModels:[sMutableSecondSectionViewModels copy]];
    
    [self setViewModels:@[_firstSectionViewModels, _secondSectionViewModels]];
}
@end
