//
//  JMLongingControler.m
//  Sha
//
//  Created by 任雪强 on 16/5/12.
//  Copyright © 2016年 任雪强. All rights reserved.
//

#import "JMLongingControler.h"
#import "JMLongingCell.h"
#import "JMRemberUser.h"
#import "JMPhoneBtn.h"
#define SMWIND -45
#define kScreen_Width 375
#define JMDColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface JMLongingControler ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) UITableView *longingTableview;
@property (nonatomic,strong) UIButton *loginBtn;
@property (strong, nonatomic) JMRemberUser *inputTipsView;

@end

@implementation JMLongingControler

- (void)viewDidLoad {

  [super viewDidLoad];
  
  [self.view addSubview:self.longingTableview];

}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.longingTableview addSubview:self.inputTipsView];
}


- (UITableView *)longingTableview {
    
    if (!_longingTableview) {
        
        _longingTableview = [[UITableView alloc] initWithFrame:self.view.bounds];
        _longingTableview.tableHeaderView = [self customHeaderView];
        _longingTableview.tableFooterView = [self customFooterView];
        [_longingTableview registerClass:[JMLongingCell class] forCellReuseIdentifier:longingCell];
        [_longingTableview registerClass:[JMLongingCell class] forCellReuseIdentifier:Cell_captchae];
        [_longingTableview registerClass:[JMLongingCell class] forCellReuseIdentifier:Cell_PhoneCode];
        _longingTableview.delegate = self;
        _longingTableview.dataSource = self;
        
        
    }
    
    return _longingTableview;
}


#pragma mark - TableView headFoot 视图

- (UIView *)customHeaderView{
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 200)];
    
}


- (UIView *)customFooterView{

    UIView *footerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 200)];
    
    _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 35, kScreen_Width-40, 45)];
    
    UIView *footTopView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, kScreen_Width - 40, 0.5)];
    [footerV addSubview:footTopView];
    
    [_loginBtn setTitle:@"登  录" forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:25];
    
    _loginBtn.layer.cornerRadius = 5;
    _loginBtn.layer.masksToBounds = YES;
    
    [_loginBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(longingJM:) forControlEvents:UIControlEventTouchUpInside];
    _loginBtn.backgroundColor = JMDColor(40, 159, 219);
    [footerV addSubview:_loginBtn];
    
    return footerV;
}

- (JMRemberUser *)inputTipsView{
    if (!_inputTipsView) {
        
        _inputTipsView = [JMRemberUser tipsViewWithType:EaseInputTipsViewTypeLogin];
        _inputTipsView.valueStr = nil;
        
        __weak typeof(self) weakSelf = self;
        _inputTipsView.selectedStringBlock = ^(NSString *valueStr){
            
            
            [weakSelf.view endEditing:YES];
//            weakSelf.myLogin.email = valueStr;
//            [weakSelf refreshIconUserImage];
            [weakSelf.longingTableview reloadData];
            
            
        };
        UITableViewCell *cell = [_longingTableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        CGRect rect = _inputTipsView.frame;
        rect = CGRectMake(rect.origin.x,CGRectGetMaxY(cell.frame), rect.size.height, rect.size.width);
        _inputTipsView.frame = rect;
        
    }
    return _inputTipsView;
}

#pragma mark - 数据源

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return  3;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *cellIdentifier;
    
    if (indexPath.row == 2){
        cellIdentifier = Cell_PhoneCode;
        
    }else{
        cellIdentifier = longingCell;
    }
    
    
    JMLongingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    
    __weak typeof(self) weakSelf = self;

    
    if (indexPath.row == 0) {
        cell.textField.keyboardType = UIKeyboardTypeEmailAddress;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"User"]];
        cell.textField.leftView = imageView;
        cell.textField.leftViewMode = 3;
        
        
        [cell setPlaceholder:@" 请输入账号/手机号/邮箱" value:@""];
        
        cell.editDidBeginBlock = ^(NSString *valueStr){

            weakSelf.inputTipsView.valueStr = @"qq@";

            weakSelf.inputTipsView.active = YES;
        
        };

        cell.textChangedBlock = ^(NSString *valueStr){
            weakSelf.inputTipsView.valueStr = valueStr;
            weakSelf.inputTipsView.active = YES;
            
        };

        cell.editDidEndBlock = ^(NSString *textStr){
            weakSelf.inputTipsView.active = NO;
        };
        
    }else if (indexPath.row == 1){
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pass"]];
        cell.textField.leftView = imageView;
        cell.textField.leftViewMode = 3;
        cell.textField.secureTextEntry = YES;
        

        [cell setPlaceholder:@" 请输入您的账户密码" value:@""];
        
        cell.textChangedBlock = ^(NSString *valueStr){
//            weakSelf.myLogin.password = valueStr;
        };
    
    } else {
     cell.textField.keyboardType = UIKeyboardTypeNumberPad;
                        
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check"]];
    cell.textField.leftView = imageView;
    cell.textField.leftViewMode = 3;

    [cell setPlaceholder:@" 请输入校验码" value:@"self.myRegister.code"];
    
    cell.textChangedBlock = ^(NSString *valueStr){
        
    };
    cell.phoneCodeBtnClckedBlock = ^(JMPhoneBtn *btn){
        [weakSelf phoneCodeBtnClicked:btn];
    };
    
}
   return cell;
}

