//
//  SampleSubCollectionViewModel.m
//  5_CollectionVIewExample
//
//  Created by tigi on 2018. 2. 14..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "SampleSubCollectionViewModel.h"

@interface SampleSubCollectionViewModel()

@property (nonatomic, readwrite) SampleSubVO *data;

@end

@implementation SampleSubCollectionViewModel

-(instancetype)initWithData:(SampleSubVO *)aData
{
    self = [super init];
    if (self) {
        _data = aData;
    }
    return self;
}

+ (Class)collectionViewCellClass {
    return [SampleSubCollectionViewCell class];
}

#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)aCollectionView cellForItemAtIndexPath:(NSIndexPath *)aIndexPath
{
    SampleSubCollectionViewCell *sUICollectionViewCell = (SampleSubCollectionViewCell *)[aCollectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([[self class] collectionViewCellClass]) forIndexPath:aIndexPath];
    
    [[sUICollectionViewCell titleLabel] setText:[_data title]];
    [[sUICollectionViewCell valueLabel] setText:[_data value]];
    
    [sUICollectionViewCell setNeedsLayout];
    
    return sUICollectionViewCell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)aCollectionView layout:(UICollectionViewLayout *)aCollectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)aIndexPath {
    return CGSizeMake([aCollectionView bounds].size.width, 300.0f);
}


@end
