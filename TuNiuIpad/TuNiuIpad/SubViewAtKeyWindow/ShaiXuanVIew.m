//
//  ShaiXuanVIew.m
//  TuNiuIpad
//
//  Created by tengxiangyin on 13-7-8.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//
#import "MoreShaiXuan.h"
#import "ShaiXuanVIew.h"
#import "GuoJiaListViewController.h"

@implementation ShaiXuanVIew
@synthesize oneView = _oneView;
@synthesize twoView = _twoView;
@synthesize threeView = _threeView;
@synthesize moreview =_moreview;

@synthesize yuefenArr = _yuefenArr;
@synthesize leixingArr = _leixingArr;
@synthesize guojiaArr = _guojiaArr;
@synthesize tableView = _tableView;
@synthesize picker = _picker;
@synthesize lable = _lable;


- (UIDatePicker *)picker
{
    if (_picker == nil) {
        _picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 30, 320, 100)];
        [_picker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        // 设置当前显示时间
        [_picker setDate:[NSDate date] animated:YES];
        // 设置UIDatePicker的显示模式
        [_picker setDatePickerMode:UIDatePickerModeDate];
    }
    return _picker;
}
- (NSArray*)yuefenArr
{
    if (_yuefenArr == nil) {
        _yuefenArr = @[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月",@"全部"];
    }
    return _yuefenArr;
}

- (NSArray*)leixingArr
{
    if (_leixingArr == nil) {
        _leixingArr = @[@"散客自组",@"外拼散客",@"团体抱团",@"全部"];
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

- (UIView*)moreview
{
    if (_moreview == nil) {
//        _moreview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
//        _moreview.backgroundColor = [UIColor blackColor];
//        _moreview.alpha = 0.7;
//        _moreview.tag = 1111;
//        [[UIApplication sharedApplication].keyWindow addSubview:_moreview];
//        MoreShaiXuan *view = [[MoreShaiXuan alloc] initWithFrame:CGRectMake((768-320)/2, (1024-500)/2, 320, 550)];
//        [_moreview addSubview:view];
        
        _moreview = [[UIView alloc] initWithFrame:CGRectMake(120, 0, 320, 46*5)];
        _moreview.backgroundColor = [UIColor clearColor];
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"setting_list_bg.png"]];
        image.frame = CGRectMake(0, 0, 320, 46*5);
        [_moreview addSubview:image];
        [[UIApplication sharedApplication].keyWindow addSubview:_moreview];
        [self addViewright:_moreview];
    }
    return _moreview;
}
- (void)addViewright:(UIView*)rightView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, rightView.frame.size.width, rightView.frame.size.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    self.tableView = tableView;
    tableView.hidden = YES;
    [rightView addSubview:tableView];
    
    UIView *adView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rightView.frame.size.width, rightView.frame.size.height)];
    self.adView = adView;
    adView.hidden = YES;
    [rightView addSubview:adView];
    
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBackgroundColor:[UIColor blackColor]];
    topView.alpha = 0.7;
    self.topView = topView;
    [adView addSubview:topView];
    

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(20, 5, 40, 20);
    [button addTarget:self action:@selector(riqiwancheng:) forControlEvents:UIControlEventTouchUpInside];
    self.wanchengbutton = button;
    [topView addSubview:button];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button1 setTitle:@"清空" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button1.frame = CGRectMake(320-60, 5, 40, 20);
    [button1 addTarget:self action:@selector(riqiwancheng:) forControlEvents:UIControlEventTouchUpInside];
    self.qingkongbutton = button1;
    [topView addSubview:button1];
    
    [adView addSubview:self.picker];
    
}
- (void)riqiwancheng:(UIButton*)button
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    if (button.tag == 11) {
        [Global shared].zaoshijian = [dateFormatter stringFromDate:[self.picker date]];
        UIButton* button = (UIButton*)[self viewWithTag:7];
        [button setTitle:[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[self.picker date]]] forState:UIControlStateNormal];
    }else if (button.tag == 22){
        [Global shared].wanshijian = [dateFormatter stringFromDate:[self.picker date]];
        UIButton* button = (UIButton*)[self viewWithTag:8];
        [button setTitle:[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[self.picker date]]] forState:UIControlStateNormal];
    }else if (button.tag == 111){
        [Global shared].zaoshijian = @"";
        UIButton* button = (UIButton*)[self viewWithTag:7];
        [button setTitle:@"全部" forState:UIControlStateNormal];
    }else if (button.tag == 222){
        [Global shared].wanshijian = @"";
        UIButton* button = (UIButton*)[self viewWithTag:8];
        [button setTitle:@"全部" forState:UIControlStateNormal];
    }
    self.oneView.hidden = YES;
    self.twoView.hidden = YES;
    self.threeView.hidden = YES;
    self.moreview.hidden = YES;
}
- (UIView*)oneView
{
    if (_oneView == nil) {
        
        _oneView = [[UIView alloc] initWithFrame:CGRectMake(88+20, 44+20+34+32+10, 185, 46*5)];
        UIImageView* imageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"setting_list_bg.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        imageView.frame = CGRectMake(0, 0, _oneView.frame.size.width, _oneView.frame.size.height);
        _oneView.hidden = YES;
        [_oneView addSubview:imageView];
        [[UIApplication sharedApplication].keyWindow addSubview:_oneView];
          
        NSArray *arrary = [[NSArray alloc] initWithObjects:@"0-3000",@"3000-4000",@"4000-5000",@"5000及以上",@"全部", nil];
        
        for (int i = 0 ; i < [arrary count]; i++) {
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 46*i , 185, 46)];
            lable.backgroundColor = [UIColor clearColor];
            lable.textColor = [UIColor whiteColor];
            lable.textAlignment = 1;
            lable.text = [NSString stringWithFormat:@"%@",[arrary objectAtIndex:i]];
            lable.userInteractionEnabled = YES;
            [_oneView addSubview:lable];
            
            
            if (i != 0 ) {
                UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"setting_cell_sep.png"]];
                image.frame = CGRectMake(0, 46*i-2, 185, 2);
                [_oneView addSubview:image];
            }
            
            UIControl* control = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, lable.frame.size.width, lable.frame.size.height)];
            [control addTarget:self action:@selector(againToSetbuttonTitle:) forControlEvents:UIControlEventTouchUpInside];
            control.tag = i;
            [lable addSubview:control];
            
            
        }
        
        
    }
    return _oneView;
}

