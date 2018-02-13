//
//  SampleViewModelProtocol.h
//  4_MultiCellTableViewExample
//
//  Created by tigi on 2018. 2. 13..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SampleViewModelProtocol <NSObject>

+ (Class)tableViewCellClass;

- (float)heightForRow;

- (void)generateTableViewCell:(UITableViewCell *) aCell;

@optional
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)aIndexPath;

@end
