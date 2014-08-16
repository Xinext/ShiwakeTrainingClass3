//
//  topViewController.m
//  ShiwakeTrainingClass3
//
//  Created by Hiroaki Fujisawa on 2012/11/30.
//  Copyright (c) 2012年 Hiroaki Fujisawa. All rights reserved.
//

#import "topViewController.h"

#import "MainMenuViewController.h"
#import "TaishakuTestViewController.h"
#import "SonekiTestViewController.h"
#import "PreferencesViewController.h"
#import "KamokuListViewController.h"

@interface topViewController ()

@property (strong, nonatomic) MainMenuViewController		*m_MainMenuViewController;
@property (strong, nonatomic) TaishakuTestViewController	*m_TaishakuTestViewController;
@property (strong, nonatomic) SonekiTestViewController		*m_SonekiTestViewController;
@property (strong, nonatomic) PreferencesViewController		*m_PreferencesViewController;
@property (strong, nonatomic) KamokuListViewController		*m_KamokuListViewController;

@end

@implementation topViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
		self.m_MainMenuViewController = nil;
		self.m_TaishakuTestViewController = nil;
		self.m_SonekiTestViewController = nil;
		self.m_PreferencesViewController = nil;
		self.m_KamokuListViewController = nil;
		
		[self initViewController];
		[self initNotificationCenter];
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
//	@brief	Initialize each view controller and set first view.
//	@note
//		Nothing
// *****************************************************************
- (void) initViewController
{
	self.view.backgroundColor = [UIColor blackColor];
	
	// Create each view controller
	self.m_MainMenuViewController = [[MainMenuViewController alloc] init];
	[self addChildViewController:self.m_MainMenuViewController];
	[self.m_MainMenuViewController didMoveToParentViewController:self];
	
	CGRect  frame = self.view.frame;
	frame.origin = CGPointMake(0.0, 0.0);
	self.m_MainMenuViewController.view.frame = frame;
	
	[self.view addSubview:self.self.m_MainMenuViewController.view];
	
	m_nowDispVC = self.m_MainMenuViewController;
}

// *****************************************************************
//	@brief	Initialize notification center for display transition
//	@note
//		Nothing
// *****************************************************************
- (void) initNotificationCenter
{
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	
	[nc addObserver:self selector:@selector(dispChenge2MainMenuView) name:@"DT_MainMenu" object:nil];
	[nc addObserver:self selector:@selector(dispChenge2TaishakuTestView) name:@"DT_TaishakuTest" object:nil];
	[nc addObserver:self selector:@selector(dispChenge2SonekiTestView) name:@"DT_SonekiTest" object:nil];
	[nc addObserver:self selector:@selector(dispChenge2Preferences) name:@"DT_Preferences" object:nil];
	[nc addObserver:self selector:@selector(dispChenge2KamokuListView) name:@"DT_KamokuList" object:nil];
}

// *****************************************************************
//	@brief	Change to Preferences view
//	@note
//		Nothing
// *****************************************************************
- (void) dispChenge2Preferences
{
	if ( self.m_PreferencesViewController == nil)
	{
		self.m_PreferencesViewController = [[PreferencesViewController alloc] init];
		[self addChildViewController:self.m_PreferencesViewController];
		[self.m_PreferencesViewController didMoveToParentViewController:self];
		
		CGRect  frame = self.view.frame;
		frame.origin = CGPointMake(0.0, 0.0);
		self.m_PreferencesViewController.view.frame = frame;
	}

	[self transitionFromViewController:m_nowDispVC
					  toViewController:self.m_PreferencesViewController
							  duration:0.8
							   options:UIViewAnimationOptionTransitionFlipFromLeft
							animations:NULL
							completion:NULL];
	
	m_nowDispVC = self.m_PreferencesViewController;
}


// *****************************************************************
//	@brief	Change to MainMenu view
//	@note
//		Nothing
// *****************************************************************
- (void) dispChenge2MainMenuView
{
	if ( self.m_MainMenuViewController == nil )
	{
		self.m_MainMenuViewController = [[MainMenuViewController alloc] init];
		[self addChildViewController:self.m_MainMenuViewController];
		[self.m_MainMenuViewController didMoveToParentViewController:self];
		
		CGRect  frame = self.view.frame;
		frame.origin = CGPointMake(0.0, 0.0);
		self.m_MainMenuViewController.view.frame = frame;
	}

	[self transitionFromViewController:m_nowDispVC
					  toViewController:self.m_MainMenuViewController
							  duration:0.8
							   options:UIViewAnimationOptionTransitionFlipFromRight
							animations:NULL
							completion:NULL];
	
	m_nowDispVC = self.m_MainMenuViewController;
}

// *****************************************************************
//	@brief	Change to TaishakuTest view
//	@note
//		Nothing
// *****************************************************************
- (void) dispChenge2TaishakuTestView
{
	if ( self.m_TaishakuTestViewController == nil )
	{
		self.m_TaishakuTestViewController = [[TaishakuTestViewController alloc] init];
		[self addChildViewController:self.m_TaishakuTestViewController];
		[self.m_TaishakuTestViewController didMoveToParentViewController:self];
		
		CGRect  frame = self.view.frame;
		frame.origin = CGPointMake(0.0, 0.0);
		self.m_TaishakuTestViewController.view.frame = frame;
	}

	[self.m_TaishakuTestViewController initProcedure];

	[self transitionFromViewController:m_nowDispVC
					  toViewController:self.m_TaishakuTestViewController
							  duration:0.8
							   options:UIViewAnimationOptionTransitionFlipFromLeft
							animations:NULL
							completion:NULL];
	
	m_nowDispVC = self.m_TaishakuTestViewController;
}

// *****************************************************************
//	@brief	Change to SonekiTest view
//	@note
//		Nothing
// *****************************************************************
- (void) dispChenge2SonekiTestView
{
	if ( self.m_SonekiTestViewController == nil )
	{
		self.m_SonekiTestViewController = [[SonekiTestViewController alloc] init];
		[self addChildViewController:self.m_SonekiTestViewController];
		[self.m_SonekiTestViewController didMoveToParentViewController:self];
		
		CGRect  frame = self.view.frame;
		frame.origin = CGPointMake(0.0, 0.0);
		self.m_SonekiTestViewController.view.frame = frame;
	}

	[self.m_SonekiTestViewController initProcedure];
	
	[self transitionFromViewController:m_nowDispVC
					  toViewController:self.m_SonekiTestViewController
							  duration:0.8
							   options:UIViewAnimationOptionTransitionFlipFromLeft
							animations:NULL
							completion:NULL];
	
	m_nowDispVC = self.m_SonekiTestViewController;
}

// *****************************************************************
//	@brief	Change to KamokuList view
//	@note
//		Nothing
// *****************************************************************
- (void) dispChenge2KamokuListView
{
	if ( self.m_KamokuListViewController == nil )
	{
		self.m_KamokuListViewController = [[KamokuListViewController alloc] init];
		[self addChildViewController:self.m_KamokuListViewController];
		[self.m_KamokuListViewController didMoveToParentViewController:self];
		
		CGRect  frame = self.view.frame;
		frame.origin = CGPointMake(0.0, 0.0);
		self.m_KamokuListViewController.view.frame = frame;
	}

	[self transitionFromViewController:m_nowDispVC
					  toViewController:self.m_KamokuListViewController
							  duration:0.8
							   options:UIViewAnimationOptionTransitionFlipFromLeft
							animations:NULL
							completion:NULL];
	
	m_nowDispVC = self.m_KamokuListViewController;
}

@end
