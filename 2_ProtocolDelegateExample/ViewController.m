//
//  ViewController.m
//  2_ProtocolDelegateExample
//
//  Created by tigi on 2018. 2. 12..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "ViewController.h"
#import "ProtocolDelegateSampleUIView.h"
#import "ProtocolDelegateViewController.h"
#import "TouchSampleProtocol.h"
#import "TouchSampleProtocolImpl.h"
#import "TouchSamplProtocolImplButDoesNotRespondsSelector.h"

#define TEST_CRASH 0

@interface ViewController ()

@property (nonatomic, readwrite) id<TouchSampleProtocol> sampleProtocolTestImpl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ISDebugLog();
    
    // 1. for testing a optional method on protocol
#if TEST_CRASH
    [self setSampleProtocolTestImpl:(id<TouchSampleProtocol>)[[TouchSamplProtocolImplButDoesNotRespondsSelector alloc] init]];
#else
    [self setSampleProtocolTestImpl:(id<TouchSampleProtocol>)[[TouchSampleProtocolImpl alloc] init]];
#endif
    [_sampleProtocolTestImpl optionalProtocolMethod]; // [_sampleProtocolTestImpl conformsToProtocol:@protocol(TouchSampleProtocol)] &&[_sampleProtocolTestImpl respondsToSelector:@selector(optionalProtocolMethod)]
    
    
    // 2. for testing delegate pattern
    ProtocolDelegateSampleUIView *sSampleView = [[ProtocolDelegateSampleUIView alloc] initWithFrame:[self view].bounds];
    [[self view] addSubview:sSampleView];
    
    [self requestURL:@"https://i.cdn.turner.com/nba/nba/.element/img/1.0/teamsites/logos/teamlogos_500x500/bkn.png"
          completion:^(UIImage *aImage) {
              [[sSampleView imageView] setImage:aImage];
              [[sSampleView imageSubLayer] setContents:(id)aImage.CGImage];
          }];
    
    [[sSampleView button] addTarget:self action:@selector(didTapAddButton) forControlEvents:UIControlEventTouchUpInside];
}

// add a new viewcontroller for testing a delegate
- (void)didTapAddButton
{
    UIViewController *sProtocolDelegateViewController = [[ProtocolDelegateViewController alloc] initWithNibName:nil bundle:nil];
    [[self navigationController] pushViewController:sProtocolDelegateViewController animated:YES];
}

#pragma mark - request a image url
- (void)requestURL:(NSString *)aURL completion:(void(^)(UIImage *))aCompletion
{
    dispatch_queue_t q_global   = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main     = dispatch_get_main_queue();
    
    dispatch_async(q_global, ^{
        NSString *sImageURL = aURL;
        UIImage *sImage = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: sImageURL]]];
        
        
        dispatch_async(q_main, ^{
            if (aCompletion != nil)
            {
                aCompletion(sImage);
            }
        });
    });
}
@end

