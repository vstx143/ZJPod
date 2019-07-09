//
//  UICollectionViewCell+WExtension.m
//  teee
//
//  Created by mac on 2019/3/21.
//  Copyright © 2019年 wzj. All rights reserved.
//

#import "UICollectionViewCell+WExtension.h"

@implementation UICollectionViewCell(WExtension)
+(NSString*)w_collectionViewCellIdentifier{
    return [NSString stringWithFormat:@"KCollection%@ID",NSStringFromClass([self class])];
}
@end
