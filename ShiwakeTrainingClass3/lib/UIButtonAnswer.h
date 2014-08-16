//
//  UIButtonAnswer.h
//  ShiwakeTrainingClass3
//
//  Created by Hiroaki Fujisawa on 2012/11/05.
//  Copyright (c) 2012年 Hiroaki Fujisawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButtonAnswer : UIButton
{
	BOOL	m_bEmphasize;
}

@property double_t	powerOfword;

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;
- (void) setEmphasize:(BOOL)flag;

@end
