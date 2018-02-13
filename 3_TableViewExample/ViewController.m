//
//  ViewController.m
//  3_TableViewExample
//
//  Created by tigi on 2018. 2. 13..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "ViewController.h"
#import "ProtocolDelegateSampleUIView.h"
#import "SampleTableViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ISDebugLog();
    
    ProtocolDelegateSampleUIView *sSampleView = [[ProtocolDelegateSampleUIView alloc] initWithFrame:[self view].bounds];
    [[self view] addSubview:sSampleView];
    
    [self requestURL:@"https://i.cdn.turner.com/nba/nba/.element/img/1.0/teamsites/logos/teamlogos_500x500/bkn.png"
          completion:^(UIImage *aImage) {
              [[sSampleView imageView] setImage:aImage];
              [[sSampleView imageSubLayer] setContents:(id)aImage.CGImage];
          }];
    
    [[sSampleView button] addTarget:self action:@selector(didTapAddButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didTapAddButton
{
    UIViewController *sSampleTableViewController = [[SampleTableViewController alloc] initWithNibName:nil bundle:nil];
    [[self navigationController] pushViewController:sSampleTableViewController animated:YES];
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
