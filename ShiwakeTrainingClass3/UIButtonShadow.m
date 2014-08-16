//
//  UIButtonShadow.m
//  ShiwakeTrainingClass3
//
//  Created by Hiroaki Fujisawa on 2012/10/21.
//  Copyright (c) 2012年 Hiroaki Fujisawa. All rights reserved.
//

#import "UIButtonShadow.h"
#import <QuartzCore/QuartzCore.h>


@implementation UIButtonShadow

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code

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


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
	// Drawing code
	[[self layer] setBorderColor:[[UIColor darkGrayColor] CGColor]];
	[[self layer] setBorderWidth:2.0];
	
	[[self layer] setCornerRadius:10.0];
	[self setClipsToBounds:YES];
	
	[[self layer] setShadowOpacity:0.4];
	[[self layer] setShadowOffset:CGSizeMake(15.0, 15.0)];

	CGFloat fontSize = self.frame.size.height * 0.35;
	self.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:fontSize];
	self.titleLabel.adjustsFontSizeToFitWidth = YES;
	self.contentEdgeInsets = UIEdgeInsetsMake(fontSize / 2, 0.0f, 0.0f, 0.0f);
	
	[self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal]; //有効時
	[self setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted]; //ハイライト時
	[self setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled]; //無効時
	
	[self setBackgroundColor:[UIColor darkGrayColor] forState:UIControlStateNormal]; //有効時
	[self setBackgroundColor:[UIColor grayColor] forState:UIControlStateHighlighted]; //ハイライト時
	// [self setBackgroundColor:[UIColor grayColor] forState:UIControlStateDisabled]; //無効時
}


@end
