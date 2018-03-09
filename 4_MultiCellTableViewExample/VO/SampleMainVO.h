//
//  SampleMainVO.h
//  4_MultiCellTableViewExample
//
//  Created by tigi on 2018. 2. 13..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SampleMainVO : NSObject

- (instancetype)initWithName:(NSString *)aMemberName thumbnailURL:(NSString *)aThumbnailURL NS_DESIGNATED_INITIALIZER;
- (void)assignMemberName:(NSString *)aMemberName thumbnailURL:(NSString *)aThumbnailURL;

@property (nonatomic, readonly) NSString *memberName;
@property (nonatomic, readonly) NSString *memberProfileThumbnailURL;

@end
