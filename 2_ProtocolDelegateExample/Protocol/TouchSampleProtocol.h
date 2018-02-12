//
//  TouchSampleProtocol.h
//  ProtocolDelegateExample
//
//  Created by tigi on 2018. 1. 25..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TouchSampleProtocol <NSObject>

- (void)didTap;

@optional
- (void)optionalProtocolMethod;

@end
