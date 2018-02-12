//
//  ProtocolDelegateTouchSampleUIView.h
//  ProtocolDelegateExample
//
//  Created by tigi on 2018. 2. 9..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "UIViewSampleView.h"
#import "TouchSampleProtocol.h"

#define MAKE_MEMORY_LEAK 0

@interface ProtocolDelegateTouchSampleUIView : UIViewSampleView

// 3. for testing a delegate property (retain cycle issue) (check memory on MAKE_MEMORY_LEAK version)
#if MAKE_MEMORY_LEAK
@property (nonatomic, readwrite) id<TouchSampleProtocol> delegate;
#else
@property (nonatomic, weak) id<TouchSampleProtocol> delegate;
#endif


@property (nonatomic, readonly) UILabel *descriptionLabel;

@end
