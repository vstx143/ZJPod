//
//  UICollectionReusableView+WExtension.m
//  teee
//
//  Created by mac on 2019/3/21.
//  Copyright © 2019年 wzj. All rights reserved.
//

#import "UICollectionReusableView+WExtension.h"

@implementation UICollectionReusableView(WExtension)
+ (NSString *)w_collectViewHeaderIdentifier {
    return [NSString stringWithFormat:@"KCollectionHeader%@ID",NSStringFromClass([self class])];
}

+ (NSString *)w_collectViewFooterIdentifier {
    return [NSString stringWithFormat:@"KCollectionFooter%@ID",NSStringFromClass([self class])];
}
@end
