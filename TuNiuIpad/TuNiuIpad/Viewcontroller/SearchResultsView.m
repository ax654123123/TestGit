//
//  SearchResultsView.m
//  TuNiuIpad
//
//  Created by tengxiangyin on 13-7-3.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//
#import "DetailsViewController.h"
#import "SearchResultsView.h"

@implementation SearchResultsView
@synthesize alinkMutableArrary = _alinkMutableArrary;
@synthesize titleMutableArrary = _titleMutableArrary;
@synthesize picMutableArrary = _picMutableArrary;
@synthesize leastpriceMutableArrary = _leastpriceMutableArrary;
@synthesize tableView = _tableView;
//@synthesize tuniuview = _tuniuview;
//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//        self.view.alpha = 0.5;
//        self.view.backgroundColor = [UIColor blackColor];
//        [[UIApplication sharedApplication].keyWindow addSubview:self.view];
//        [self buildTableView];
//    }
//    return self;
//}
- (void)loadView
{
    [super loadView];
//    self.view.alpha = 0.5;
    self.view.backgroundColor = [UIColor whiteColor];
//    [[UIApplication sharedApplication].keyWindow addSubview:self.view];
    
   // self.view.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:240.0/255.0 blue:235.0/255.0 alpha:1.0];

    [self buildTableView];

}
- (void)viewDidLoad
{

    [super viewDidLoad];
}
- (void)qingqiuwangluo
{
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    TuNiuIpadAppDelegate* dele = [UIApplication sharedApplication].delegate;
    
    
    if (![[Global shared].ss1 isEqualToString:@""] && [Global shared].ss1 != nil) {
        [parm setValue:[Global shared].ss1 forKey:@"price"];
    }
    if (![[Global shared].ss2 isEqualToString:@""] && [Global shared].ss2 != nil) {
        [parm setValue:[Global shared].ss2 forKey:@"traveldate"];
    }
    if (![[Global shared].ss3 isEqualToString:@""] && [Global shared].ss3 != nil) {
        [parm setValue:[Global shared].ss3 forKey:@"isnative"];
    }
    if (![[Global shared].yuefen isEqualToString:@""] && [Global shared].yuefen != nil && ![[Global shared].yuefen isEqualToString:@"全部"]) {
        [parm setValue:[Global shared].yuefen forKey:@"month"];
    }
    if (![[Global shared].leixing isEqualToString:@""] && [Global shared].leixing != nil && ![[Global shared].leixing isEqualToString:@"全部"]) {
        [parm setValue:[Global shared].leixing forKey:@"tourtype"];
    }
    if (![[Global shared].guojia isEqualToString:@""] && [Global shared].guojia != nil) {
        [parm setValue:[Global shared].guojia forKey:@"area"];
    }
    if (![[Global shared].zaoshijian isEqualToString:@""] && [Global shared].zaoshijian != nil) {
        [parm setValue:[Global shared].zaoshijian forKey:@"tourstartdate"];
    }
    if (![[Global shared].wanshijian isEqualToString:@""] && [Global shared].wanshijian != nil) {
        [parm setValue:[Global shared].wanshijian forKey:@"tourenddate"];
    }
    if (![dele.keyWord isEqualToString:@""] && dele.keyWord != nil && ![dele.keyWord isEqualToString:@" "]) {
        NSString *cleanString = [dele.keyWord stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (cleanString.length > 0) {
            [parm setValue:cleanString forKey:@"KeyWords"];
        }
    }
    [TXASIHttp ytxASIHTTPRequest:@"ipad_queryTourLine.action" viewController:self parm:parm];
}
- (void)buildTableView
{
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    TuNiuIpadAppDelegate* dele = [UIApplication sharedApplication].delegate;
    
    if (![[Global shared].ss1 isEqualToString:@""] && [Global shared].ss1 != nil) {
        [parm setValue:[Global shared].ss1 forKey:@"price"];
    }
    if (![[Global shared].ss2 isEqualToString:@""] && [Global shared].ss2 != nil) {
        [parm setValue:[Global shared].ss2 forKey:@"traveldate"];
    }
    if (![[Global shared].ss3 isEqualToString:@""] && [Global shared].ss3 != nil) {
        [parm setValue:[Global shared].ss3 forKey:@"isnative"];
    }
    if (![[Global shared].yuefen isEqualToString:@""] && [Global shared].yuefen != nil && ![[Global shared].yuefen isEqualToString:@"全部"]) {
        [parm setValue:[Global shared].yuefen forKey:@"month"];
    }
    if (![[Global shared].leixing isEqualToString:@""] && [Global shared].leixing != nil && ![[Global shared].leixing isEqualToString:@"全部"]) {
        [parm setValue:[Global shared].leixing forKey:@"tourtype"];
    }
    if (![[Global shared].guojia isEqualToString:@""] && [Global shared].guojia != nil) {
        [parm setValue:[Global shared].guojia forKey:@"area"];
    }
    
    if (![dele.keyWord isEqualToString:@""] && dele.keyWord != nil && ![dele.keyWord isEqualToString:@" "]) {
       NSString *cleanString = [dele.keyWord stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (cleanString.length > 0) {
            [parm setValue:cleanString forKey:@"KeyWords"];
        }
        [TXASIHttp ytxASIHTTPRequest:@"ipad_queryTourLine.action" viewController:self parm:parm];
    }
    
    
    
    UITableView *tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(15, 15, self.view.frame.size.width-30, self.view.frame.size.height-44-30-20) style:UITableViewStylePlain];
    tableView1.delegate = self;
    tableView1.dataSource = self;
    tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView1.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:240.0/255.0 blue:235.0/255.0 alpha:1.0];
    self.tableView = tableView1;
    [self.view addSubview:tableView1];

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
    if (section == 0) {
        if ([self.titleMutableArrary count] != 0) {
            if ([self.titleMutableArrary count]%3 == 0) {
                
                return [self.titleMutableArrary count]/3;
                
            }else if ([self.titleMutableArrary count]%3 == 1){
                
                return [self.titleMutableArrary count]/3 + 1;
                
            }else if ([self.titleMutableArrary count]%3 == 2){
                
                return [self.titleMutableArrary count]/3 + 1;
                
            }else
                return 0;
        }
        
    }
    return  0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float cellheight = 190;
    
    
    return cellheight;
}


