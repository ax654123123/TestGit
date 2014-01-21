//
//  PlaceOrderView.m
//  TuNiuIpad
//
//  Created by snda on 13-7-7.
//  Copyright (c) 2013年 tengxiangyin. All rights reserved.
//

#import "PlaceOrderView.h"

@implementation PlaceOrderView
@synthesize bookView;
@synthesize bgView;
@synthesize detileTitleLable;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *xibs = [[NSBundle mainBundle] loadNibNamed:@"PlaceOrder" owner:self options:nil];
        self = (UIView*)[xibs objectAtIndex:0];

    }
    return self;
}
- (void)aaaa
{
    
    [[self superview]exchangeSubviewAtIndex:0 withSubviewAtIndex:1];

}
- (IBAction)closeButton:(id)sender
{
    self.alpha = 0;
    [UIView beginAnimations:@"animationID" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(aaaa)];
    [UIView setAnimationDuration:0.8f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self cache:YES];//oglFlip, fromLeft

    [UIView commitAnimations];
}
- (void)zhixing
{
    self.alpha = 0;
    [UIView beginAnimations:@"animationID" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(aaaa)];
    [UIView setAnimationDuration:0.8f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self cache:YES];//oglFlip, fromLeft
    
    [UIView commitAnimations];
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
