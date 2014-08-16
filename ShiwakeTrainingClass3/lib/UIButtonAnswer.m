//
//  UIButtonAnswer.m
//  ShiwakeTrainingClass3
//
//  Created by Hiroaki Fujisawa on 2012/11/05.
//  Copyright (c) 2012年 Hiroaki Fujisawa. All rights reserved.
//

#import "UIButtonAnswer.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIButtonAnswer

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
		m_bEmphasize = FALSE;
		self.powerOfword = 0.04;
	}
	return self;
}

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state
{
	CGRect buttonSize = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
	UIView *bgView = [[UIView alloc] initWithFrame:buttonSize];
	bgView.layer.cornerRadius = 5;
	bgView.clipsToBounds = true;
	bgView.backgroundColor = color;
	UIGraphicsBeginImageContext(self.frame.size);
	[bgView.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	[self setBackgroundImage:screenImage forState:state];
}

-(void)setHighlighted:(BOOL)value {
	[super setHighlighted:value];
	[self setNeedsDisplay];
}
-(void)setSelected:(BOOL)value {
	[super setSelected:value];
	[self setNeedsDisplay];
}

- (void) setEmphasize:(BOOL)flag
{
	m_bEmphasize = flag;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{

	[[self layer] setBorderColor:[[UIColor darkGrayColor] CGColor]];
	[[self layer] setBorderWidth:1.0];
	
	[[self layer] setCornerRadius:10.0];
	[self setClipsToBounds:YES];
	
	CGFloat screenHight = self.superview.frame.size.height;
	
	CGFloat fontSize = screenHight * self.powerOfword;
	self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:fontSize];
	self.titleLabel.adjustsFontSizeToFitWidth = YES;
	
	[self setTitleColor:[UIColor blackColor]	forState:UIControlStateNormal];
	[self setTitleColor:[UIColor darkGrayColor]	forState:UIControlStateHighlighted];
	[self setTitleColor:[UIColor lightGrayColor]forState:UIControlStateDisabled];
	
	CGContextRef c = UIGraphicsGetCurrentContext();
	CGFloat w = self.bounds.size.width;
	CGFloat h = self.bounds.size.height;
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextSaveGState(c);
	CGContextSetShouldAntialias(c, true);
	// CGGradientを生成する
	// 生成するためにCGColorSpaceと色データの配列が必要になるので適当に用意する
	CGFloat locations[2] = {0.0, 1.0};
	size_t num_locations = 2;
	CGGradientRef gradient;
	if (self.state & (UIControlStateSelected | UIControlStateHighlighted)) {
		CGFloat components[8] = {0.68, 0.68, 0.68, 1.0, 0.35, 0.35, 0.35, 1.0};
		gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, num_locations);
	} else {
			
		if ( m_bEmphasize == TRUE ) {
			CGFloat components[8] = {0.9, 0.7, 0.9, 1.0, 0.73, 0.53, 0.73, 1.0};
			gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, num_locations);
		} else {
			CGFloat components[8] = {0.9, 0.9, 0.9, 1.0, 0.73, 0.73, 0.73, 1.0};
			gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, num_locations);
		}
		
	}
	// 生成したCGGradientを描画する
	// 始点と終点を指定してやると、その間に直線的なグラデーションが描画される。
	CGPoint startPoint = CGPointMake(w/2, 0.0);
	CGPoint endPoint = CGPointMake(w/2, h-1);
	CGContextDrawLinearGradient(c, gradient, startPoint, endPoint, 0);
	CGContextRestoreGState(c);

	[super drawRect:rect];
	
	
	
}


@end
