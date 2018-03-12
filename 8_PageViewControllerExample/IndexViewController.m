//
//  IndexViewController.m
//  8_PageViewControllerExample
//
//  Created by tigi on 2018. 3. 12..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "IndexViewController.h"

@interface IndexViewController ()

@property(nonatomic, assign, readwrite)NSInteger index;
@property(nonatomic, readwrite)UILabel *indexLabel;

@end

@implementation IndexViewController

- (instancetype)initWithIndex:(NSInteger)aIndex {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _index = aIndex;
        
        // init the label
        _indexLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_indexLabel setNumberOfLines:1];
        [_indexLabel setFont:[UIFont boldSystemFontOfSize:24.0f]];
        [_indexLabel setTextColor:[UIColor blackColor]];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    return [self initWithIndex:0];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [self initWithIndex:0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set the label layout
    [_indexLabel setText:[NSString stringWithFormat:@"INDEX : %ld", _index]];
    [_indexLabel sizeToFit];
    CGRect sIndexLabelFrame = [_indexLabel frame];
    sIndexLabelFrame.origin.x = (NSInteger)(([[self view] frame].size.width - sIndexLabelFrame.size.width) / 2);  // MoveToHorizontalCenter
    sIndexLabelFrame.origin.y = (NSInteger)(([[self view] frame].size.height - sIndexLabelFrame.size.height) / 2); // MoveToVerticalCenter
    [_indexLabel setFrame:sIndexLabelFrame];
    [[self view] addSubview:_indexLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
