//
//  MoreShaiXuan.m
//  TuNiuIpad
//
//  Created by tengxiangyin on 13-10-28.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//

#import "MoreShaiXuan.h"
#import "SearchResultsView.h"
#import "TuNiuIpadViewController.h"

@implementation MoreShaiXuan
@synthesize yuefenArr = _yuefenArr;
@synthesize leixingArr = _leixingArr;
@synthesize guojiaArr = _guojiaArr;
@synthesize tableView = _tableView;
@synthesize picker = _picker;
@synthesize lable = _lable;

- (UIDatePicker *)picker
{
    if (_picker == nil) {
        _picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 100, 200, 100)];
        [_picker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        // 设置当前显示时间
        [_picker setDate:[NSDate date] animated:YES];
        // 设置UIDatePicker的显示模式
        [_picker setDatePickerMode:UIDatePickerModeDate];
        _picker.hidden = YES;
    }
    return _picker;
}
- (NSArray*)yuefenArr
{
    if (_yuefenArr == nil) {
        _yuefenArr = @[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"];
    }
    return _yuefenArr;
}

- (NSArray*)leixingArr
{
    if (_leixingArr == nil) {
        _leixingArr = @[@"散客自组",@"外拼散客",@"团体抱团"];
    }
    return _leixingArr;
}

- (NSArray*)guojiaArr
{
    if (_guojiaArr == nil) {
        _guojiaArr = [[NSArray alloc] init];
    }
    return _guojiaArr;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self buildView];
//        [TXASIHttp ytxASIHTTPRequest:@"ipad_queryArea.action" viewController:self parm:nil];

    }
    return self;
}
- (void)wancheng:(UIButton*)button
{

    UIView* view = (UIView*)[[UIApplication sharedApplication].keyWindow viewWithTag:1111];
    view.hidden = YES;

    TuNiuIpadAppDelegate *app = (TuNiuIpadAppDelegate*)[[UIApplication sharedApplication] delegate];
    TuNiuIpadViewController *controller = app.viewController;
    [controller.searchView qingqiuwangluo];
//    [ qingqiuwangluo];
    
}
- (void)buildView
{
    self.zongArr = [[NSArray alloc] init];

    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 480)];
    leftView.backgroundColor = [UIColor whiteColor];
    [self addSubview:leftView];
    [self addViewLeft:leftView];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(120, 0, 200, 480)];
    rightView.backgroundColor = [UIColor whiteColor];
    [self addSubview:rightView];
    [self addViewright:rightView];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    but.frame = CGRectMake(110, 480, 120, 40);
    [but setTitle:@"完成" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(wancheng:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:but];
}
- (void)addViewLeft:(UIView*)leftView
{
    NSArray *arr = @[@"出行月份",@"线路类型",@"出行最早日期",@"出行最晚日期",@"目的地国家"];
    for (int i = 0; i < [arr count]; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(10, 30 + (40*i + 30), 100, 40);
        button.tag = i;
        [button setTitle:[NSString stringWithFormat:@"%@",[arr objectAtIndex:i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(reloadTableView:) forControlEvents:UIControlEventTouchUpInside];
        [leftView addSubview:button];
    }
}
- (void)addViewright:(UIView*)rightView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, rightView.frame.size.width, rightView.frame.size.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    self.tableView = tableView;
    tableView.hidden = YES;
    [rightView addSubview:tableView];
    

    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, 200, 30)];
    [topView setBackgroundColor:[UIColor blackColor]];
    topView.alpha = 1;
    self.topView = topView;
    topView.hidden = YES;
    [rightView addSubview:topView];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    lable.backgroundColor = [UIColor clearColor];
    lable.textColor = [UIColor whiteColor];
    self.lable = lable;
    lable.hidden = YES;
    [topView addSubview:lable];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(130, 5, 40, 20);
    [button addTarget:self action:@selector(riqiwancheng:) forControlEvents:UIControlEventTouchUpInside];
    self.wanchengbutton = button;
    button.hidden = YES;
    [topView addSubview:button];
    
    [rightView addSubview:self.picker];
    
}
- (void)riqiwancheng:(UIButton*)button
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.lable.text = [dateFormatter stringFromDate:[self.picker date]];
    if (button.tag == 11) {
        [Global shared].zaoshijian = [dateFormatter stringFromDate:[self.picker date]];
    }else{
        [Global shared].wanshijian = [dateFormatter stringFromDate:[self.picker date]];

    }
}
- (void)reloadTableView:(UIButton*)button
{
    switch (button.tag) {
        case 0:
            [Global shared].yuefen = @"";
            self.zongArr = nil;
            self.zongArr = self.yuefenArr;
            [self.tableView reloadData];
            self.picker.hidden = YES;
            self.topView.hidden = YES;
            self.tableView.hidden = NO;
            self.lable.hidden = YES;
            self.wanchengbutton.hidden = YES;
            break;
        case 1:
            [Global shared].leixing = @"";
            self.zongArr = nil;
            self.zongArr = self.leixingArr;
            [self.tableView reloadData];
            self.picker.hidden = YES;
            self.topView.hidden = YES;
            self.tableView.hidden = NO;
            self.lable.hidden = YES;
            self.wanchengbutton.hidden = YES;
            break;
        case 2:
            self.picker.hidden = NO;
            self.topView.hidden = NO;
            self.tableView.hidden = YES;
            self.wanchengbutton.tag = 11;
            self.lable.text = @"";
            self.lable.hidden = NO;
            self.wanchengbutton.hidden = NO;
            break;
        case 3:
            self.picker.hidden = NO;
            self.topView.hidden = NO;
            self.tableView.hidden = YES;
            self.wanchengbutton.tag = 22;
            self.lable.text = @"";
            self.lable.hidden = NO;
            self.wanchengbutton.hidden = NO;
            break;
        case 4:
            [Global shared].guojia = @"";
            self.zongArr = nil;
            self.zongArr = self.guojiaArr;
            [self.tableView reloadData];
            self.picker.hidden = YES;
            self.topView.hidden = YES;
            self.tableView.hidden = NO;
            self.lable.hidden = YES;
            self.wanchengbutton.hidden = YES;
            break;
            
        default:
            break;
    }

}
#pragma mark tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return  [self.zongArr count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellheight = 60;
    
    
    return cellheight;
}

