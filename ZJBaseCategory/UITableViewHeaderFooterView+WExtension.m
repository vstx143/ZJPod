//
//  UITableViewHeaderFooterView+WExtension.m
//  teee
//
//  Created by mac on 2019/3/21.
//  Copyright © 2019年 wzj. All rights reserved.
//

#import "UITableViewHeaderFooterView+WExtension.h"

@implementation UITableViewHeaderFooterView(WExtension)

+(NSString*)w_tableViewHeaderIdentifier{
     return [NSString stringWithFormat:@"KTableViewHeader%@ID",NSStringFromClass([self class])];
}
+(NSString*)w_tableViewFooterIdentifier{
      return [NSString stringWithFormat:@"KTableViewFooter%@ID",NSStringFromClass([self class])];
}
@end
