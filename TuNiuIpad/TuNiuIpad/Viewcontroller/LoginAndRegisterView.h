//
//  LongAndRegisterView.h
//  TuNiuIpad
//
//  Created by tengxiangyin on 13-7-4.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginAndRegisterView : UIView{

    IBOutlet UITextField* nameField;
    IBOutlet UITextField* passWordField;
    IBOutlet UITextField* zhucenameField;
    IBOutlet UITextField* zhucepassWordField;
    IBOutlet UIButton* wantPassWord;
    IBOutlet UIButton* loginButton;
    IBOutlet UIButton* registerButton;
    IBOutlet UIImageView* bgImageView;
}
@property (strong, nonatomic)  UITextField* nameField;
@property (strong, nonatomic)  UITextField* passWordField;
@property (strong, nonatomic)  UITextField* zhucenameField;
@property (strong, nonatomic)  UITextField* zhucepassWordField;
@property (strong, nonatomic)  UIButton* wantPassWord;
@property (strong, nonatomic)  UIButton* loginButton;
@property (strong, nonatomic)  UIButton* registerButton;
@property (strong, nonatomic)  UIImageView* bgImageView;
- (IBAction)zhuce:(id)sender;
- (IBAction)backToLogin:(id)sender;
- (IBAction)zhaohuiPassWord:(id)sender;
- (IBAction)login:(id)sender;
@end