- (UITableViewCell*)contructRow:(UITableView*)tableview indexPath:(NSIndexPath*)indexPath
{
    static NSString *CellIdentifierSection = @"contructRow";
    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:CellIdentifierSection];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierSection];
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
        
    }
    cell.textLabel.text = [self.zongArr objectAtIndex:indexPath.row];
    
    return cell;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell =nil;
    cell = [self contructRow:tableView indexPath:indexPath];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.zongArr count] == 13) { //月份
        if (indexPath.row == 12) {
            [Global shared].yuefen = @"全部";
        }else
        [Global shared].yuefen = [NSString stringWithFormat:@"%d",indexPath.row+1];//[self.zongArr objectAtIndex:indexPath.row];
    }else if ([self.zongArr count] == 4) { //类型
        NSString *str = nil;
        if (indexPath.row == 0) {
            str = [NSString stringWithFormat:@"%d",indexPath.row+1];
        }
        if (indexPath.row == 1) {
            str = [NSString stringWithFormat:@"%d",indexPath.row+1];
        }
        if (indexPath.row == 2) {
            str = [NSString stringWithFormat:@"%d",indexPath.row+2];
        }
        if (indexPath.row == 3) {
            str = @"全部";
        }
        [Global shared].leixing = str;
    }else {  // 国家
        [Global shared].guojia = [self.zongArr objectAtIndex:indexPath.row];
    }
    
}
#pragma mark - ASIHTTPRequest
- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSDictionary *dic =  [TXASIHttp requestJson:request];
    
    NSLog(@"ASIHTTPRequest-----------%@",dic);
  
    if ([[dic objectForKey:@"status"] isEqualToString:@"1"]) {
            
            NSArray *arrary = [dic objectForKey:@"value"];
            NSMutableArray *mutableArr = [[NSMutableArray alloc] initWithCapacity:0];
            NSMutableArray *mutableArr2 = [[NSMutableArray alloc] initWithCapacity:0];
            NSMutableArray *mutableArr4 = [[NSMutableArray alloc] initWithCapacity:0];
            [mutableArr2 addObject:@"境内："];
            [mutableArr4 addObject:@"境外："];
            for (NSDictionary *guojiadic in arrary){
                if ( [[guojiadic objectForKey:@"othertype"] isEqualToString:@"2"]) {
                    [mutableArr2 addObject:[guojiadic objectForKey:@"otherdata"]];
                }else if ([[guojiadic objectForKey:@"othertype"] isEqualToString:@"4"]) {
                    [mutableArr4 addObject:[guojiadic objectForKey:@"otherdata"]];
                }
                
            }
       
        [mutableArr addObjectsFromArray:mutableArr2];
        [mutableArr addObjectsFromArray:mutableArr4];
        self.guojiaArr = (NSArray*)mutableArr;

        
    }
    
    
}

- (void)requestFailed:(ASIHTTPRequest *)request

{
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
