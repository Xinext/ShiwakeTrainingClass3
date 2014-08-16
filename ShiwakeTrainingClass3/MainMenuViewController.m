//
//  MainMenuViewController.m
//  ShiwakeTrainingClass3
//
//  Created by Hiroaki Fujisawa on 2012/12/01.
//  Copyright (c) 2012年 Hiroaki Fujisawa. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>

#import "MainMenuViewController.h"
#import "UIButtonAnswer.h"

#define HEADER_HIGHT	(20.0f)
#define NAVIBAR_HIGHT	(44.0f)

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
		[self initFirstDisplay];
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

// *****************************************************************
//	@brief	The main display is initialized.
//	@note
//		This function is called only once by the viewDidLoad().
// *****************************************************************
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
	UINavigationItem* title = [[UINavigationItem alloc] initWithTitle:@"メインメニュー"];
	UIBarButtonItem* btnItemSetting = [[UIBarButtonItem alloc] initWithTitle:@"設定" style:UIBarButtonItemStyleBordered target:self action:@selector(actSettingOnNaviBar:)];
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
	
	// Set Title
	[self makeTitle:mainDisplayView pich:sizePich];
	
	// Set menu button
	[self makeMenuButton:mainDisplayView pich:sizePich];
}

// *****************************************************************
//	@brief	make title
//	@note
//
// *****************************************************************
- (void) makeTitle:(UIView*)view pich:(CGSize)sizePich
{
	// make main title *****
	CGRect	rectMainTitle;
	rectMainTitle.origin.x = (sizePich.width * 1.0f);
	rectMainTitle.origin.y = (sizePich.height * 2.0f);
	rectMainTitle.size.width = (sizePich.width * 28.0f);
	rectMainTitle.size.height = (sizePich.height * 4.0f);
	
	UILabel *lbMainTitle = [[UILabel alloc] initWithFrame:rectMainTitle];
	lbMainTitle.backgroundColor = [UIColor clearColor];
	lbMainTitle.text = @"簿記３級";
	lbMainTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:rectMainTitle.size.height];
	lbMainTitle.minimumScaleFactor = 0.0f;
	lbMainTitle.adjustsFontSizeToFitWidth = YES;
	lbMainTitle.textColor = [UIColor whiteColor];
	lbMainTitle.textAlignment = UIBaselineAdjustmentAlignCenters;
	lbMainTitle.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
	[view addSubview:lbMainTitle];
	
	// make sub title *****
	CGRect	rectSubTitle;
	rectSubTitle.origin.x = (sizePich.width * 1.0f);
	rectSubTitle.origin.y = (sizePich.height * 7.0f);
	rectSubTitle.size.width = (sizePich.width * 28.0f);
	rectSubTitle.size.height = (sizePich.height * 3.0f);
	
	UILabel *lbSubTitle = [[UILabel alloc] initWithFrame:rectSubTitle];
	lbSubTitle.backgroundColor = [UIColor clearColor];
	lbSubTitle.text = @"勘定科目トレーニング";
	lbSubTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:rectSubTitle.size.height];
	lbSubTitle.minimumScaleFactor = 0.0f;
	lbSubTitle.adjustsFontSizeToFitWidth = YES;
	lbSubTitle.textColor = [UIColor whiteColor];
	lbSubTitle.textAlignment = UIBaselineAdjustmentAlignCenters;
	lbSubTitle.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
	[view addSubview:lbSubTitle];
}

// *****************************************************************
//	@brief	make menu button
//	@note
//
// *****************************************************************
- (void) makeMenuButton:(UIView*)view pich:(CGSize)sizePich
{
	// make taishaku button *****
	CGRect	rectTaishakuButton;
	rectTaishakuButton.origin.x = (sizePich.width * 1.0f);
	rectTaishakuButton.origin.y = (sizePich.height * 14.0f);
	rectTaishakuButton.size.width = (sizePich.width * 28.0f);
	rectTaishakuButton.size.height = (sizePich.height * 7.0f);
	
	UIButtonAnswer* btnTaishaku = [[UIButtonAnswer alloc] initWithFrame:rectTaishakuButton];
	btnTaishaku.powerOfword = 0.05;
	[btnTaishaku setTitle:@"貸借対照表" forState:UIControlStateNormal];
	[btnTaishaku setNeedsDisplay];
	[btnTaishaku addTarget:self action:@selector(actPushTaishaku:) forControlEvents:UIControlEventTouchUpInside];
	[view addSubview:btnTaishaku];
	
	// make taishaku button *****
	CGRect	rectSonekiButton;
	rectSonekiButton.origin.x = (sizePich.width * 1.0f);
	rectSonekiButton.origin.y = (sizePich.height * 22.0f);
	rectSonekiButton.size.width = (sizePich.width * 28.0f);
	rectSonekiButton.size.height = (sizePich.height * 7.0f);
	
	UIButtonAnswer* btnSoneki = [[UIButtonAnswer alloc] initWithFrame:rectSonekiButton];
	btnSoneki.powerOfword = 0.05;
	[btnSoneki setTitle:@"損益計算書" forState:UIControlStateNormal];
	[btnSoneki addTarget:self action:@selector(actPushSoneki:) forControlEvents:UIControlEventTouchUpInside];
	[view addSubview:btnSoneki];
	
	// make list button *****
	CGRect	rectListButton;
	rectListButton.origin.x = (sizePich.width * 1.0f);
	rectListButton.origin.y = (sizePich.height * 30.0f);
	rectListButton.size.width = (sizePich.width * 28.0f);
	rectListButton.size.height = (sizePich.height * 7.0f);
	
	UIButtonAnswer* btnList = [[UIButtonAnswer alloc] initWithFrame:rectListButton];
	btnList.powerOfword = 0.05;
	[btnList setTitle:@"勘定科目一覧" forState:UIControlStateNormal];
	[btnList addTarget:self action:@selector(actPushKamokuList:) forControlEvents:UIControlEventTouchUpInside];
	[view addSubview:btnList];
}

// *****************************************************************
//	@brief	Click event function ( Setting button on Navigation bar )
//	@note
//		Nothing
// *****************************************************************
- (void) actSettingOnNaviBar:(id)inSender
{
	NSNotification *n = [NSNotification notificationWithName:@"DT_Preferences" object:self];
	[[NSNotificationCenter defaultCenter] postNotification:n];
}

// *****************************************************************
//	@brief	Click event function ( Taishaku button )
//	@note
//		Nothing
// *****************************************************************
- (void) actPushTaishaku:(id)inSender
{
	NSNotification *n = [NSNotification notificationWithName:@"DT_TaishakuTest" object:self];
	[[NSNotificationCenter defaultCenter] postNotification:n];
}

// *****************************************************************
//	@brief	Click event function ( Soneki button )
//	@note
//		Nothing
// *****************************************************************
- (void) actPushSoneki:(id)inSender
{
	NSNotification *n = [NSNotification notificationWithName:@"DT_SonekiTest" object:self];
	[[NSNotificationCenter defaultCenter] postNotification:n];
}

// *****************************************************************
//	@brief	Click event function ( Kamoku List button )
//	@note
//		Nothing
// *****************************************************************
- (void) actPushKamokuList:(id)inSender
{
	NSNotification *n = [NSNotification notificationWithName:@"DT_KamokuList" object:self];
	[[NSNotificationCenter defaultCenter] postNotification:n];
}
@end
