//
//  SampleSubVO.h
//  4_MultiCellTableViewExample
//
//  Created by tigi on 2018. 2. 13..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SampleSubVO : NSObject

- (instancetype)initWithTitle:(NSString *)aTitle value:(NSString *)aValue NS_DESIGNATED_INITIALIZER;

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *value;

@end
