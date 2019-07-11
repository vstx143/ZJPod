//
//  UITableViewCell+Extension.m
//  teee
//
//  Created by mac on 2019/3/21.
//  Copyright © 2019年 wzj. All rights reserved.
//

#import "UITableViewCell+WExtension.h"

@implementation UITableViewCell(WExtension)
+(NSString*)w_tableViewCellIdentifier{
    return [NSString stringWithFormat:@"KTable%@ID",NSStringFromClass([self class])];
}
@end