- (UIView*)twoView
{
    if (_twoView == nil) {
        
        _twoView = [[UIView alloc] initWithFrame:CGRectMake(318+60, 44+20+34+32+10, 185, 46*6)];
        UIImageView* imageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"setting_list_bg.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        imageView.frame = CGRectMake(0, 0, _twoView.frame.size.width, _twoView.frame.size.height);
        _twoView.hidden = YES;
        [_twoView addSubview:imageView];
        [[UIApplication sharedApplication].keyWindow addSubview:_twoView];
        
        NSArray *arrary = [[NSArray alloc] initWithObjects:@"1天",@"2天",@"3天",@"4天",@"5天以上",@"全部", nil];
        
        for (int i = 0 ; i < [arrary count]; i++) {
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(15, 46*i , 185, 46)];
            lable.backgroundColor = [UIColor clearColor];
            lable.textColor = [UIColor whiteColor];
            lable.textAlignment = 0;
            lable.text = [NSString stringWithFormat:@"%@",[arrary objectAtIndex:i]];
            lable.userInteractionEnabled = YES;
            [_twoView addSubview:lable];
            
            
            if (i != 0 ) {
                UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"setting_cell_sep.png"]];
                image.frame = CGRectMake(0, 46*i-2, 185, 2);
                [_twoView addSubview:image];
            }
            
            UIControl* control = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, lable.frame.size.width, lable.frame.size.height)];
            [control addTarget:self action:@selector(againToSetbuttonTitle1:) forControlEvents:UIControlEventTouchUpInside];
            control.tag = i;
            [lable addSubview:control];
            
            
        }
        
    }
    return _twoView;
}
- (UIView*)threeView
{
    if (_threeView == nil) {
        
        _threeView = [[UIView alloc] initWithFrame:CGRectMake(585+20,44+20+ 34+32+10, 185, 46*4)];
        UIImageView* imageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"setting_list_bg.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        imageView.frame = CGRectMake(0, 0, _threeView.frame.size.width, _threeView.frame.size.height);
        _threeView.hidden = YES;
        [_threeView addSubview:imageView];
        [[UIApplication sharedApplication].keyWindow addSubview:_threeView];
        
        NSArray *arrary = [[NSArray alloc] initWithObjects:@"周边旅游",@"国内旅游",@"境外旅游",@"全部", nil];
        
        for (int i = 0 ; i < [arrary count]; i++) {
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(15, 46*i , 185, 46)];
            lable.backgroundColor = [UIColor clearColor];
            lable.textColor = [UIColor whiteColor];
            lable.textAlignment = 0;
            lable.text = [NSString stringWithFormat:@"%@",[arrary objectAtIndex:i]];
            lable.userInteractionEnabled = YES;
            [_threeView addSubview:lable];
            
            
            if (i != 0 ) {
                UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"setting_cell_sep.png"]];
                image.frame = CGRectMake(0, 46*i-2, 185, 2);
                [_threeView addSubview:image];
            }
            
            UIControl* control = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, lable.frame.size.width, lable.frame.size.height)];
            [control addTarget:self action:@selector(againToSetbuttonTitle2:) forControlEvents:UIControlEventTouchUpInside];
            control.tag = i;
            [lable addSubview:control];
            
            
        }
        
    }
    return _threeView;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *xibs = [[NSBundle mainBundle] loadNibNamed:@"ShaiXuan" owner:self options:nil];
        self = (UIView*)[xibs objectAtIndex:0];
