//
//  SampleMainVO+copy.m
//  7_isEqual&NSCopying
//
//  Created by tigi on 2018. 3. 9..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "SampleMainVO+copy.h"

@implementation SampleMainVO (copy)

- (instancetype)copyWithZone:(NSZone *)zone {
    SampleMainVO *newSampleMainVO = [[[self class] allocWithZone:zone]init];
    [newSampleMainVO assignMemberName:self.memberName thumbnailURL:self.memberProfileThumbnailURL];
    return newSampleMainVO;
}

@end
