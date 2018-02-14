//
//  SampleCollectionViewModel.m
//  5_CollectionVIewExample
//
//  Created by tigi on 2018. 2. 14..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "SampleCollectionViewModel.h"

@interface SampleCollectionViewModel()

@property (nonatomic, readwrite) SampleMainVO *data;

@end

@implementation SampleCollectionViewModel

- (instancetype)initWithData:(SampleMainVO *)aData
{
    self = [super init];
    if (self) {
        _data = aData;
    }
    return self;
}

+ (Class)collectionViewCellClass {
    return [SampleCollectionViewCell class];
}

#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)aCollectionView cellForItemAtIndexPath:(NSIndexPath *)aIndexPath
{
    SampleCollectionViewCell *sUICollectionViewCell = (SampleCollectionViewCell *)[aCollectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([[self class] collectionViewCellClass]) forIndexPath:aIndexPath];
    
    [self requestURL:[_data memberProfileThumbnailURL] completion:^(UIImage *aImage) {
        [[sUICollectionViewCell imageView] setImage:aImage];
    }];
    
    return sUICollectionViewCell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)aCollectionView layout:(UICollectionViewLayout *)aCollectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)aIndexPath {
    return CGSizeMake([aCollectionView bounds].size.width, 300.0f);
}

#pragma mark - Utils

- (void)requestURL:(NSString *)aURL completion:(void(^)(UIImage *))aCompletion
{
    dispatch_queue_t q_global   = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main     = dispatch_get_main_queue();
    
    dispatch_async(q_global, ^{
        NSString *sImageURL = aURL;
        UIImage *sImage = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: sImageURL]]];
        
        
        dispatch_async(q_main, ^{
            if (aCompletion != nil)
            {
                aCompletion(sImage);
            }
        });
    });
}



@end
