//
//  UIKamokuView.h
//  ShiwakeTrainingClass3
//
//  Created by Hiroaki Fujisawa on 2012/11/14.
//  Copyright (c) 2012年 Hiroaki Fujisawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIKamokuView : UIView
{
	UILabel*	m_plblTitle;
	UILabel*	m_plblKamoku;
	NSString*	m_strKamoku;
}

- (void)setText:(NSString*)strKamoku;

@end
