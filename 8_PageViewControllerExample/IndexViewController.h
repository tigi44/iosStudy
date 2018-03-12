//
//  IndexViewController.h
//  8_PageViewControllerExample
//
//  Created by tigi on 2018. 3. 12..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexViewController : UIViewController

@property(nonatomic, assign, readonly)NSInteger index;

- (instancetype)initWithIndex:(NSInteger)aIndex NS_DESIGNATED_INITIALIZER;

@end
