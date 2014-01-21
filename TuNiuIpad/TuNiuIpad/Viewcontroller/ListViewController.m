//
//  ListViewController.m
//  TuNiuIpad
//
//  Created by tengxiangyin on 13-7-1.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//

#import "ListViewController.h"
#import "DetailsViewController.h"
#import "TXASIHttp.h"
#import "SearchBar.h"
@interface ListViewController ()
@property (strong, nonatomic) SearchBar* titleView;
@end

@implementation ListViewController
@synthesize numberAre = _numberAre;
@synthesize tableView = _tableView;
@synthesize alinkMutableArrary = _alinkMutableArrary;
@synthesize titleMutableArrary = _titleMutableArrary;
@synthesize picMutableArrary = _picMutableArrary;
@synthesize leastpriceMutableArrary = _leastpriceMutableArrary;
@synthesize isSearch = _isSearch;
@synthesize keyWord = _keyWord;

#pragma mark button响应方法
- (void)GoBack:(id)sender
{
    [self.titleView quxiaoyemian];
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)GoToDelite:(id)sender
{
    UIControl *con = (UIControl*)sender;
    if (con.tag < [self.alinkMutableArrary count]) {
        NSString *alineid = [self.alinkMutableArrary objectAtIndex:con.tag];
        DetailsViewController *detail = [[DetailsViewController alloc] init];
        detail.alinkId = alineid;
        detail.isSearchInto = NO;
        [self.navigationController pushViewController:detail animated:YES];
    }
    
    
}
#pragma mark loadview
- (void)clickNav
{
    
    [self setBackButton];
//    NSArray *arrary = [NSArray arrayWithObjects:@"周边旅游精选",@"国内旅游精选",@"出境旅游精选", nil];
//    UIView* titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
//    UILabel* title_lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
//    title_lable.backgroundColor = [UIColor clearColor];
//    title_lable.text = [arrary objectAtIndex:self.numberAre];
//    [title_lable setTextColor:[UIColor whiteColor]];
//    [title_lable setTextAlignment:UITextAlignmentCenter];
//    [title_lable setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:20]];
//    [titleView addSubview:title_lable];
//    self.navigationItem.titleView = titleView;
    SearchBar* titleView = [[SearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    self.titleView = titleView;
    self.navigationItem.titleView = titleView;
}
#pragma mark 系统方法
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)loadView
{
    [super loadView];
    [self clickNav];
    if (self.isSearch) {
        NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
        NSString *cleanString = [self.keyWord stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (cleanString.length > 0) {
            [parm setValue:cleanString forKey:@"KeyWords"];
        }
        if (![[Global shared].ss1 isEqualToString:@""] && [Global shared].ss1 != nil) {
            [parm setValue:[Global shared].ss1 forKey:@"price"];
        }
        if (![[Global shared].ss2 isEqualToString:@""] && [Global shared].ss2 != nil) {
            [parm setValue:[Global shared].ss2 forKey:@"traveldate"];
        }
        if (![[Global shared].ss3 isEqualToString:@""] && [Global shared].ss3 != nil) {
            [parm setValue:[Global shared].ss3 forKey:@"isnative"];
        }
        [TXASIHttp ytxASIHTTPRequest:@"ipad_queryTourLine.action" viewController:self parm:parm];
    }else{
        NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
        if (self.numberAre == 2) {
            [parm setValue:[NSString stringWithFormat:@"%d",self.numberAre+2] forKey:@"isnative"];
        }else{
            
            [parm setValue:[NSString stringWithFormat:@"%d",self.numberAre+1] forKey:@"isnative"];
        }
        [TXASIHttp ytxASIHTTPRequest:@"ipad_queryTourLine.action" viewController:self parm:parm];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_bg"]];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(15, 15, self.view.frame.size.width-30, self.view.frame.size.height-44-30) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:240.0/255.0 blue:235.0/255.0 alpha:1.0];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"加载中...";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    self.tableView = nil;
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-30, 60)];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake((view.frame.size.width-196)/2+10, 10, 196, 46)];
    image.image = [UIImage imageNamed:@"sort_section_center_bg.png"];
    [view addSubview:image];
    
    UIView *lineview = nil;
    
    
    for (int i = 0; i < 4; i ++) {
        if (i < 2) {
            lineview = [[UIView alloc] initWithFrame:CGRectMake(10, 34 + i*4, 240, 1)];
        }else{
            lineview = [[UIView alloc] initWithFrame:CGRectMake(498, 34 + (i-2)*4, 240, 1)];
        }
        lineview.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:lineview];
    }
    
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 196, 43)];
    lable.backgroundColor = [UIColor clearColor];
    lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    lable.textColor = [UIColor whiteColor];
    lable.textAlignment = 1;
    [image addSubview:lable];
    if (section == 0) {
        lable.text = @"本周热销产品";
    }else{
        lable.text = @"近期推荐产品";
    }
    
    return view;
}
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
#pragma mark - ASIHTTPRequest
- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSDictionary *dic =  [TXASIHttp requestJson:request];
    
    NSLog(@"ASIHTTPRequest-----------%@",dic);
    if ([[dic objectForKey:@"status"] isEqualToString:@"1"]) {
        
        NSMutableArray* picMutableArrary = [[NSMutableArray alloc] init];
        NSMutableArray* titleMutableArrary = [[NSMutableArray alloc] init];
        NSMutableArray* alinkMutableArrary = [[NSMutableArray alloc] init];
        NSMutableArray* leastpriceMutableArrary = [[NSMutableArray alloc] init];
            
            NSArray *arrary = [dic objectForKey:@"value"];
            for (NSDictionary *litDictionary in arrary){
                
                NSString * picuri = [litDictionary objectForKey:@"spotviewpic"];
                NSString * picurl = [NSString stringWithFormat:@"http://ipad.htyou.com/%@",picuri];
                [picMutableArrary addObject:picurl];
                
                NSString * text = [litDictionary objectForKey:@"tourproname"];
                [titleMutableArrary addObject:text];
                
                
                NSString * alink = [litDictionary objectForKey:@"lineid"];
                [alinkMutableArrary addObject:alink];
                
                NSString * leastprice = [litDictionary objectForKey:@"leastprice"];
                [leastpriceMutableArrary addObject:leastprice];
                
                
            }

        self.titleMutableArrary = titleMutableArrary;
        self.picMutableArrary = picMutableArrary;
        self.alinkMutableArrary = alinkMutableArrary;
        self.leastpriceMutableArrary = leastpriceMutableArrary;
        [self.tableView reloadData];
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

- (void)requestFailed:(ASIHTTPRequest *)request

{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

@end
