//
//  TaishakuTestViewController.h
//  ShiwakeTrainingClass3
//
//  Created by Hiroaki Fujisawa on 2012/10/30.
//  Copyright (c) 2012年 Hiroaki Fujisawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIKamokuView.h"
#import "UIAnswerView.h"
#import "UIMemoView.h"
#import "UIButtonAnswer.h"

#import "TaishakuQuestionSequenceController.h"
#import "BackSoundController.h"

@interface TaishakuTestViewController : UIViewController
{
	NSInteger			m_dispState;
	NSInteger			m_userAnswerNumber;

	NSTimer*			m_timerCountdown;
	NSInteger			m_countdownCounter;
	NSInteger			m_prmCountDown;
	
	TaishakuQuestionSequenceController*	m_SeqCtl;
	
	BackSoundController* m_sound;
	
	UIKamokuView*		m_lblKamoku;
	UIButtonAnswer*		m_btnShisan;
	UIButtonAnswer*		m_btnHusai;
	UIButtonAnswer*		m_btnjunshisan;
	UIAnswerView*		m_lblAnswer;
	UIMemoView*			m_lblMemo;
	UIButtonAnswer*		m_btnNext;
}

- (void) initProcedure;

// Action method for UI event.
- (void) actFinishOnNaviBar:(id)inSender;
- (void) actPushShisan:(id)inSender;
- (void) actPushHusai:(id)inSender;
- (void) actPsuhJyunShisan:(id)inSender;
- (void) actPsuhNext:(id)inSender;
@end
