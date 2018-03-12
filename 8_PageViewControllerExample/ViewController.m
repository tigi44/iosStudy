//
//  ViewController.m
//  8_PageViewControllerExample
//
//  Created by tigi on 2018. 3. 12..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "ViewController.h"
#import "IndexViewController.h"

@interface ViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property(nonatomic, strong) UIPageViewController *pageViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupPageViewController];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)setupPageViewController {
    [self setPageViewController:[[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil]];
    [_pageViewController setDataSource:self];
    [_pageViewController setDelegate:self];
    [[_pageViewController view] setFrame:[[self view] bounds]];
    
    NSArray *sViewControllers = [NSArray arrayWithObject:[self viewControllerAtIndex:0]];
    [_pageViewController setViewControllers:sViewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self addChildViewController:_pageViewController];
    [[self view] addSubview:[_pageViewController view]];
    [_pageViewController didMoveToParentViewController:self];
    
    // change color on the page control
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
}

- (IndexViewController *)viewControllerAtIndex:(NSInteger)aIndex {
    return [[IndexViewController alloc] initWithIndex:aIndex];
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)aPageViewController viewControllerAfterViewController:(UIViewController *)aViewController {
    NSInteger sIndex = [(IndexViewController *)aViewController index];
    
    sIndex++;
    
    if (sIndex == 5)
    {
        return nil;
    }

    return [self viewControllerAtIndex:sIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)aPageViewController viewControllerBeforeViewController:(UIViewController *)aViewController {
    NSInteger sIndex = [(IndexViewController *)aViewController index];
    
    if (sIndex == 0)
    {
        return nil;
    }
    
    sIndex--;

    return [self viewControllerAtIndex:sIndex];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)aPageViewController {
    return 5;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)aPageViewController {
    return 0;
}

@end