//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-30, 60)];
//    view.backgroundColor = [UIColor whiteColor];
//    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake((view.frame.size.width-196)/2+10, 10, 196, 46)];
//    image.image = [UIImage imageNamed:@"sort_section_center_bg.png"];
//    [view addSubview:image];
//    
//    UIView *lineview = nil;
//    
//    
//    for (int i = 0; i < 4; i ++) {
//        if (i < 2) {
//            lineview = [[UIView alloc] initWithFrame:CGRectMake(10, 34 + i*4, 240, 1)];
//        }else{
//            lineview = [[UIView alloc] initWithFrame:CGRectMake(498, 34 + (i-2)*4, 240, 1)];
//        }
//        lineview.backgroundColor = [UIColor lightGrayColor];
//        [view addSubview:lineview];
//    }
//    
//    
//    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 196, 43)];
//    lable.backgroundColor = [UIColor clearColor];
//    lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
//    lable.textColor = [UIColor whiteColor];
//    lable.textAlignment = 1;
//    [image addSubview:lable];
//    if (section == 0) {
//        lable.text = @"本周热销产品";
//    }else{
//        lable.text = @"近期推荐产品";
//    }
//    
//    return view;
//}
- (void)buildCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexPath
{
    for (int i = 1; i < 4; i ++) {
        
        HJManagedImageV *image = [[HJManagedImageV alloc] initWithFrame:CGRectMake(245*(i-1) +10 , 10, 230, 129)];
        image.userInteractionEnabled = YES;
        
        image.tag = 999 +i ;
        
        [cell addSubview:image];
        
        
        
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(245*(i-1) +10, 150, 230, 40)];
        lable.backgroundColor = [UIColor clearColor];
        lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        lable.textColor = [UIColor lightGrayColor];
        lable.numberOfLines = 2;
        lable.tag = 99999 + i;
        [cell addSubview:lable];
        
        UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(245*(i-1) +10 + 125, 105, 100, 30)];
        lable1.backgroundColor = [UIColor orangeColor];
        lable1.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        lable1.textColor = [UIColor whiteColor];
        lable1.numberOfLines = 1;
        lable1.tag = 8888 + i;
        [cell addSubview:lable1];
        
    }
    
    
}
- (void)onClickcell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexPath
{
    
    
    for (int i = 1; i < 4; i ++) {
        if ((indexPath.row * 3) + (i - 1) < [self.picMutableArrary count]) {
            NSString *url = [self.picMutableArrary objectAtIndex:(indexPath.row * 3) + (i - 1)];
            HJManagedImageV* image = (HJManagedImageV*)[cell viewWithTag:999 +i ];
            image.hidden = NO;
            [HJImageUtility queueLoadImageFromUrl:url imageView:image];
            NSLog(@"HJManagedImageV == %@",url);
            
            UIControl* control = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, image.frame.size.width, image.frame.size.height)];
            [control addTarget:self action:@selector(GoToDelite:) forControlEvents:UIControlEventTouchUpInside];
            control.tag = (indexPath.row * 3) + (i-1);
            [image addSubview:control];
            
            UILabel* lable = (UILabel*)[cell viewWithTag:99999 +i ];
            lable.hidden = NO;
            lable.text = [self.titleMutableArrary objectAtIndex:(indexPath.row * 3) + (i - 1)];
            
            UILabel* lable1 = (UILabel*)[cell viewWithTag:8888 +i ];
            lable1.hidden = NO;
            lable1.text = [NSString stringWithFormat:@"￥ %@",[self.leastpriceMutableArrary objectAtIndex:(indexPath.row * 3) + (i - 1)]] ;
        }else {
            HJManagedImageV* image = (HJManagedImageV*)[cell viewWithTag:999 +i ];
            image.hidden = YES;
            UILabel* lable = (UILabel*)[cell viewWithTag:99999 +i ];
            lable.hidden = YES;
            
            UILabel* lable1 = (UILabel*)[cell viewWithTag:8888 +i ];
            lable1.hidden = YES;
        }
        
    }
}
- (UITableViewCell*)contructRow:(UITableView*)tableview indexPath:(NSIndexPath*)indexPath
{
    static NSString *CellIdentifierSection = @"contructRow";
    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:CellIdentifierSection];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierSection];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        [self buildCell:cell indexPath:indexPath];
        
    }
    
    [self onClickcell:cell indexPath:indexPath];
    
    return cell;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell =nil;
    cell = [self contructRow:tableView indexPath:indexPath];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
