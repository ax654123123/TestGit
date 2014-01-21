//
//  LongAndRegisterView.m
//  TuNiuIpad
//
//  Created by tengxiangyin on 13-7-4.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//

#import "LoginAndRegisterView.h"

@implementation LoginAndRegisterView
@synthesize nameField ;
@synthesize passWordField ;
@synthesize zhucenameField ;
@synthesize zhucepassWordField ;
@synthesize wantPassWord ;
@synthesize loginButton ;
@synthesize registerButton ;
@synthesize bgImageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray*xibs = [[NSBundle mainBundle] loadNibNamed:@"View" owner:self options:nil];
        self = (UIView*)[xibs objectAtIndex:0];
        self.frame = CGRectMake(0, 0, 768*2, 0);
        [self setClipsToBounds:YES];

        
    }
    return self;
}
- (IBAction)zhuce:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.frame = CGRectMake(-768, 0, self.frame.size.width, 200);
    [self.zhucenameField becomeFirstResponder];
    [UIView commitAnimations];

}
- (IBAction)backToLogin:(id)sender
{

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.frame = CGRectMake(0, 0, self.frame.size.width, 200);
    [self.nameField becomeFirstResponder];
    [UIView commitAnimations];

}
- (IBAction)zhaohuiPassWord:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"此功能暂未开发" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alert show];
}
- (IBAction)login:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"此功能暂未开发" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alert show];
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
