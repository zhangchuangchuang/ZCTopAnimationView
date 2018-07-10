//
//  ZCTopNavView.h
//  ZCTopAnimationView
//
//  Created by 张闯闯 on 2018/7/9.
//  Copyright © 2018年 张闯闯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCTopNavView : UIView
/** 左边Item点击 */
@property (nonatomic, copy) dispatch_block_t leftItemClickBlock;
/** 右边Item点击 */
@property (nonatomic, copy) dispatch_block_t rightItemClickBlock;
/** 右边第二个Item点击 */
@property (nonatomic, copy) dispatch_block_t rightRItemClickBlock;
/**中间头部图片**/
@property (strong , nonatomic)UIImageView *topCenterTitleImage;
/* 左边Item */
@property (strong , nonatomic)UIButton *leftItemButton;
/* 右边Item */
@property (strong , nonatomic)UIButton *rightItemButton;
/* 右边第二个Item */
@property (strong , nonatomic)UIButton *rightRItemButton;
@end
