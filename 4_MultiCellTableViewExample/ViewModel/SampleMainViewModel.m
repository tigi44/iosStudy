//
//  SampleMainViewModel.m
//  4_MultiCellTableViewExample
//
//  Created by tigi on 2018. 2. 13..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "SampleMainViewModel.h"

@interface SampleMainViewModel()

@property (nonatomic, readwrite) SampleMainVO *data;

@end

@implementation SampleMainViewModel

- (instancetype)initWithData:(SampleMainVO *)aData
{
    self = [super init];
    if (self) {
        _data = aData;
    }
    return self;
}

- (void)generateTableViewCell:(SampleMainTableViewCell *)aCell
{
    if ([aCell isKindOfClass:[SampleMainTableViewCell class]])
    {
        [[aCell nameLabel] setText:[_data memberName]];
        [self requestURL:[_data memberProfileThumbnailURL] completion:^(UIImage *aImage) {
            [[aCell profileImageView] setImage:aImage];
        }];
    }
}

- (float)heightForRow
{
    return 100.f;
}

+ (Class)tableViewCellClass
{
    return [SampleMainTableViewCell class];
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)aIndexPath
{
    SampleMainTableViewCell *sCell = [aTableView cellForRowAtIndexPath:aIndexPath];
    if (![[[sCell nameLabel] text] isEqual: @"click!"])
    {
        [[sCell nameLabel] setText:@"click!"];
    }
    else
    {
        [self generateTableViewCell:sCell];
    }
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