//        [TXASIHttp ytxASIHTTPRequest:@"ipad_queryArea.action" viewController:self parm:nil];
    }
    return self;
}
- (void)againToSetbuttonTitle:(id)sender
{
    UIButton* but = (UIButton*)sender;
   UIButton* button = (UIButton*)[self viewWithTag:1];
    NSArray *arrary = [[NSArray alloc] initWithObjects:@"0-3000",@"3000-4000",@"4000-5000",@"5000-50000", @"全部",nil];
    [button setTitle:[NSString stringWithFormat:@"%@",[arrary objectAtIndex:but.tag]] forState:UIControlStateNormal];
     NSArray *arrary1 = [[NSArray alloc] initWithObjects:@"0-3000",@"3000-4000",@"4000-5000",@"5000-50000", @"0-500000",nil];
    [Global shared].ss1 = [NSString stringWithFormat:@"%@",[arrary1 objectAtIndex:but.tag]];
    self.oneView.hidden = YES;
    self.twoView.hidden = YES;
    self.threeView.hidden = YES;
    self.moreview.hidden = YES;
}
- (void)againToSetbuttonTitle1:(id)sender
{
    UIButton* but = (UIButton*)sender;
    UIButton* button = (UIButton*)[self viewWithTag:2];
    NSArray *arrary = [[NSArray alloc] initWithObjects:@"1天",@"2天",@"3天",@"4天",@"5天以上",@"全部" ,nil];
    [button setTitle:[NSString stringWithFormat:@"%@",[arrary objectAtIndex:but.tag]] forState:UIControlStateNormal];
    NSArray *arrary1 = [[NSArray alloc] initWithObjects:@"0-1",@"0-2",@"0-3",@"0-4",@"5-30",@"0-365",nil];
    [Global shared].ss2 = [NSString stringWithFormat:@"%@",[arrary1 objectAtIndex:but.tag]];
    self.oneView.hidden = YES;
    self.twoView.hidden = YES;
    self.threeView.hidden = YES;
     self.moreview.hidden = YES;
}
- (void)againToSetbuttonTitle2:(id)sender
{
    UIButton* but = (UIButton*)sender;
    UIButton* button = (UIButton*)[self viewWithTag:3];
    NSArray *arrary = [[NSArray alloc] initWithObjects:@"周边旅游",@"国内旅游",@"境外旅游",@"全部", nil];
    [button setTitle:[NSString stringWithFormat:@"%@",[arrary objectAtIndex:but.tag]] forState:UIControlStateNormal];
    NSArray *arrary1 = [[NSArray alloc] initWithObjects:@"1",@"2",@"4",@"", nil];
    [Global shared].ss3 = [NSString stringWithFormat:@"%@",[arrary1 objectAtIndex:but.tag]];
    self.oneView.hidden = YES;
    self.twoView.hidden = YES;
    self.threeView.hidden = YES;
     self.moreview.hidden = YES;
}

