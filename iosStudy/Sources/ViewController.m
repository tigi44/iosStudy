//
//  ViewController.m
//  iosStudy
//
//  Created by tigi on 2018. 1. 10..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "ViewController.h"
#import "SampleView.h"
#import "ImageSampleView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)loadView
{
    // case 2
    // uiview의 layoutsubview 메소드를 사용하려면 loadview에서 커스텀뷰를 생성해주는게..
    ImageSampleView *sSampleView = [[ImageSampleView alloc] initWithFrame:CGRectZero];
    [sSampleView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [self setView:sSampleView];
    
//    SampleView *sSampleView = [[SampleView alloc] initWithFrame:CGRectZero];
//    [sSampleView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
//    [self setView:sSampleView];
    
    // case 1
//    [super loadView];
    NSLog(@"loadView");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    
    [self requestURL:@"https://pbs.twimg.com/profile_images/937105261982109696/YV99y6I6_400x400.jpg"
          completion:^(UIImage *aImage) {
              ImageSampleView *sView = (ImageSampleView *)[self view];
              [[sView imageView] setImage:aImage];
              [[sView imageSubLayer] setContents:(id)aImage.CGImage];
          }];
    
    // case 1
    // addSubview 시 layoutSubview 가 한번 불리고, loadView시 view의 크기가 확정되지 않았기에 subview가 화면에 노출되면서 resizing되어 layoutSubview가 한번 더 불림.(이 방식으로는 layoutsubview가 총 두번 불림)
//        SampleView *sSampleView = [[SampleView alloc] initWithFrame:[self view].bounds];
//        [sSampleView sizeToFit];
//        [[self view] addSubview:sSampleView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // case 2
    // loadview에서 커스텀뷰를 추가시 view의 사이즈 조절은 뷰가 로드되고 appear되기전에 해야 적용됨
    //    [[self view] sizeToFit];
    NSLog(@"viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear");
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    NSLog(@"viewWillLayoutSubviews");
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    NSLog(@"viewDidLayoutSubviews");
}

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
