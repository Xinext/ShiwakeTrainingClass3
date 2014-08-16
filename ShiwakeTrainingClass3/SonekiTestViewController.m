//
//  SonekiTestViewController.m
//  ShiwakeTrainingClass3
//
//  Created by Hiroaki Fujisawa on 2012/11/02.
//  Copyright (c) 2012年 Hiroaki Fujisawa. All rights reserved.
//

#import "SonekiTestViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "BackSoundController.h"

#define HEADER_HIGHT	(20.0f)
#define NAVIBAR_HIGHT	(44.0f)

#define DISP_STATE_WAIT_ANSWER	0
#define DISP_STATE_DISP_ANSWER	1

@interface SonekiTestViewController ()

@end

@implementation SonekiTestViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		m_timerCountdown = nil;
		
		[self initFirstDisplay];
		[self initProcedure];
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void) initProcedure
{
	m_dispState = DISP_STATE_WAIT_ANSWER;
	m_countdownCounter = -1;
	
	m_SeqCtl = [[SonekiQuestionSequenceController alloc]init];
	m_sound = [[BackSoundController alloc] init];
	
	[self initParameter];
	[self stratTimeout];
	[self updateView];
}

- (void) initParameter
{
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	
	NSNumber* num = [ud objectForKey:@"KEY_TIMEOUT"];
	m_prmCountDown = [num integerValue];
}

