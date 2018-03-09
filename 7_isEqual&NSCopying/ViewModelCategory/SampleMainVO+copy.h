//
//  SampleMainVO+copy.h
//  7_isEqual&NSCopying
//
//  Created by tigi on 2018. 3. 9..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "SampleMainVO.h"

@interface SampleMainVO (copy)

- (instancetype)copyWithZone:(NSZone *)zone;

@end
