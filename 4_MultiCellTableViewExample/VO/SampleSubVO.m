//
//  SampleSubVO.m
//  4_MultiCellTableViewExample
//
//  Created by tigi on 2018. 2. 13..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "SampleSubVO.h"

@implementation SampleSubVO

- (instancetype)initWithTitle:(NSString *)aTitle value:(NSString *)aValue
{
    self = [super init];
    if (self) {
        _title  = aTitle;
        _value  = aValue;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithTitle:@"" value:@""];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"[(%@ %p) title : %@, value : %@]", NSStringFromClass([self class]), self, _title, _value];
}

@end
