//
//  SampleSubViewModel.m
//  4_MultiCellTableViewExample
//
//  Created by tigi on 2018. 2. 13..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "SampleSubViewModel.h"

@interface SampleSubViewModel()

@property (nonatomic, readwrite) SampleSubVO *data;

@end

@implementation SampleSubViewModel

- (instancetype)initWithData:(SampleSubVO *)aData
{
    self = [super init];
    if (self) {
        _data = aData;
    }
    return self;
}

- (void)generateTableViewCell:(SampleSubTableViewCell *)aCell
{
    if ([aCell isKindOfClass:[SampleSubTableViewCell class]])
    {
        [[aCell titleLabel] setText:[_data title]];
        [[aCell valueLabel] setText:[_data value]];
    }
}

- (float)heightForRow
{
    return 50.f;
}

+ (Class)tableViewCellClass
{
    return [SampleSubTableViewCell class];
}

@end
