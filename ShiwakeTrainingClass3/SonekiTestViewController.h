//
//  SonekiTestViewController.h
//  ShiwakeTrainingClass3
//
//  Created by Hiroaki Fujisawa on 2012/11/02.
//  Copyright (c) 2012年 Hiroaki Fujisawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIKamokuView.h"
#import "UIAnswerView.h"
#import "UIMemoView.h"
#import "UIButtonAnswer.h"
#import "SonekiQuestionSequenceController.h"
#import "BackSoundController.h"

@interface SonekiTestViewController : UIViewController
{
	NSInteger			m_dispState;
	NSInteger			m_userAnswerNumber;

	NSTimer*			m_timerCountdown;
	NSInteger			m_countdownCounter;
	NSInteger			m_prmCountDown;

	SonekiQuestionSequenceController*	m_SeqCtl;
	
	BackSoundController* m_sound;
	
	UIKamokuView*		m_lblKamoku;
	UIButtonAnswer*		m_btnHiyo;
	UIButtonAnswer*		m_btnShueki;
	UIAnswerView*		m_lblAnswer;
	UIMemoView*			m_lblMemo;
	UIButtonAnswer*		m_btnNext;
}

- (void) initProcedure;

// Action method for UI event.
- (void) actFinishOnNaviBar:(id)inSender;
- (void) actPushHiyo:(id)inSender;
- (void) actPushShueki:(id)inSender;
- (void) actPsuhNext:(id)inSender;

@end
