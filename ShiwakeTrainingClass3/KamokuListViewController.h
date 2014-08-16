//
//  KamokuListViewController.h
//  ShiwakeTrainingClass3
//
//  Created by Hiroaki Fujisawa on 2013/03/14.
//  Copyright (c) 2013年 Hiroaki Fujisawa. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SonekiQuestionSequenceController.h"
#import "TaishakuQuestionSequenceController.h"

@interface KamokuListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
	UITableView*	m_tableView;
	NSArray*		m_sectionTitle;
	
	SonekiQuestionSequenceController*	m_seqCtlSoneki;
	TaishakuQuestionSequenceController*	m_seqCtlTaishaku;
	NSMutableDictionary*	m_joinDictionaty;
}
@end
