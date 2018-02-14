//
//  SampleCollectionViewModel.h
//  5_CollectionVIewExample
//
//  Created by tigi on 2018. 2. 14..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SampleCollectionViewModelProtocol.h"
#import "SampleMainVO.h"
#import "SampleCollectionViewCell.h"

@interface SampleCollectionViewModel : NSObject <SampleCollectionViewModelProtocol>

- (instancetype)initWithData:(SampleMainVO *)aData;

@end
