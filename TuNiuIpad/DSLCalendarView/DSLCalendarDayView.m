/*
 DSLCalendarDayView.h
 
 Copyright (c) 2012 Dative Studios. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 * Neither the name of the author nor the names of its contributors may be used
 to endorse or promote products derived from this software without specific
 prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


#import "DSLCalendarDayView.h"
#import "NSDate+DSLCalendarView.h"


@interface DSLCalendarDayView ()

@end


@implementation DSLCalendarDayView {
    __strong NSCalendar *_calendar;
    __strong NSDate *_dayAsDate;
    __strong NSDateComponents *_day;
    __strong NSString *_labelText;
}


#pragma mark - Initialisation

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.backgroundColor = [UIColor whiteColor];
        _positionInWeek = DSLCalendarDayViewMidWeek;
    }
    
    return self;
}


#pragma mark Properties

- (void)setSelectionState:(DSLCalendarDayViewSelectionState)selectionState {
    _selectionState = selectionState;
    [self setNeedsDisplay];
}

- (void)setDay:(NSDateComponents *)day {
    _calendar = [day calendar];
    _dayAsDate = [day date];
    _day = nil;
    _labelText = [NSString stringWithFormat:@"\n%d", day.day]; //这里加

    TuNiuIpadAppDelegate *delegate = (TuNiuIpadAppDelegate*)[[UIApplication sharedApplication] delegate];
    for (int i = 0; i < [delegate.dateArrary count]; i ++) {
        NSString * str = [delegate.dateArrary objectAtIndex:i];
    
        NSString *year_str = [[str componentsSeparatedByString:@"-"] objectAtIndex:0];
     
        NSString *month_str = [[str componentsSeparatedByString:@"-"] objectAtIndex:1];
       
        NSString *day_str = [[str componentsSeparatedByString:@"-"] objectAtIndex:2];
    
        NSString *price = [delegate.priceArrary objectAtIndex:i];

        if (day.year == [year_str integerValue] && day.month == [month_str integerValue] && day.day == [day_str integerValue]) {
                    NSString *yuliu = nil;
                    if (i < [delegate.yuliuArrary count]) {
                     yuliu   = [delegate.yuliuArrary objectAtIndex:i];
                        NSLog(@"%d  %d",i,[delegate.yuliuArrary count]);
            
                    }
//            if (![yuliu isEqualToString:@"0"] && yuliu != nil){
//            
//            _labelText = [NSString stringWithFormat:@"   %d %@元%@", day.day,price,yuliu]; //这里加
//            
//            }else{
            _labelText = [NSString stringWithFormat:@"      %d\n位置：%@\n%@元", day.day,yuliu,price]; //这里加
//            }
        }
        
        
    }
    
}

- (NSDateComponents*)day {
    if (_day == nil) {
        _day = [_dayAsDate dslCalendarView_dayWithCalendar:_calendar];
    }
    
    return _day;
}

- (NSDate*)dayAsDate {
    return _dayAsDate;
}

- (void)setInCurrentMonth:(BOOL)inCurrentMonth {
    _inCurrentMonth = inCurrentMonth;
    [self setNeedsDisplay];
}


#pragma mark UIView methods

- (void)drawRect:(CGRect)rect {
    if ([self isMemberOfClass:[DSLCalendarDayView class]]) {
        // If this isn't a subclass of DSLCalendarDayView, use the default drawing
        [self drawBackground];
        [self drawBorders];
        [self drawDayNumber];
    }
}


#pragma mark Drawing

- (void)drawBackground {
    if (self.selectionState == DSLCalendarDayViewNotSelected) {
        if (self.isInCurrentMonth) {
            [[UIColor colorWithWhite:245.0/255.0 alpha:1.0] setFill];
        }
        else {
            [[UIColor colorWithWhite:225.0/255.0 alpha:1.0] setFill];
        }
        UIRectFill(self.bounds);
    }
    else {
        switch (self.selectionState) {
            case DSLCalendarDayViewNotSelected:
                break;
                
            case DSLCalendarDayViewStartOfSelection:
                [[[UIImage imageNamed:@"DSLCalendarDaySelection-left"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] drawInRect:self.bounds];
                break;
                
            case DSLCalendarDayViewEndOfSelection:
                [[[UIImage imageNamed:@"DSLCalendarDaySelection-right"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] drawInRect:self.bounds];
                break;
                
            case DSLCalendarDayViewWithinSelection:
                [[[UIImage imageNamed:@"DSLCalendarDaySelection-middle"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] drawInRect:self.bounds];
                break;
                
            case DSLCalendarDayViewWholeSelection:
                [[[UIImage imageNamed:@"DSLCalendarDaySelection-middle"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] drawInRect:self.bounds];
                break;
        }
    }
}

- (void)drawBorders {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 1.0);
    
    CGContextSaveGState(context);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:255.0/255.0 alpha:1.0].CGColor);
    CGContextMoveToPoint(context, 0.5, self.bounds.size.height - 0.5);
    CGContextAddLineToPoint(context, 0.5, 0.5);
    CGContextAddLineToPoint(context, self.bounds.size.width - 0.5, 0.5);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    if (self.isInCurrentMonth) {
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:205.0/255.0 alpha:1.0].CGColor);
    }
    else {
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:185.0/255.0 alpha:1.0].CGColor);
    }
    CGContextMoveToPoint(context, self.bounds.size.width - 0.5, 0.0);
    CGContextAddLineToPoint(context, self.bounds.size.width - 0.5, self.bounds.size.height - 0.5);
    CGContextAddLineToPoint(context, 0.0, self.bounds.size.height - 0.5);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

- (void)drawDayNumber {
    if (self.selectionState == DSLCalendarDayViewNotSelected) {
        [[UIColor colorWithWhite:66.0/255.0 alpha:1.0] set];
    }
    else {
        [[UIColor whiteColor] set];
    }
    
    UIFont *textFont = [UIFont boldSystemFontOfSize:12.0];
//    CGSize textSize = [_labelText sizeWithFont:textFont];
    
//    CGRect textRect = CGRectMake(ceilf(CGRectGetMidX(self.bounds) - (textSize.width / 2.0)), ceilf(CGRectGetMidY(self.bounds) - (textSize.height / 2.0)), textSize.width, textSize.height);
//    [_labelText drawInRect:textRect withFont:textFont];
    CGRect textRect = CGRectMake(ceilf(CGRectGetMidX(self.bounds) - (55 / 2.0)), ceilf(CGRectGetMidY(self.bounds) - (80 / 2.0)), 80, 80);
    UITextView *lable1 = [[UITextView alloc] init];
    lable1.text = _labelText;
//    lable1.numberOfLines = 3;
    lable1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Month Calendar Date Tile"]];
    lable1.editable = NO;
    lable1.font = textFont;
    lable1.frame = textRect;
    lable1.userInteractionEnabled = NO;
    if (_labelText.length > 3) {
        lable1.textColor = [UIColor redColor];
    }
    [self addSubview:lable1];
//    [lable1 drawTextInRect:textRect];
}

@end