//
//  SampleMainVO.m
//  4_MultiCellTableViewExample
//
//  Created by tigi on 2018. 2. 13..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "SampleMainVO.h"

@implementation SampleMainVO

- (instancetype)initWithName:(NSString *)aMemberName thumbnailURL:(NSString *)aThumbnailURL
{
    self = [super init];
    if (self) {
        _memberName                 = aMemberName;
        _memberProfileThumbnailURL  = aThumbnailURL;
    }
    
    return self;
}

- (instancetype)init
{
    return [self initWithName:@"" thumbnailURL:@""];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"[(%@ %p) memberName : %@]", NSStringFromClass([self class]), self, _memberName];
}

@end
