//
//  JMLongingCell.h
//  Sha
//
//  Created by 任雪强 on 16/5/12.
//  Copyright © 2016年 任雪强. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "JMUrlRequest.h"
@class JMPhoneBtn;
@class JMImageView;

#define longingCell @"longingCell"
#define Cell_PhoneCode @"Cell_PhoneCode"
#define Cell_captchae @"Cell_captchae"
#define CellBind_captchae @"CellBind_captchae"
#define CellUnLock_captchae @"CellUnLock_captchae"
#define CellUnLock_Code @"CellUnLock_Code"


@interface JMLongingCell : UITableViewCell

@property (strong, nonatomic, readonly) JMPhoneBtn *codeBtn;
@property (strong, nonatomic, readonly) JMImageView *captchaView;

@property (strong, nonatomic, readonly) UITextField *textField;

@property (nonatomic,copy) void(^textChangedBlock)(NSString *);
@property (nonatomic,copy) void(^editDidBeginBlock)(NSString *);
@property (nonatomic,copy) void(^editDidEndBlock)(NSString *);
@property (nonatomic,copy) void(^phoneCodeBtnClckedBlock)(JMPhoneBtn *);

@property (strong, nonatomic, readonly) UIButton *unLockCode;
@property (nonatomic,copy) void(^unLockCodeBtnBlock)(UIButton *);


//@property (nonatomic,assign) imageType cellImageType;


- (void)setPlaceholder:(NSString *)phStr value:(NSString *)valueStr;


+ (NSString *)randomCellIdentifier;
- (void)refreshCaptchaImage:(id)objc;
@end
