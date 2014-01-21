//
//  PlaceOrderView.h
//  TuNiuIpad
//
//  Created by snda on 13-7-7.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceOrderView : UIView
@property (strong, nonatomic) IBOutlet UIView *bookView;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UILabel *detileTitleLable;
- (IBAction)closeButton:(id)sender;
- (void)zhixing;
@end
