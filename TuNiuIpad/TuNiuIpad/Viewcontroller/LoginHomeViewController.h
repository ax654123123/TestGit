//
//  LoginHomeViewController.h
//  TuNiuIpad
//
//  Created by tengxiangyin on 13-10-25.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginHomeViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *loginUserTextField;
@property (nonatomic, strong) IBOutlet UITextField *loginPassWordTextField;

@property (nonatomic, assign) BOOL isPopToHome;
@property (nonatomic, weak) id delegate;

//@property (nonatomic, strong) IBOutlet UIButton *dengluPress;
//@property (nonatomic, strong) IBOutlet UIButton *chongzhiPress;

- (IBAction)dengluPress:(id)sender;
- (IBAction)chongzhiPress:(id)sender;
@end
