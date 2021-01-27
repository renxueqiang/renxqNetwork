//
//  JMPhoneBtn.m
//  JMDun
//
//  Created by 任雪强 on 16/5/19.
//  Copyright © 2016年 任雪强. All rights reserved.
//

#import "JMPhoneBtn.h"
//#import "MBProgressHUD.h"
@interface JMPhoneBtn ()

@property (nonatomic, strong, readwrite) NSTimer *timer;
@property (assign, nonatomic) NSTimeInterval durationToValidity;


@end

@implementation JMPhoneBtn


- (instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.enabled = YES;
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}


- (void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
   
//    self.backgroundColor = JMDColor(40, 159, 219);
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (enabled) {
        [self setTitle:@"发送校验码" forState:UIControlStateNormal];
        
        
    }else if ([self.titleLabel.text isEqualToString:@"发送校验码"]){
        
        [self setTitle:@"正在发送..." forState:UIControlStateNormal];
    }
}

- (void)startUpTimer{
    _durationToValidity = 180;
    
    if (self.isEnabled) {
        self.enabled = NO;
    }
    self.backgroundColor = [UIColor redColor];

    [self setTitle:[NSString stringWithFormat:@"%.0fS后可重新获取", _durationToValidity] forState:UIControlStateNormal];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(redrawTimer:)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)invalidateTimer{
    if (!self.isEnabled) {
        self.enabled = YES;
    }
    [self.timer invalidate];
    self.timer = nil;
}

- (void)redrawTimer:(NSTimer *)timer {
    _durationToValidity--;
    if (_durationToValidity > 0) {
        self.titleLabel.text = [NSString stringWithFormat:@"%.0fS后可重新获取", _durationToValidity];
        [self setTitle:[NSString stringWithFormat:@"%.0fS后可重新获取", _durationToValidity] forState:UIControlStateNormal];
    }else{
        [self invalidateTimer];
    }
}



//+ (void)showText:(NSString*)text offestY:(CGFloat)offY {
//
//    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
//    
//    hud.mode = MBProgressHUDModeText;
//    
//    hud.labelText = text;
//    
//    hud.margin = 10.f;
//    hud.yOffset = offY;
//    hud.removeFromSuperViewOnHide = YES;
//    
//    [hud hide:YES afterDelay:2];
//    
//    
//
//}


@end
