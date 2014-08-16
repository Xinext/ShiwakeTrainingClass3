//
//  PreferencesViewController.h
//  ShiwakeTrainingClass3
//
//  Created by Hiroaki Fujisawa on 2012/12/02.
//  Copyright (c) 2012年 Hiroaki Fujisawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreferencesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
	UITableView* m_tableView;
	
	BOOL	m_setting_sound;
	BOOL	m_setting_timeout;
}

@end

#pragma mark ----- CellWithSwitch -----

@interface CellWithSwitch : UITableViewCell
{
@private
	UISwitch* theSwitch_;
}

@property (nonatomic, retain) UISwitch* theSwitch;

- (id)initWithReuseIdentifier:(NSString*)identifier;

@end
