//
//  GuoJiaListViewController.m
//  TuNiuIpad
//
//  Created by tengxiangyin on 13-11-18.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//

#import "GuoJiaListViewController.h"

@interface GuoJiaListViewController ()
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation GuoJiaListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024-44-20) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor whiteColor];
    self.tableView = tableView;
    [self.view addSubview:tableView];
}
- (void)shuaxintabView
{
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
    if (indexPath.row < [self.zongArr count]) {
        cell.textLabel.text = [self.zongArr objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [UIColor lightGrayColor];
    }

    
    return cell;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell =nil;
    cell = [self contructRow:tableView indexPath:indexPath];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     // 国家
        [Global shared].guojia = [self.zongArr objectAtIndex:indexPath.row];
        UIButton* button = (UIButton*)[self.subView viewWithTag:6];
        [button setTitle:[NSString stringWithFormat:@"%@",[self.zongArr objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
        [self.view removeFromSuperview];
    
}
@end
