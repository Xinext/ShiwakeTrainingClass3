//
//  UIKamokuView.m
//  ShiwakeTrainingClass3
//
//  Created by Hiroaki Fujisawa on 2012/11/14.
//  Copyright (c) 2012年 Hiroaki Fujisawa. All rights reserved.
//

#import "UIKamokuView.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIKamokuView

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
	// set selfview *****
	[[self layer] setBorderColor:[[UIColor darkGrayColor] CGColor]];
	[[self layer] setBorderWidth:2.0];
	
	self.backgroundColor = [UIColor whiteColor];
	[[self layer] setCornerRadius:10.0];
	[self setClipsToBounds:YES];
	
	// Calculate Main display area *****
	CGSize	sizePich = CGSizeMake(self.frame.size.width / 28.0f, self.frame.size.height / 9.0f);
	
	// set title
	CGRect	rectTitle;
	rectTitle.origin.x = (sizePich.width * 1.0f);
	rectTitle.origin.y = (sizePich.height * 1.0f);
	rectTitle.size.width = (sizePich.width * 8.0f);
	rectTitle.size.height = (sizePich.height * 2.0f);
	
	m_plblTitle = [[UILabel alloc] initWithFrame:rectTitle];
	m_plblTitle.backgroundColor = [UIColor clearColor];
	m_plblTitle.text = @"勘定科目";
	m_plblTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:rectTitle.size.height];
	m_plblTitle.minimumScaleFactor = 0.0f;
	m_plblTitle.adjustsFontSizeToFitWidth = YES;
	m_plblTitle.textColor = [UIColor darkGrayColor];
	m_plblTitle.textAlignment = UIBaselineAdjustmentAlignCenters;
	m_plblTitle.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
	[self addSubview:m_plblTitle];
	
	// set kamoku
	CGRect	rectKamoku;
	rectKamoku.origin.x = (sizePich.width * 1.0f);
	rectKamoku.origin.y = (sizePich.height * 4.0f);
	rectKamoku.size.width = (sizePich.width * 26.0f);
	rectKamoku.size.height = (sizePich.height * 4.0f);
	
	m_plblKamoku = [[UILabel alloc] initWithFrame:rectKamoku];
	m_plblKamoku.backgroundColor = [UIColor clearColor];
	m_plblKamoku.text = @"";
	m_plblKamoku.font = [UIFont fontWithName:@"Helvetica-Bold" size:rectKamoku.size.height];
	m_plblKamoku.minimumScaleFactor = 0.0f;
	m_plblKamoku.adjustsFontSizeToFitWidth = YES;
	m_plblKamoku.textColor = [UIColor blackColor];
	m_plblKamoku.textAlignment = UIBaselineAdjustmentAlignCenters;
	m_plblKamoku.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
	[self addSubview:m_plblKamoku];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
	// Drawing code
}

// *****************************************************************
//	@brief	Setter for kamoku text.
//	@note
//		Nothing
// *****************************************************************
- (void)setText:(NSString*)strKamoku
{
	m_strKamoku = strKamoku;
	m_plblKamoku.text = strKamoku;
}

@end
