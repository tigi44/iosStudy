//
//  SampleMainVO+isEqual.m
//  7_isEqual&NSCopying
//
//  Created by tigi on 2018. 3. 9..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "SampleMainVO+isEqual.h"

@implementation SampleMainVO (isEqual)

- (BOOL)isEqualToSampleMainVO:(SampleMainVO *)aObject {
    if (!aObject) {
        return NO;
    }
    
    BOOL haveMemberName = (!self.memberName && !aObject.memberName) || [self.memberName isEqualToString:aObject.memberName];
    BOOL haveProfileImageURL = (!self.memberProfileThumbnailURL && !aObject.memberProfileThumbnailURL) || [self.memberProfileThumbnailURL isEqualToString:aObject.memberProfileThumbnailURL];
    
    return haveMemberName && haveProfileImageURL;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[SampleMainVO class]]) {
        return NO;
    }
    
    return [self isEqualToSampleMainVO:(SampleMainVO *)object];
}

- (NSUInteger)hash {
    return [self.memberName hash] ^ [self.memberProfileThumbnailURL hash];
}

//- (NSUInteger)hash {
//    NSUInteger sPrime = 31;
//    NSUInteger sResult = 1;
//
//    sResult = sPrime * sResult + [self.memberName hash];
//    sResult = sPrime * sResult + [self.memberProfileThumbnailURL hash];
//
//    return sResult;
//
//}

@end
