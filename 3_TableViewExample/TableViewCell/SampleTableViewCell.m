//
//  SampleTableViewCell.m
//  3_TableViewExample
//
//  Created by tigi on 2018. 2. 13..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "SampleTableViewCell.h"

@implementation SampleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)aStyle reuseIdentifier:(NSString *)aReuseIdentifier
{
    self = [super initWithStyle:aStyle reuseIdentifier:aReuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    ISDebugLog();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
