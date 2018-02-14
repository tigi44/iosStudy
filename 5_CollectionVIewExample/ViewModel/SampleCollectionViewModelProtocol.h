//
//  SampleCollectionViewModelProtocol.h
//  5_CollectionVIewExample
//
//  Created by tigi on 2018. 2. 14..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SampleCollectionViewModelProtocol <NSObject>

+ (Class)collectionViewCellClass;

- (CGSize)collectionView:(UICollectionView *)aCollectionView layout:(UICollectionViewLayout*)aCollectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)aIndexPath;

- (UICollectionViewCell *)collectionView:(UICollectionView *)aCollectionView cellForItemAtIndexPath:(NSIndexPath *)aIndexPath;

@end
