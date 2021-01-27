//
//  JMRemberUser.m
//  Sha
//
//  Created by 任雪强 on 16/5/13.
//  Copyright © 2016年 任雪强. All rights reserved.
//

#import "JMRemberUser.h"
//#import "JMLonging.h"
#define kScreen_Width 375

@interface JMRemberUser ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *remberTableView;
@property (strong, nonatomic) NSArray *dataList;

@property (strong, nonatomic) NSArray *emailAllList;

@property (strong, nonatomic) NSMutableArray *loginAllList;


@end

@implementation JMRemberUser


+ (instancetype)tipsViewWithType:(RemberViewType)type{
    return [[self alloc] initWithTipsType:type];
}


- (instancetype)initWithTipsType:(RemberViewType)type{
    
    CGFloat padingWith = type == EaseInputTipsViewTypeLogin? 20: 0.0;
    
    if (self = [super initWithFrame:CGRectMake(padingWith, 0, kScreen_Width-padingWith*2, 135)]) {
        
        [self addSubview:self.remberTableView];

        _type = type;
        _active = YES;
    }
    return self;
}



- (UITableView *)remberTableView {

    if (!_remberTableView) {
        

            UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
            tableView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
            tableView.dataSource = self;
            tableView.delegate = self;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView.tableFooterView = [UIView new];
            _remberTableView = tableView;
    }
    
    return _remberTableView;
}





- (void)setActive:(BOOL)active{
    _active = active;
    self.hidden = self.dataList.count == 0 || !_active;
}


- (void)setValueStr:(NSString *)valueStr{
    
    _valueStr = valueStr;
    if (_valueStr.length == 0) {
        self.dataList = nil;
    }else if ([_valueStr rangeOfString:@"@"].location == NSNotFound) {
        self.dataList = _type == EaseInputTipsViewTypeLogin? [self loginList]: nil;
    }else{
        self.dataList = [self emailList];
    }
    
    
    [self refresh];
}

- (void)refresh{
    [self.remberTableView reloadData];
    self.hidden = self.dataList.count <= 0 || !_active;
}


- (NSMutableArray *)loginAllList{

        
        _loginAllList = [NSMutableArray array];

    return _loginAllList;
}


- (NSArray *)loginList{
    if (_valueStr.length == 0) {
        return nil;
    }
    NSString *tipStr = [_valueStr copy];
    NSMutableArray *list = [NSMutableArray new];
    [[self loginAllList] enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        if ([obj rangeOfString:tipStr].location != NSNotFound) {
            [list addObject:obj];
        }
    }];
    return list;
}



- (NSArray *)emailAllList{
    if (!_emailAllList) {
        NSString *emailListStr = @" sina.com, 163.com, qq.com, 126.com, 139.com,  189.cn, icloud.com, vip.sina.com, sina.cn, sina.com.cn, hotmail.com, sohu.com, gmail.com, yahoo.com, yeah.net, vip.qq.com, foxmail.com, live.cn, aliyun.com, live.com, msn.com, msn.cn";
        
        _emailAllList = [emailListStr componentsSeparatedByString:@", "];
    }
    return _emailAllList;
}


- (NSArray *)emailList{
    if (_valueStr.length == 0) {
        return nil;
    }
    NSRange range_AT = [_valueStr rangeOfString:@"@"];
    if (range_AT.location == NSNotFound) {
        return nil;
    }
    NSString *nameStr = [_valueStr substringToIndex:range_AT.location];
    NSString *tipStr = [_valueStr substringFromIndex:range_AT.location + range_AT.length];
    NSMutableArray *list = [NSMutableArray new];
    [[self emailAllList] enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        if (tipStr.length <= 0 || [obj rangeOfString:tipStr].location != NSNotFound) {
            [list addObject:[nameStr stringByAppendingFormat:@"@%@", obj]];
        }
    }];
    

    return list;
}


#pragma mark - tableView方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    

    return _dataList.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    NSString *CellIdentifier = @"RemViewCell";
    
    NSInteger labelTag = 99;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, kScreen_Width - 36, 35)];

        label.font = [UIFont systemFontOfSize:14];
        label.tag = labelTag;
        [cell.contentView addSubview:label];
    }
    
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:labelTag];
    label.textColor =  [UIColor blackColor];
    label.text = [_dataList objectAtIndex:indexPath.row];

    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectedStringBlock && self.dataList.count > indexPath.row) {
        self.selectedStringBlock([self.dataList objectAtIndex:indexPath.row]);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}


@end
