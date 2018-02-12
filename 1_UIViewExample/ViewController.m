//
//  ViewController.m
//  1_UIViewExample
//
//  Created by tigi on 2018. 2. 12..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "ViewController.h"
#import "UIViewImageSampleView.h"

#define SET_VIEW_IN_VIEW_DID_LOAD 0

@interface ViewController ()

@end

@implementation ViewController


- (void)loadView
{
#if SET_VIEW_IN_VIEW_DID_LOAD
    [super loadView];
#else
    UIViewImageSampleView *sSampleView = [[UIViewImageSampleView alloc] initWithFrame:CGRectZero];
    [sSampleView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [self setView:sSampleView];
#endif
    
    ISDebugLog();
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ISDebugLog();
    
#if SET_VIEW_IN_VIEW_DID_LOAD
    // twice called 'layoutSubview'. when called addSubview and appear on display for resizing view.
    UIViewImageSampleView *sSampleView = [[UIViewImageSampleView alloc] initWithFrame:[self view].bounds];
//    [sSampleView sizeToFit];
    [[self view] addSubview:sSampleView];
    
    [self requestURL:@"https://i.cdn.turner.com/nba/nba/.element/img/1.0/teamsites/logos/teamlogos_500x500/bkn.png"
          completion:^(UIImage *aImage) {
              [[sSampleView imageView] setImage:aImage];
              [[sSampleView imageSubLayer] setContents:(id)aImage.CGImage];
          }];
#else
    UIViewImageSampleView *sSampleView = (UIViewImageSampleView *)[self view];

    [self requestURL:@"https://i.cdn.turner.com/nba/nba/.element/img/1.0/teamsites/logos/teamlogos_500x500/bkn.png"
          completion:^(UIImage *aImage) {
              [[sSampleView imageView] setImage:aImage];
              [[sSampleView imageSubLayer] setContents:(id)aImage.CGImage];
          }];
#endif
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ISDebugLog();
    
#if SET_VIEW_IN_VIEW_DID_LOAD
#else
//    [[self view] sizeToFit];
#endif
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    ISDebugLog();
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    ISDebugLog();
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    ISDebugLog();
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    ISDebugLog();
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    ISDebugLog();
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