- (IBAction)xianshiheikuang:(id)sender
{
    UIButton *button = (UIButton*)sender;

    switch (button.tag) {
        case 1:
            self.oneView.hidden = NO;
            self.twoView.hidden = YES;
            self.threeView.hidden = YES;
            self.moreview.hidden = YES;
            break;
        case 2:
            self.oneView.hidden = YES;
            self.twoView.hidden = NO;
            self.threeView.hidden = YES;
            self.moreview.hidden = YES;
            break;
        case 3:
            self.oneView.hidden = YES;
            self.twoView.hidden = YES;
            self.threeView.hidden = NO;
            self.moreview.hidden = YES;
            break;
            
        case 4:
        {
            [Global shared].yuefen = @"";
            self.zongArr = nil;
            self.zongArr = self.yuefenArr;
            [self.tableView reloadData];
            self.oneView.hidden = YES;
            self.twoView.hidden = YES;
            self.threeView.hidden = YES;
            self.moreview.hidden = NO;
            self.tableView.hidden = NO;
            self.adView.hidden = YES;
            CGRect fram = self.moreview.frame;
            fram.origin.x = self.oneView.frame.origin.x+597;
            fram.origin.y = self.oneView.frame.origin.y;
            self.moreview.frame = fram;
        }
            break;
        case 5:
        {
            [Global shared].leixing = @"";
            self.zongArr = nil;
            self.zongArr = self.leixingArr;
            [self.tableView reloadData];
            self.oneView.hidden = YES;
            self.twoView.hidden = YES;
            self.threeView.hidden = YES;
            self.moreview.hidden = NO;
            self.tableView.hidden = NO;
            self.adView.hidden = YES;
            CGRect fram = self.moreview.frame;
            fram.origin.x = self.oneView.frame.origin.x;
            fram.origin.y = self.oneView.frame.origin.y+80;
            self.moreview.frame = fram;
        }
            break;
        case 6:
        {
            [Global shared].guojia = @"";
            self.zongArr = nil;
            self.zongArr = self.guojiaArr;
//            [self.tableView reloadData];
            self.oneView.hidden = YES;
            self.twoView.hidden = YES;
            self.threeView.hidden = YES;
//            self.moreview.hidden = NO;
//            self.tableView.hidden = NO;
            self.adView.hidden = YES;
//            CGRect fram = self.moreview.frame;
//            fram.origin.x = self.threeView.frame.origin.x;
//            fram.origin.y = self.threeView.frame.origin.y+80;
//            self.moreview.frame = fram;
            GuoJiaListViewController *list = [[GuoJiaListViewController alloc] init];
            list.zongArr = self.zongArr;
            list.subView = self;
            [list shuaxintabView];
            [[UIApplication sharedApplication].keyWindow addSubview:list.view];
        }
            break;
        case 7:
        {
            self.oneView.hidden = YES;
            self.twoView.hidden = YES;
            self.threeView.hidden = YES;
            self.moreview.hidden = NO;
            self.tableView.hidden = YES;
            self.adView.hidden = NO;
            CGRect fram = self.moreview.frame;
            fram.origin.x = self.twoView.frame.origin.x-50;
            fram.origin.y = self.twoView.frame.origin.y+80;
            self.moreview.frame = fram;
            self.wanchengbutton.tag = 11;
            self.qingkongbutton.tag = 111;
        }
            break;
        case 8:
        {
            self.oneView.hidden = YES;
            self.twoView.hidden = YES;
            self.threeView.hidden = YES;
            self.moreview.hidden = NO;
            self.tableView.hidden = YES;
            self.adView.hidden = NO;
            CGRect fram = self.moreview.frame;
            fram.origin.x = self.twoView.frame.origin.x+50;
            fram.origin.y = self.twoView.frame.origin.y+80;
            self.moreview.frame = fram;
            self.wanchengbutton.tag = 22;
            self.qingkongbutton.tag = 222;
        }
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
    cell.textLabel.textColor = [UIColor lightGrayColor];
    
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
            UIButton* button = (UIButton*)[self viewWithTag:4];
            [button setTitle:[NSString stringWithFormat:@"全部"] forState:UIControlStateNormal];
            [Global shared].yuefen = @"";
        }else{
            [Global shared].yuefen = [NSString stringWithFormat:@"%d",indexPath.row+1];//[self.zongArr objectAtIndex:indexPath.row];
            UIButton* button = (UIButton*)[self viewWithTag:4];
            [button setTitle:[NSString stringWithFormat:@"%@",[self.zongArr objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
        
        }

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
        if (indexPath.row == 2) {
            str = @"";
        }
        [Global shared].leixing = str;
        UIButton* button = (UIButton*)[self viewWithTag:5];
        [button setTitle:[NSString stringWithFormat:@"%@",[self.zongArr objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    }else {  // 国家
        [Global shared].guojia = [self.zongArr objectAtIndex:indexPath.row];
        UIButton* button = (UIButton*)[self viewWithTag:6];
        [button setTitle:[NSString stringWithFormat:@"%@",[self.zongArr objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    }
    self.oneView.hidden = YES;
    self.twoView.hidden = YES;
    self.threeView.hidden = YES;
    self.moreview.hidden = YES;
    
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


@end