- (void)phoneCodeBtnClicked:(JMPhoneBtn *)sender{
    
     sender.enabled = YES;
    [sender startUpTimer];
//     [sender invalidateTimer];
    
//    sender.enabled = NO;
    
    
}


#pragma mark - 登录按钮
- (void)longingJM:(UIButton*)btn {
    __weak typeof(self) weakSelf = self;

    [self.view endEditing:YES];
    

//    if (_myLogin.email.length == 0 && _myLogin.password == 0) {
        
//        [JMPhoneBtn showText:@"请输入您的登录账号和密码" offestY:SMWIND];
 
//        return;
//    } else if (_myLogin.email.length == 0) {
//
//        [JMPhoneBtn showText:@"请输入您的登录账号" offestY:SMWIND];
//        return;

        
//    } else if (_myLogin.password.length == 0) {
    
    
//        [JMPhoneBtn showText:@"请输入您的登录密码" offestY:SMWIND];
//        return;
//
//    }
//    else if ([JMDTools isContentString:_myLogin.password contain:@" "]) {
////        [JMPhoneBtn showText:@"密码中不能包含空格" offestY:-30];
//        return;
//    }
    
    
//    UIView *activeBtn = [self getActiveBtn:btn];
//    _longingWait = activeBtn;
//    [btn addSubview:activeBtn];
//    [JMWindow addSubview:self.bigView];

}




@end
/**
 
 
    
     
     UIButton *registerBtn = [[UIButton alloc] init];
     [registerBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
     [registerBtn setTitleColor:JMDColor(40, 159, 219) forState:UIControlStateNormal];
     
     [registerBtn setTitle:@"快速注册" forState:UIControlStateNormal];
     [footerV addSubview:registerBtn];
 //    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
 //        make.size.mas_equalTo(CGSizeMake(100, 30));
 //        make.top.equalTo(_loginBtn.mas_bottom).offset(25);
 //    }];
     [registerBtn addTarget:self action:@selector(goRegisterVC:) forControlEvents:UIControlEventTouchUpInside];
     
     
     
     UIButton *forgetBtn = [[UIButton alloc] init];
     [forgetBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
     [forgetBtn setTitleColor:JMDColor(40, 159, 219)forState:UIControlStateNormal];
     
     [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
     [footerV addSubview:forgetBtn];
 //    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
 //        make.size.mas_equalTo(CGSizeMake(100, 30));
 //        make.top.equalTo(_loginBtn.mas_bottom).offset(25);
 //        make.right.mas_equalTo(footerV);
 //    }];
     [forgetBtn addTarget:self action:@selector(goForgetPasswordVc) forControlEvents:UIControlEventTouchUpInside];
     
     
     
     //    [_loginBtn addSubview:[self getActiveBtn:_loginBtn]];
     
 */
