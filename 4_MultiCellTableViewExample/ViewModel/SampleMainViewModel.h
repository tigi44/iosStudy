//
//  SampleMainViewModel.h
//  4_MultiCellTableViewExample
//
//  Created by tigi on 2018. 2. 13..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SampleMainVO.h"
#import "SampleMainTableViewCell.h"
#import "SampleViewModelProtocol.h"

@interface SampleMainViewModel : NSObject <SampleViewModelProtocol>

- (instancetype)initWithData:(SampleMainVO *)aData;

@end