- (void)GoToDelite:(id)sender
{
    UIControl *con = (UIControl*)sender;
    if (con.tag < [self.alinkMutableArrary count]) {
        NSString *alineid = [self.alinkMutableArrary objectAtIndex:con.tag];
        DetailsViewController *detail = [[DetailsViewController alloc] init];
        detail.alinkId = alineid;
        detail.isSearchInto = YES;
        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:detail];
        
        [self presentModalViewController:nav animated:YES];
    }
    
    
}
#pragma mark - ASIHTTPRequest
- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSDictionary *dic =  [TXASIHttp requestJson:request];
    
    NSLog(@"ASIHTTPRequest-----------%@",dic);
    if ([[dic objectForKey:@"status"] isEqualToString:@"1"]) {
        
        NSMutableArray* picMutableArrary1 = [[NSMutableArray alloc] init];
        NSMutableArray* titleMutableArrary1 = [[NSMutableArray alloc] init];
        NSMutableArray* alinkMutableArrary1 = [[NSMutableArray alloc] init];
        NSMutableArray* leastpriceMutableArrary1 = [[NSMutableArray alloc] init];
        
        NSArray *arrary = [dic objectForKey:@"value"];
        for (NSDictionary *litDictionary in arrary){
            
            NSString * picuri = [litDictionary objectForKey:@"spotviewpic"];
            NSString * picurl = [NSString stringWithFormat:@"http://ipad.htyou.com/%@",picuri];
            [picMutableArrary1 addObject:picurl];
            
            NSString * text = [litDictionary objectForKey:@"tourproname"];
            [titleMutableArrary1 addObject:text];
            
            
            NSString * alink = [litDictionary objectForKey:@"lineid"];
            [alinkMutableArrary1 addObject:alink];
            
            NSString * leastprice = [litDictionary objectForKey:@"leastprice"];
            [leastpriceMutableArrary1 addObject:leastprice];
            
            
        }
        
        self.titleMutableArrary = titleMutableArrary1;
        self.picMutableArrary = picMutableArrary1;
        self.alinkMutableArrary = alinkMutableArrary1;
        self.leastpriceMutableArrary = leastpriceMutableArrary1;
        if (self.tableView) {
            [self.tableView reloadData];
        }else{
            UITableView *tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(15, 15, self.view.frame.size.width-30, self.view.frame.size.height-44-30-20) style:UITableViewStylePlain];
            tableView1.delegate = self;
            tableView1.dataSource = self;
            tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView1.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:240.0/255.0 blue:235.0/255.0 alpha:1.0];
            self.tableView = tableView1;
            [self.view addSubview:tableView1];
        }
        self.tableView.hidden = NO;
    }else{
        UIAlertView *ale = [[UIAlertView alloc] initWithTitle:@"提示" message:@"无该搜素条件的线路信息，请修改搜索条件" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [ale show];
        self.tableView.hidden = YES;
    
    }
    
    
}

- (void)requestFailed:(ASIHTTPRequest *)request

{
    
    
}

@end
