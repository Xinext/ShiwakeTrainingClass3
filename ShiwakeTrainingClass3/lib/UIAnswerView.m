//
//  UIAnswerView.m
//  ShiwakeTrainingClass3
//
//  Created by Hiroaki Fujisawa on 2012/12/26.
//  Copyright (c) 2012年 Hiroaki Fujisawa. All rights reserved.
//

#import "UIAnswerView.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIAnswerView

const NSInteger UIANSWER_DISPSTATE_NONE	= 0;
const NSInteger UIANSWER_DISPSTATE_OK	= 1;
const NSInteger UIANSWER_DISPSTATE_NG	= 2;

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
	// set myself view *****
	[[self layer] setBorderColor:[[UIColor darkGrayColor] CGColor]];
	[[self layer] setBorderWidth:2.0];
	
	self.backgroundColor = [UIColor whiteColor];
	
	// Calculate Main display area *****
	CGSize	sizePich = CGSizeMake(self.frame.size.width / 8.0f, self.frame.size.height / 8.0f);
	
	// set answer *****
	CGRect	rectAnswer;
	rectAnswer.origin.x = (sizePich.width * 1.0f);
	rectAnswer.origin.y = (sizePich.height * 1.0f);
	rectAnswer.size.width = (sizePich.width * 6.0f);
	rectAnswer.size.height = (sizePich.height * 6.0f);
	
	m_lblAnswer = [[UILabel alloc] initWithFrame:rectAnswer];
	m_lblAnswer.backgroundColor = [UIColor clearColor];
	m_lblAnswer.text = @"";
	m_lblAnswer.font = [UIFont fontWithName:@"Helvetica-Bold" size:rectAnswer.size.height];
	m_lblAnswer.minimumScaleFactor = 0.0f;
	m_lblAnswer.adjustsFontSizeToFitWidth = YES;
	m_lblAnswer.textColor = [UIColor darkGrayColor];
	m_lblAnswer.textAlignment = UIBaselineAdjustmentAlignCenters;
	m_lblAnswer.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
	[self addSubview:m_lblAnswer];
	
}

- (void) setDispState: (NSInteger)state
{
	switch (state) {
		case UIANSWER_DISPSTATE_OK:
			m_lblAnswer.text = @"O";
			[m_lblAnswer setTextColor:[UIColor redColor]];
			break;

		case UIANSWER_DISPSTATE_NG:
			m_lblAnswer.text = @"X";
			[m_lblAnswer setTextColor:[UIColor blueColor]];
			break;
			
		default:
			m_lblAnswer.text = @"";
			break;
	}
}

- (void) setNumber: (NSInteger)num
{
	m_lblAnswer.text = [NSString stringWithFormat:@"%ld", (long)num];
	[m_lblAnswer setTextColor:[UIColor blackColor]];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
	// Drawing code
	
}


@end
