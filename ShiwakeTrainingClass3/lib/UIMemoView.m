//
//  UIMemoView.m
//  ShiwakeTrainingClass3
//
//  Created by Hiroaki Fujisawa on 2012/12/27.
//  Copyright (c) 2012年 Hiroaki Fujisawa. All rights reserved.
//

#import "UIMemoView.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIMemoView

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
		[self initFirstDisplay];
	}
	return self;
}

// *****************************************************************
//	@brief	The main display is initialized.
//	@note
//		This function is called only once by the viewDidLoad().
// *****************************************************************
- (void) initFirstDisplay
{
	// set myself view
	[[self layer] setBorderColor:[[UIColor darkGrayColor] CGColor]];
	[[self layer] setBorderWidth:2.0];
	
	self.backgroundColor = [UIColor whiteColor];
	
	// Calculate Main display area *****
	CGSize	sizePich = CGSizeMake(self.frame.size.width / 20.0f, self.frame.size.height / 8.0f);
	
	// set text
	CGRect	rectText;
	rectText.origin.x = (sizePich.width * 1.0f);
	rectText.origin.y = (sizePich.height * 1.0f);
	rectText.size.width = (sizePich.width * 18.0f);
	rectText.size.height = (sizePich.height * 6.0f);
	
	m_lblMemo = [[UILabel alloc] initWithFrame:rectText];
	m_lblMemo.backgroundColor = [UIColor clearColor];
	m_lblMemo.text = @"";
	m_lblMemo.font = [UIFont fontWithName:@"Helvetica-Bold" size:rectText.size.height / 2.5];
	m_lblMemo.minimumScaleFactor = 0.0f;
	m_lblMemo.adjustsFontSizeToFitWidth = YES;
	m_lblMemo.textColor = [UIColor blackColor];
	m_lblMemo.textAlignment = UIBaselineAdjustmentAlignBaselines;
	m_lblMemo.numberOfLines  = 2;
	[self addSubview:m_lblMemo];
	
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
	// Drawing code
}

- (void) setText: (NSString*)dispText
{
	m_lblMemo.text = dispText;
	[self setNeedsDisplay];
}

@end
