//
//  UIAnswerView.h
//  ShiwakeTrainingClass3
//
//  Created by Hiroaki Fujisawa on 2012/12/26.
//  Copyright (c) 2012年 Hiroaki Fujisawa. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const NSInteger UIANSWER_DISPSTATE_NONE;
extern const NSInteger UIANSWER_DISPSTATE_OK;
extern const NSInteger UIANSWER_DISPSTATE_NG;

@interface UIAnswerView : UIView
{
	UILabel*	m_lblAnswer;
}

- (void) setDispState: (NSInteger)state;
- (void) setNumber: (NSInteger)num;

@end
