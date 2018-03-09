//
//  ViewController.m
//  7_isEqual&NSCopying
//
//  Created by tigi on 2018. 3. 8..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "ViewController.h"
#import "ISDebugLog.h"
#import "SampleCollectionViewModel.h"
#import "SampleSubCollectionViewModel.h"
#import "DSCircularLayoutCustom.h"
#import "SampleMainVO+isEqual.h"
#import "SampleMainVO+copy.h"

static NSArray *gMockupData = nil;

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, readwrite) UICollectionView *collectionView;
@property(nonatomic, readwrite) NSArray *viewModels;
@property(nonatomic, readwrite) NSArray<id<SampleCollectionViewModelProtocol>> *firstSectionViewModels;

@property(nonatomic, readwrite)UIButton *equalButton;
@property(nonatomic, readwrite)UIButton *copyaddButton;

@end

@implementation ViewController {
    SampleMainVO *_selectedVOFirst;
    SampleMainVO *_selectedVOSecond;
    NSIndexPath *_selectedIndexPathFirst;
    NSIndexPath *_selectedIndexPathSecond;
}

+ (void)initialize
{
    [super initialize];
    ISDebugLog();
    
    gMockupData = @[
                    [[SampleMainVO alloc] initWithName:@"지수" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F133%2F201706191754547821.jpg"],
                    
                    [[SampleMainVO alloc] initWithName:@"제니" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F15%2F201706191752248631.jpg"],
                    
                    
                    [[SampleMainVO alloc] initWithName:@"로제" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F119%2F201706191755398991.jpg"],
                    
                    [[SampleMainVO alloc] initWithName:@"리사" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F120%2F201706191756263751.jpg"]
                    
                    ,
                    
                    [[SampleMainVO alloc] initWithName:@"지수" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F133%2F201706191754547821.jpg"],
                    
                    [[SampleMainVO alloc] initWithName:@"제니" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F15%2F201706191752248631.jpg"],
                    
                    [[SampleMainVO alloc] initWithName:@"로제" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F119%2F201706191755398991.jpg"],
                    
                    [[SampleMainVO alloc] initWithName:@"리사" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F120%2F201706191756263751.jpg"]
                    
                    ,
                    
                    [[SampleMainVO alloc] initWithName:@"지수" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F133%2F201706191754547821.jpg"],
                    
                    [[SampleMainVO alloc] initWithName:@"제니" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F15%2F201706191752248631.jpg"],
                    
                    [[SampleMainVO alloc] initWithName:@"로제" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F119%2F201706191755398991.jpg"],
                    
                    [[SampleMainVO alloc] initWithName:@"리사" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F120%2F201706191756263751.jpg"]
                    
                    ,
                    
                    [[SampleMainVO alloc] initWithName:@"지수" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F133%2F201706191754547821.jpg"],
                    
                    [[SampleMainVO alloc] initWithName:@"제니" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F15%2F201706191752248631.jpg"],
                    
                    [[SampleMainVO alloc] initWithName:@"로제" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F119%2F201706191755398991.jpg"],
                    
                    [[SampleMainVO alloc] initWithName:@"리사" thumbnailURL:@"https://search.pstatic.net/common?type=a&size=120x150&quality=95&direct=true&src=http%3A%2F%2Fsstatic.naver.net%2Fpeople%2F120%2F201706191756263751.jpg"]
                    ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ISDebugLog();
    
    [self setCollectionView:[[UICollectionView alloc] initWithFrame:[[self view] frame] collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]]];
    
    UICollectionViewFlowLayout *sLayout = (UICollectionViewFlowLayout *)[_collectionView collectionViewLayout];
    [sLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [sLayout setFooterReferenceSize:CGSizeZero];
    [sLayout setHeaderReferenceSize:CGSizeZero];
    [sLayout setMinimumLineSpacing:0.0f];
    [sLayout setMinimumInteritemSpacing:0.0f];
    [sLayout setItemSize:CGSizeMake(70.f, 70.f)];
    
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    
    [[self view] addSubview:_collectionView];
    
    // add button for checking equal
    _equalButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_equalButton setFrame:CGRectMake([[self view] frame].size.width / 2 - 75, [[self view] frame].size.height / 2 - 25, 150, 50)];
    [_equalButton setBackgroundColor:[UIColor darkGrayColor]];
    [_equalButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_equalButton setTitle:@"is Equal model?" forState:UIControlStateNormal];
    [_equalButton addTarget:self action:@selector(checkEqual:) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:_equalButton];
    
    // add button for copying model and adding to view
    _copyaddButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_copyaddButton setFrame:CGRectMake([[self view] frame].size.width / 2 - 75, [[self view] frame].size.height / 2 + 30, 150, 50)];
    [_copyaddButton setBackgroundColor:[UIColor darkGrayColor]];
    [_copyaddButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_copyaddButton setTitle:@"copy & add" forState:UIControlStateNormal];
    [_copyaddButton addTarget:self action:@selector(copyAndAdd:) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:_copyaddButton];
    
    [self reloadCollectionView:_collectionView addViewModels:[self convertMockData:[SampleMainVO class]]];
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
    
    SampleCollectionViewCell *sSelectedCell = (SampleCollectionViewCell *)[_collectionView cellForItemAtIndexPath:aIndexPath];
    [[sSelectedCell imageView] setBackgroundColor:[UIColor redColor]];
    SampleMainVO *sSelectedVO = gMockupData[[aIndexPath row]];
    
    if ([aIndexPath isEqual:_selectedIndexPathFirst]) {
        [_collectionView reloadItemsAtIndexPaths:@[aIndexPath]];
        _selectedVOFirst = nil;
        _selectedIndexPathFirst = nil;
    } else if ([aIndexPath isEqual:_selectedIndexPathSecond]) {
         [_collectionView reloadItemsAtIndexPaths:@[aIndexPath]];
        _selectedVOSecond = nil;
        _selectedIndexPathSecond = nil;
    } else {
        if (!_selectedIndexPathFirst) {
            _selectedVOFirst = sSelectedVO;
            _selectedIndexPathFirst = aIndexPath;
        } else if (!_selectedIndexPathSecond) {
            _selectedVOSecond = sSelectedVO;
            _selectedIndexPathSecond = aIndexPath;
        } else {
            [_collectionView reloadItemsAtIndexPaths:@[_selectedIndexPathFirst]];
            _selectedVOFirst = _selectedVOSecond;
            _selectedIndexPathFirst = _selectedIndexPathSecond;
            _selectedVOSecond = sSelectedVO;
            _selectedIndexPathSecond = aIndexPath;
        }
    }
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
- (void)reloadCollectionView:(UICollectionView *)aCollectionView addViewModels:(NSArray<id<SampleCollectionViewModelProtocol>> *)aViewModels
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
    [self setViewModels:@[_firstSectionViewModels]];
    
    [aCollectionView reloadData];
}

#pragma mark -

/**
 Test isEqual Method of 'SampleMainVO' object
 */
- (void)checkEqual:(UIButton*)sender {
    ISDebugLog(@"%@, %@", _selectedVOFirst, _selectedVOSecond);
    NSString *sResultString;
    
    if (!_selectedVOFirst || !_selectedVOSecond) {
        sResultString = @"Have To Select Two Models";
    } else {
        if([_selectedVOFirst isEqual:_selectedVOSecond]) {
            sResultString = @"YES";
        } else {
            sResultString = @"NO";
        }
    }
    
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"isEqual?"
                                message:sResultString
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        [alert dismissViewControllerAnimated:YES completion:nil];
                                        
                                    }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

/**
 Test copy Method of 'SampleMainVO' object
 */
- (void)copyAndAdd:(UIButton*)sender {
    ISDebugLog(@"%@, %@", _selectedVOFirst, _selectedVOSecond);
    NSString *sResultString;
    
    if (_selectedVOFirst && _selectedVOSecond) {
        sResultString = @"Have To Select Only One Model";
    } else if (!_selectedVOFirst && !_selectedVOSecond) {
        sResultString = @"Have To Select Only One Model";
    } else {
        SampleMainVO *sSelectedModel;
        NSIndexPath *sSelectedIndexPath;
        if (_selectedVOFirst) {
            sSelectedModel = _selectedVOFirst;
            sSelectedIndexPath = _selectedIndexPathFirst;
            _selectedVOFirst = nil;
            _selectedIndexPathFirst = nil;
        } else if (_selectedVOSecond) {
            sSelectedModel = _selectedVOSecond;
            sSelectedIndexPath = _selectedIndexPathSecond;
            _selectedVOSecond = nil;
            _selectedIndexPathSecond = nil;
        }
        sResultString = @"Copy & Add";
        
        SampleMainVO *sCopyVO = [sSelectedModel copy];
        gMockupData = [gMockupData arrayByAddingObject:sCopyVO];
        _firstSectionViewModels = nil;
        [self reloadCollectionView:_collectionView addViewModels:[self convertMockData:[SampleMainVO class]]];
    }
    
    
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"Copy & Add"
                                message:sResultString
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        [alert dismissViewControllerAnimated:YES completion:nil];
                                        
                                    }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
