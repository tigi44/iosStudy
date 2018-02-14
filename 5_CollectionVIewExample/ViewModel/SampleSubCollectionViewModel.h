//
//  SampleSubCollectionViewModel.h
//  5_CollectionVIewExample
//
//  Created by tigi on 2018. 2. 14..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SampleCollectionViewModelProtocol.h"
#import "SampleSubVO.h"
#import "SampleSubCollectionViewCell.h"

@interface SampleSubCollectionViewModel : NSObject <SampleCollectionViewModelProtocol>

- (instancetype)initWithData:(SampleSubVO *)aData;

@end