- (void) initFirstDisplay
{
	CGRect	rectMainFrame = self.view.frame;
	rectMainFrame.origin.x = 0;
	if (rectMainFrame.origin.y > 0) {
		rectMainFrame.origin.y = 0;
	}
	else {
		rectMainFrame.origin.y = HEADER_HIGHT;
	}
	rectMainFrame.size.height -= rectMainFrame.origin.y;
	
	// Set background *****
	self.view.backgroundColor = [UIColor grayColor];
	
	// Set Navigation Bar *****
	CGRect	rectNaviBar = rectMainFrame;
	rectNaviBar.origin.x = 0;
	rectNaviBar.size.height = NAVIBAR_HIGHT;
	UINavigationBar* navBarTop = [[UINavigationBar alloc] initWithFrame:rectNaviBar];
	UINavigationItem* title = [[UINavigationItem alloc] initWithTitle:@"損益計算書"];
	UIBarButtonItem* btnItemSetting = [[UIBarButtonItem alloc] initWithTitle:@"終了" style:UIBarButtonItemStyleBordered target:self action:@selector(actFinishOnNaviBar:)];
	title.rightBarButtonItem = btnItemSetting;
	[navBarTop pushNavigationItem:title animated:YES];
	[self.view addSubview:navBarTop];
	
	// Calculate Main display area *****
	CGRect	rectMainDisplayView = rectMainFrame;
	rectMainDisplayView.origin.y += NAVIBAR_HIGHT;
	rectMainDisplayView.size.height -= NAVIBAR_HIGHT;
	CGSize	sizePich = CGSizeMake(rectMainDisplayView.size.width / 30.0f, rectMainDisplayView.size.height / 40.0f);
	
	// Set main diplay view
	UIView*	mainDisplayView = [[UIView alloc] initWithFrame:rectMainDisplayView];
	UIImage *backgroundImage = [UIImage imageNamed:@"test_back.png"];
	mainDisplayView.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
	[self.view addSubview:mainDisplayView];
	
	// Make question label
	CGRect	rectQuestionOutline = mainDisplayView.bounds;
	rectQuestionOutline.origin.x = (sizePich.width * 1.0f);
	rectQuestionOutline.origin.y = (sizePich.height * 1.0f);
	rectQuestionOutline.size.width = (sizePich.width * 28.0f);
	rectQuestionOutline.size.height = (sizePich.height * 9.0f);
	m_lblKamoku = [[UIKamokuView alloc] initWithFrame:rectQuestionOutline];
	[mainDisplayView addSubview:m_lblKamoku];
	
	// Create Hiyo button
	CGRect	rectHiyoBtn = mainDisplayView.bounds;
	rectHiyoBtn.origin.x = (sizePich.width * 1.0f);
	rectHiyoBtn.origin.y = (sizePich.height * 11.0f);
	rectHiyoBtn.size.width = (sizePich.width * 14.0f);
	rectHiyoBtn.size.height = (sizePich.height * 12.0f);
	m_btnHiyo = [[UIButtonAnswer alloc] initWithFrame:rectHiyoBtn];
	[m_btnHiyo setTitle:@"費用" forState:UIControlStateNormal];
	[m_btnHiyo addTarget:self action:@selector(actPushHiyo:) forControlEvents:UIControlEventTouchUpInside];
	[mainDisplayView addSubview:m_btnHiyo];
	
	// Create Shueki button
	CGRect	rectShuekiBtn = mainDisplayView.bounds;
	rectShuekiBtn.origin.x = (sizePich.width * 15.0f);
	rectShuekiBtn.origin.y = (sizePich.height * 11.0f);
	rectShuekiBtn.size.width = (sizePich.width * 14.0f);
	rectShuekiBtn.size.height = (sizePich.height * 12.0f);
	m_btnShueki = [[UIButtonAnswer alloc] initWithFrame:rectShuekiBtn];
	[m_btnShueki setTitle:@"収益" forState:UIControlStateNormal];
	[m_btnShueki addTarget:self action:@selector(actPushShueki:) forControlEvents:UIControlEventTouchUpInside];
	[mainDisplayView addSubview:m_btnShueki];
	
	// Make Answer label
	CGRect	rectAnswerLabel = mainDisplayView.bounds;
	rectAnswerLabel.origin.x = (sizePich.width * 1.0f);
	rectAnswerLabel.origin.y = (sizePich.height * 24.0f);
	rectAnswerLabel.size.width = (sizePich.width * 8.0f);
	rectAnswerLabel.size.height = (sizePich.height * 8.0f);
	m_lblAnswer = [[UIAnswerView alloc] initWithFrame:rectAnswerLabel];
	[[m_lblAnswer layer] setBorderColor:[[UIColor darkGrayColor] CGColor]];
	[[m_lblAnswer layer] setBorderWidth:1.0];
	[mainDisplayView addSubview:m_lblAnswer];
	
	// Make memo label
	CGRect	rectMemoLabel = mainDisplayView.bounds;
	rectMemoLabel.origin.x = (sizePich.width * 9.0f);
	rectMemoLabel.origin.y = (sizePich.height * 24.0f);
	rectMemoLabel.size.width = (sizePich.width * 20.0f);
	rectMemoLabel.size.height = (sizePich.height * 8.0f);
	m_lblMemo = [[UIMemoView alloc] initWithFrame:rectMemoLabel];
	[[m_lblMemo layer] setBorderColor:[[UIColor darkGrayColor] CGColor]];
	[[m_lblMemo layer] setBorderWidth:1.0];
	[mainDisplayView addSubview:m_lblMemo];
	
	// Create Sisan button
	CGRect	rectNextBtn = mainDisplayView.bounds;
	rectNextBtn.origin.x = (sizePich.width * 1.0f);
	rectNextBtn.origin.y = (sizePich.height * 33.0f);
	rectNextBtn.size.width = (sizePich.width * 28.0f);
	rectNextBtn.size.height = (sizePich.height * 6.0f);
	m_btnNext = [[UIButtonAnswer alloc] initWithFrame:rectNextBtn];
	[m_btnNext setTitle:@"次へ" forState:UIControlStateNormal];
	[m_btnNext addTarget:self action:@selector(actPsuhNext:) forControlEvents:UIControlEventTouchUpInside];
	[mainDisplayView addSubview:m_btnNext];
}

// *****************************************************************
//	@brief	update view (main procedure)
//	@note
//		Nothing
// *****************************************************************
- (void) updateView
{
	switch (m_dispState) {
		case DISP_STATE_WAIT_ANSWER:
			[self updateView_WaitAnswer];
			break;
			
		case DISP_STATE_DISP_ANSWER:
			[self updateView_DispAnswer];
			break;
			
		default:
			break;
	}
}

// *****************************************************************
//	@brief	update view ( for wait answer state )
//	@note
//		Nothing
// *****************************************************************
- (void) updateView_WaitAnswer
{
	// Question area
	[m_lblKamoku setText: [m_SeqCtl getQuestionKamoku]];
	
	// Answer button area
	m_btnHiyo.enabled = YES;
	m_btnShueki.enabled = YES;
	
	// Answer area
	if (m_countdownCounter > 0 ) {
		[m_lblAnswer setNumber:m_countdownCounter];
	}
	else {
		[m_lblAnswer setDispState:UIANSWER_DISPSTATE_NONE];
	}
	[m_lblMemo setText:@""];
	
	// Next button area
	m_btnNext.enabled = NO;
}

