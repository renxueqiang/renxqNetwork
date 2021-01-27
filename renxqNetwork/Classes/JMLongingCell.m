//
//  JMLongingCell.m
//  Sha
//
//  Created by 任雪强 on 16/5/12.
//  Copyright © 2016年 任雪强. All rights reserved.
//

#import "JMLongingCell.h"
#import "JMPhoneBtn.h"

@interface JMLongingCell ()

@property (strong, nonatomic) UIView *actiViewF;

@end

@implementation JMLongingCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _textField = [UITextField new];
        _textField.clearButtonMode = 1;
        [_textField setFont:[UIFont systemFontOfSize:17]];
        _textField.tintColor = [UIColor grayColor];
        [_textField addTarget:self action:@selector(editDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
        [_textField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
        [_textField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
        
        [self.contentView addSubview:_textField];
        _textField.frame =CGRectMake(0, 0, 300, 44);
        
        if ([reuseIdentifier hasPrefix:Cell_PhoneCode]){
            if (!_codeBtn) {
                _codeBtn = [[JMPhoneBtn alloc] initWithFrame:CGRectMake(375 - 80, 10, 106, 25)];
                [_codeBtn addTarget:self action:@selector(phoneCodeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:_codeBtn];
            }
        } else if ([reuseIdentifier isEqualToString:CellUnLock_Code]){
            
            if (!_unLockCode) {
                _unLockCode = [[UIButton alloc] initWithFrame:CGRectMake(375 - 117, 7, 97, 32)];
                
                _unLockCode.enabled = NO;
                
                [_unLockCode setBackgroundImage:[UIImage imageNamed:@"可点击"] forState:UIControlStateNormal];
                
                [_unLockCode setBackgroundImage:[UIImage imageNamed:@"下一步不可点击"] forState:UIControlStateDisabled];
                
                
                [_unLockCode setTitle:@"生成应急码" forState:UIControlStateNormal];
                _unLockCode.titleLabel.font = [UIFont systemFontOfSize:13];
                _unLockCode.layer.cornerRadius = 3;
                _unLockCode.layer.masksToBounds = YES;
                [_unLockCode addTarget:self action:@selector(unLockCodeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:_unLockCode];
                
            }
            
            
        }
        
        
        
        
    }
    
    
    
    return self;
    
}


- (void)setPlaceholder:(NSString *)phStr value:(NSString *)valueStr{
    self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:phStr attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    
    self.textField.text = valueStr;
}


#pragma mark - textFiled 的事件
- (void)editDidBegin:(id)sender {
    
    
    if (self.editDidBeginBlock) {
        self.editDidBeginBlock(self.textField.text);
    }
}

- (void)editDidEnd:(id)sender {
    
    
    if (self.editDidEndBlock) {
        self.editDidEndBlock(self.textField.text);
    }
}

- (void)textValueChanged:(id)sender {
    
    
    if (self.textChangedBlock) {
        self.textChangedBlock(self.textField.text);
    }
}


- (void)phoneCodeButtonClicked:(id)sender{
    if (self.phoneCodeBtnClckedBlock) {
        self.phoneCodeBtnClckedBlock(sender);
    }
}


- (void)unLockCodeBtnClicked:(id)sender{
    if (self.unLockCodeBtnBlock) {
        self.unLockCodeBtnBlock(sender);
    }
}


+ (NSString *)randomCellIdentifier{
    return [NSString stringWithFormat:@"%@_%ld", Cell_PhoneCode, random()];
}




- (void)refreshCaptchaImage:(id)objc{
    
    
//    imageType captchCell = self.cellImageType == imageUnlock? imageUnlock :  self.cellImageType ? imageBind : imageLogin;
//
//    NSLog(@"++++++++++++++>%ld",self.cellImageType);
    
    UIImageView *captchImage = (UIImageView*)objc;
    
    UIView *captch = [self getActiView:captchImage];
    
    [captchImage addSubview:captch];
    
    
    NSString *width = @"80";
    NSString *heigdht = @"30";
    
//    [[JMUrlRequest sharedManager] getImagewidth:width getImageHeight:heigdht getImageType:captchCell suseccBlock:^(NSDictionary *suDict) {
//        
//        NSNumber *account = suDict[@"Result"];
//        
//        if (account.integerValue == 0) {
//            [captch removeFromSuperview];
//            
//            NSData *decodeDate = [[NSData alloc] initWithBase64EncodedData:suDict[@"imageData"] options:0];
//            
//            captchImage.image = [UIImage imageWithData:decodeDate];
//            NSLog(@"%@",[UIImage imageWithData:decodeDate]);
//            
//        } else {
//            [captch removeFromSuperview];
//            
//            [JMPhoneBtn showText:@"请稍后重试" offestY:-30];
//            
//            return ;
//        }
//        
//    } errorBlock:^(NSError *errDict) {
//        [captch removeFromSuperview];
//        
//        [JMPhoneBtn showText:@"请稍后重试" offestY:-30];
//    }];
    
    
}


- (UIView*)getActiView:(UIImageView*)imageView {
    
    if (!_actiViewF) {
        
        
        
        _actiViewF = [[UIView alloc] initWithFrame:imageView.bounds];
        _actiViewF.layer.cornerRadius = 2;
        _actiViewF.layer.masksToBounds = YES;
        _actiViewF.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"验证码加载"]];
        
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]
                                                      initWithActivityIndicatorStyle:0];
        CGSize captchaViewSize = imageView.bounds.size;
        activityIndicator.hidesWhenStopped = YES;
        [activityIndicator setCenter:CGPointMake(captchaViewSize.width/2, captchaViewSize.height/2)];
        [activityIndicator startAnimating];
        
        [_actiViewF addSubview:activityIndicator];
    }
    
    
    return _actiViewF;
    
}





@end
