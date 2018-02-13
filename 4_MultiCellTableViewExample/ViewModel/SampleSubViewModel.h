//
//  SampleSubViewModel.h
//  4_MultiCellTableViewExample
//
//  Created by tigi on 2018. 2. 13..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SampleSubVO.h"
#import "SampleSubTableViewCell.h"
#import "SampleViewModelProtocol.h"

@interface SampleSubViewModel : NSObject <SampleViewModelProtocol>

- (instancetype)initWithData:(SampleSubVO *)aData;

@end
