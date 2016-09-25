//
//  KamokuListViewController.m
//  ShiwakeTrainingClass3
//
//  Created by Hiroaki Fujisawa on 2013/03/14.
//  Copyright (c) 2013年 Hiroaki Fujisawa. All rights reserved.
//

#import "KamokuListViewController.h"
#import "TaishakuQuestionSequenceController.h"

#define HEADER_HIGHT	(20.0f)
#define NAVIBAR_HIGHT	(44.0f)

@interface KamokuListViewController ()

@end

@implementation KamokuListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
		m_seqCtlTaishaku = [[TaishakuQuestionSequenceController alloc]init];
		m_seqCtlSoneki = [[SonekiQuestionSequenceController alloc]init];
		m_joinDictionaty = [NSMutableDictionary dictionary];
		m_sectionTitle = [NSArray arrayWithObjects:@"資産", @"負債", @"純資産", @"費用", @"収益", nil];
		
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

// *****************************************************************
//	@brief	Initialization for this module.
//	@note
//		Nothing
// *****************************************************************
- (void) initProcedure
{
	[self initTableInfo];
	[self initFirstDisplay];
}

// *****************************************************************
//	@brief	Initialization for Table view
//	@note
//		Nothing
// *****************************************************************
- (void) initTableInfo
{
	NSMutableDictionary*	sonekiDictionary = [m_seqCtlSoneki getKamokuDictionary];
	NSMutableDictionary*	taishakuDictionary = [m_seqCtlTaishaku getKamokuDictionary];
	
	if (m_joinDictionaty != nil) {
		[m_joinDictionaty removeAllObjects];
	}
	else {
		m_joinDictionaty = [NSMutableDictionary dictionary];
	}
	
	// join dictionay
	NSInteger	kindIndex;
	NSArray*	kindArray = [taishakuDictionary allKeys];
	for (kindIndex=0; kindIndex<[kindArray count]; kindIndex++) {
		
		NSArray* kamokuArray = [taishakuDictionary objectForKey:[kindArray objectAtIndex:kindIndex]];
		[m_joinDictionaty setObject:kamokuArray forKey:[kindArray objectAtIndex:kindIndex]];
	}

	kindArray = [sonekiDictionary allKeys];
	for (kindIndex=0; kindIndex<[kindArray count]; kindIndex++) {
		
		NSArray* kamokuArray = [sonekiDictionary objectForKey:[kindArray objectAtIndex:kindIndex]];
		[m_joinDictionaty setObject:kamokuArray forKey:[kindArray objectAtIndex:kindIndex]];
	}
	
	// count number of section

}

// *****************************************************************
//	@brief	Initialization for all view.
//	@note
//		Nothing
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
	UINavigationItem* title = [[UINavigationItem alloc] initWithTitle:@"科目一覧表"];
	UIBarButtonItem* btnItemSetting = [[UIBarButtonItem alloc] initWithTitle:@"終了" style:UIBarButtonItemStylePlain target:self action:@selector(actFinishOnNaviBar:)];
	title.rightBarButtonItem = btnItemSetting;
	[navBarTop pushNavigationItem:title animated:YES];
	[self.view addSubview:navBarTop];
	
	// Calculate Main display area *****
	CGRect	rectMainDisplayView = rectMainFrame;
	rectMainDisplayView.origin.y += NAVIBAR_HIGHT;
	rectMainDisplayView.size.height -= NAVIBAR_HIGHT;
	
	// Set main diplay view
	UIView*	mainDisplayView = [[UIView alloc] initWithFrame:rectMainDisplayView];
	UIImage *backgroundImage = [UIImage imageNamed:@"test_back.png"];
	mainDisplayView.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
	[self.view addSubview:mainDisplayView];
	
	// Create Table
	CGRect rectTable = mainDisplayView.bounds;
	m_tableView = [[UITableView alloc] initWithFrame:rectTable style:UITableViewStylePlain];
	m_tableView.delegate = self;
	m_tableView.dataSource = self;
	[mainDisplayView addSubview:m_tableView];
}

// *****************************************************************
//	@brief	Click event function ( Done button on Navigation bar )
//	@note
//		Nothing
// *****************************************************************
- (void) actFinishOnNaviBar:(id)inSender
{
	// done display transition
	NSNotification *n = [NSNotification notificationWithName:@"DT_MainMenu" object:self];
	[[NSNotificationCenter defaultCenter] postNotification:n];
}

/* ********** ********** ********** ********** ********** ********** */
// The  following section are the procedure for table view.
/* ********** ********** ********** ********** ********** ********** */

// The number of sections in table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	NSInteger	sectionNumber = [m_joinDictionaty count];
	
	return sectionNumber;
}

// The number of rows in table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSArray*	kamokuArray = [m_joinDictionaty objectForKey:[m_sectionTitle objectAtIndex:section]];
	NSInteger	rowNumber = [kamokuArray count];
	
	return rowNumber;
}

// Create cell object for table view.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
	}
	
	NSString*	keyString = [m_sectionTitle objectAtIndex:indexPath.section];
	NSArray*	kamokuArray = [m_joinDictionaty objectForKey:keyString];
	
	cell.textLabel.text = [kamokuArray objectAtIndex:indexPath.row];

	return cell;

}

// Set section title
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return [m_sectionTitle objectAtIndex:section];
}


@end
