//
//  JMPhoneBtn.h
//  JMDun
//
//  Created by 任雪强 on 16/5/19.
//  Copyright © 2016年 任雪强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMPhoneBtn : UIButton

- (void)startUpTimer;
- (void)invalidateTimer;

+ (void)showText:(NSString*)text offestY:(CGFloat)offY;
@end
