//
//  PreferencesViewController.m
//  ShiwakeTrainingClass3
//
//  Created by Hiroaki Fujisawa on 2012/12/02.
//  Copyright (c) 2012年 Hiroaki Fujisawa. All rights reserved.
//

#import "PreferencesViewController.h"

#define HEADER_HIGHT	(20.0f)
#define NAVIBAR_HIGHT	(44.0f)

@interface PreferencesViewController ()

@end

@implementation PreferencesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
		
		[self initParamter];
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

//Viewが表示される直前に実行される
- (void)viewWillAppear:(BOOL)animated {
	NSIndexPath* selection = [m_tableView indexPathForSelectedRow];
	if(selection){
		[m_tableView deselectRowAtIndexPath:selection animated:YES];
	}
	[m_tableView reloadData];
}

//Viewが表示された直後に実行される
- (void)viewDidAppear:(BOOL)animated {
	[m_tableView flashScrollIndicators];
}

// *****************************************************************
//	@brief	Initialization for user preferens.
//	@note
//		Nothing
// *****************************************************************
- (void) initParamter
{
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	
	// read setting
	m_setting_sound = [ud boolForKey:@"KEY_SOUND"];
	
	NSNumber* numTimeout = [ud objectForKey:@"KEY_TIMEOUT"];
	if ( [numTimeout integerValue] > 0 ) {
		m_setting_timeout = YES;
	}
	else {
		m_setting_timeout = NO;
	}
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
	UINavigationItem* title = [[UINavigationItem alloc] initWithTitle:@"設定"];
	UIBarButtonItem* btnItemSetting = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(actFinishOnNaviBar:)];
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
	
	// Set table view
	CGRect rectTable = mainDisplayView.bounds;
	m_tableView = [[UITableView alloc] initWithFrame:rectTable style:UITableViewStyleGrouped];
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
	// save preferences
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];  // 取得
	NSIndexPath* indexPath = [NSIndexPath alloc];
	
	indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	CellWithSwitch *soundCell = (CellWithSwitch*)[m_tableView cellForRowAtIndexPath:indexPath];
	[ud setBool:soundCell.theSwitch.on forKey:@"KEY_SOUND"];

	indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
	CellWithSwitch *timeoutCell = (CellWithSwitch*)[m_tableView cellForRowAtIndexPath:indexPath];
	NSNumber *numTimeout;
	if ( timeoutCell.theSwitch.on == YES ) {
		numTimeout = [NSNumber numberWithInt:5];
	}
	else {
		numTimeout = [NSNumber numberWithInt:-1];
	}
	[ud setObject:numTimeout forKey:@"KEY_TIMEOUT"];
	
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
	return 2;
}

// The number of rows in table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

// Create cell object for table view.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		switch (indexPath.section) {
				
			case 0:
				
				switch (indexPath.row) {
						
					case 0:
					{
						cell = [[CellWithSwitch alloc] initWithReuseIdentifier:CellIdentifier];
						CellWithSwitch* switchCell = (CellWithSwitch*)cell;
						switchCell.theSwitch.on = m_setting_sound;
						cell.textLabel.text = @"サウンドのON/OFF";
						break;
					}
					default:
						cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
						cell.textLabel.text = [NSString stringWithFormat:@"%@ %li", @"row Don't display here.", (long)indexPath.row];
						break;
				}
				break;

			case 1:
				
				switch (indexPath.row)
				{
					case 0:
					{
						cell = [[CellWithSwitch alloc] initWithReuseIdentifier:CellIdentifier];
						CellWithSwitch* switchCell = (CellWithSwitch*)cell;
						switchCell.theSwitch.on = m_setting_timeout;
						cell.textLabel.text = @"タイムアウト(5sec)";
						break;
					}
					default:
						cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
						cell.textLabel.text = [NSString stringWithFormat:@"%@ %li", @"row Don't display here.", (long)indexPath.row];
						break;
				}
				break;
				
			default:
				cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
				cell.textLabel.text = [NSString stringWithFormat:@"%@ %li", @"row Don't display here.", (long)indexPath.row];
				break;
		}
	}
	
	return cell;
}

// Set section title
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	switch(section)
	{
		case 0:
			return @"基本設定";
			break;
		case 1:
			return @"トレーニングモード設定";
			break;
		default:
			return @"Dont't display here.";
			break;
	}
	return nil; //ビルド警告回避用
}

@end

#pragma mark ----- CellWithSwitch -----

@implementation CellWithSwitch

- (id)initWithReuseIdentifier:(NSString*)identifier  {
	if ( (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier]) ) {
		self.theSwitch = [[UISwitch alloc] init];
		self.theSwitch.on = YES;
		self.theSwitch.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
		UIViewAutoresizingFlexibleRightMargin |
		UIViewAutoresizingFlexibleTopMargin |
		UIViewAutoresizingFlexibleBottomMargin;
		self.contentMode = UIViewContentModeRight;
		[self addSubview:self.theSwitch];
	}
	return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	CGRect cellRect = self.contentView.frame;
	CGPoint newCenter = self.contentView.center;
	newCenter.x = cellRect.size.width - (self.theSwitch.frame.size.width/2);
	self.theSwitch.center = newCenter;
}

@end
