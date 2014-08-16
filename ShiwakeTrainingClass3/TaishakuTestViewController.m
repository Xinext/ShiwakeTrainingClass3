//
//  TaishakuTestViewController.m
//  ShiwakeTrainingClass3
//
//  Created by Hiroaki Fujisawa on 2012/10/30.
//  Copyright (c) 2012年 Hiroaki Fujisawa. All rights reserved.
//

#import "TaishakuTestViewController.h"

#import <QuartzCore/QuartzCore.h>

#define HEADER_HIGHT	(20.0f)
#define NAVIBAR_HIGHT	(44.0f)

#define DISP_STATE_WAIT_ANSWER	0
#define DISP_STATE_DISP_ANSWER	1

@interface TaishakuTestViewController ()

@end

@implementation TaishakuTestViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		m_timerCountdown = nil;
		
		[self initFirstDisplay];
		//[self initProcedure];
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
	
	m_SeqCtl = [[TaishakuQuestionSequenceController alloc]init];
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
	UINavigationItem* title = [[UINavigationItem alloc] initWithTitle:@"貸借対照表"];
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
	
	// Create Sisan button
	CGRect	rectShisanBtn = mainDisplayView.bounds;
	rectShisanBtn.origin.x = (sizePich.width * 1.0f);
	rectShisanBtn.origin.y = (sizePich.height * 11.0f);
	rectShisanBtn.size.width = (sizePich.width * 14.0f);
	rectShisanBtn.size.height = (sizePich.height * 12.0f);
	m_btnShisan = [[UIButtonAnswer alloc] initWithFrame:rectShisanBtn];
	[m_btnShisan setTitle:@"資産" forState:UIControlStateNormal];
	[m_btnShisan addTarget:self action:@selector(actPushShisan:) forControlEvents:UIControlEventTouchUpInside];
	[mainDisplayView addSubview:m_btnShisan];
	
	// Create Husai button
	CGRect	rectHusaiBtn = mainDisplayView.bounds;
	rectHusaiBtn.origin.x = (sizePich.width * 15.0f);
	rectHusaiBtn.origin.y = (sizePich.height * 11.0f);
	rectHusaiBtn.size.width = (sizePich.width * 14.0f);
	rectHusaiBtn.size.height = (sizePich.height * 6.0f);
	m_btnHusai = [[UIButtonAnswer alloc] initWithFrame:rectHusaiBtn];
	[m_btnHusai setTitle:@"負債" forState:UIControlStateNormal];
	[m_btnHusai addTarget:self action:@selector(actPushHusai:) forControlEvents:UIControlEventTouchUpInside];
	[mainDisplayView addSubview:m_btnHusai];
	
	// Create Junshisan button
	CGRect	rectJunshisanBtn = mainDisplayView.bounds;
	rectJunshisanBtn.origin.x = (sizePich.width * 15.0f);
	rectJunshisanBtn.origin.y = (sizePich.height * 17.0f);
	rectJunshisanBtn.size.width = (sizePich.width * 14.0f);
	rectJunshisanBtn.size.height = (sizePich.height * 6.0f);
	m_btnjunshisan = [[UIButtonAnswer alloc] initWithFrame:rectJunshisanBtn];
	[m_btnjunshisan setTitle:@"純資産" forState:UIControlStateNormal];
	[m_btnjunshisan addTarget:self action:@selector(actPsuhJyunShisan:) forControlEvents:UIControlEventTouchUpInside];
	[mainDisplayView addSubview:m_btnjunshisan];
	
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
	m_btnShisan.enabled = YES;
	m_btnHusai.enabled = YES;
	m_btnjunshisan.enabled = YES;
	
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
	m_btnShisan.enabled = NO;
	m_btnHusai.enabled = NO;
	m_btnjunshisan.enabled = NO;
	
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
			[m_lblMemo setText:@"資産の\n勘定科目です。"];
			break;
		case 1:
			[m_lblMemo setText:@"負債の\n勘定科目です。"];
			break;
		case 2:
			[m_lblMemo setText:@"純資産の\n勘定科目です。"];
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
//	@brief	Click event function ( Shisan button )
//	@note
//		Nothing
// *****************************************************************
- (void) actPushShisan:(id)inSender
{
	switch (m_btnShisan.state)
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
//	@brief	Click event function ( Husai button )
//	@note
//		Nothing
// *****************************************************************
- (void) actPushHusai:(id)inSender
{
	switch (m_btnHusai.state)
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
- (void) actPsuhJyunShisan:(id)inSender
{
	switch (m_btnjunshisan.state)
	{
		case UIControlStateNormal:
		case UIControlStateHighlighted:
			[self stopTimeout];
			m_userAnswerNumber = 2;
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
