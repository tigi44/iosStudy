//
//  TestTouchView.h
//  iosStudy
//
//  Created by tigi on 2018. 1. 11..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestProtocol.h"

#define MAKE_MEMORY_LEAK 0

@interface TestTouchView : UIView

#if MAKE_MEMORY_LEAK
@property (nonatomic, readwrite) id<TestProtocol> delegate;
#else
@property (nonatomic, weak) id<TestProtocol> delegate;
#endif

@end
