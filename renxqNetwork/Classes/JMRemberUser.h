//
//  JMRemberUser.h
//  Sha
//
//  Created by 任雪强 on 16/5/13.
//  Copyright © 2016年 任雪强. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, RemberViewType) {
    EaseInputTipsViewTypeLogin = 0,
    EaseInputTipsViewTypeRegister
};
@interface JMRemberUser : UIView

@property (strong, nonatomic) NSString *valueStr;
@property (nonatomic, assign, getter=isActive) BOOL active;
@property (nonatomic, assign, readonly) RemberViewType type;

@property (nonatomic, copy) void(^selectedStringBlock)(NSString *);


+ (instancetype)tipsViewWithType:(RemberViewType)type;

- (instancetype)initWithTipsType:(RemberViewType)type;

- (void)refresh;

@end