// *****************************************************************
//	@brief	update view ( for disp answer state )
//	@note
//		Nothing
// *****************************************************************
- (void) updateView_DispAnswer
{
	// Question area
	[m_lblKamoku setText: [m_SeqCtl getQuestionKamoku]];
	
	// Answer button area
	m_btnHiyo.enabled = NO;
	m_btnShueki.enabled = NO;
	
	// Answer area
	NSInteger	answerNumber = [m_SeqCtl getAnswerNumber];
	if ( (answerNumber == m_userAnswerNumber) && (m_userAnswerNumber >= 0) ) {
		[m_lblAnswer setDispState:UIANSWER_DISPSTATE_OK];
		
	}
	else {
		[m_lblAnswer setDispState:UIANSWER_DISPSTATE_NG];
	}
	
	switch (answerNumber)
	{
		case 0:
			[m_lblMemo setText:@"費用の\n勘定科目です。"];
			break;
		case 1:
			[m_lblMemo setText:@"収益の\n勘定科目です。"];
			break;
		default:
			[m_lblMemo setText:@"エラー"];
			break;
	}
	
	// Next button area
	m_btnNext.enabled = YES;
	
	if ( answerNumber == m_userAnswerNumber ) {
		[m_sound playOK];
	}
	else {
		[m_sound playNG];
	}
}

// *****************************************************************
//	@brief	Start timer for count down
//	@note
//		Nothing
// *****************************************************************
-(void)stratTimeout
{
	if (m_timerCountdown != nil) {
		[self stopTimeout];
	}
	
	if ( m_prmCountDown > 0 ){
		
		m_countdownCounter = m_prmCountDown;
		m_timerCountdown = [NSTimer scheduledTimerWithTimeInterval:1.0f
															target:self
														  selector:@selector(timeCountdown:)
														  userInfo:nil
														   repeats:YES ];
	}
	else {
		// no timeout
	}
}

// *****************************************************************
//	@brief	Stop timer for count down
//	@note
//		Nothing
// *****************************************************************
-(void)stopTimeout
{
	[m_timerCountdown invalidate];
	m_userAnswerNumber = -1;
	m_timerCountdown = nil;
}

// *****************************************************************
//	@brief	Callback for count down
//	@note
//		Nothing
// *****************************************************************
-(void)timeCountdown:(NSTimer*)timer
{
	m_countdownCounter --;
	if ( m_countdownCounter > 0 ) {
		// next count down
		[self updateView];
	}
	else {	// timeup
		[self stopTimeout];
		m_dispState = DISP_STATE_DISP_ANSWER;
		[self updateView];
	}
	
}

// *****************************************************************
//	@brief	Click event function ( Setting button on Navigation bar )
//	@note
//		Nothing
// *****************************************************************
- (void) actFinishOnNaviBar:(id)inSender
{
	[self stopTimeout];
	
	NSNotification *n = [NSNotification notificationWithName:@"DT_MainMenu" object:self];
	[[NSNotificationCenter defaultCenter] postNotification:n];
}

// *****************************************************************
//	@brief	Click event function ( Hiyo button )
//	@note
//		Nothing
// *****************************************************************
- (void) actPushHiyo:(id)inSender
{
	switch (m_btnHiyo.state)
	{
		case UIControlStateNormal:
		case UIControlStateHighlighted:
			[self stopTimeout];
			m_userAnswerNumber = 0;
			m_dispState = DISP_STATE_DISP_ANSWER;
			[self updateView];
			break;
		default:
			// no action
			break;
	}
}

// *****************************************************************
//	@brief	Click event function ( Shueki button )
//	@note
//		Nothing
// *****************************************************************
- (void) actPushShueki:(id)inSender
{
	switch (m_btnShueki.state)
	{
		case UIControlStateNormal:
		case UIControlStateHighlighted:
			[self stopTimeout];
			m_userAnswerNumber = 1;
			m_dispState = DISP_STATE_DISP_ANSWER;
			[self updateView];
			break;
		default:
			// no action
			break;
	}
}

// *****************************************************************
//	@brief	Click event function ( JyunShisan button )
//	@note
//		Nothing
// *****************************************************************
- (void) actPsuhNext:(id)inSender
{
	switch (m_btnNext.state)
	{
		case UIControlStateNormal:
		case UIControlStateHighlighted:
			[m_SeqCtl nextQuestion];
			m_userAnswerNumber = -1;
			m_dispState = DISP_STATE_WAIT_ANSWER;
			[self stratTimeout];
			[self updateView];
			break;
		default:
			// no action
			break;
	}
}

@end
