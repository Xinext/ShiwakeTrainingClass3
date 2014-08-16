//
//  TaishakuQuestionSequenceController.m
//  ShiwakeTrainingClass3
//
//  Created by Hiroaki Fujisawa on 2013/01/17.
//  Copyright (c) 2013年 Hiroaki Fujisawa. All rights reserved.
//

#import "TaishakuQuestionSequenceController.h"

@implementation TaishakuQuestionSequenceController

- (id)init
{
	self = [super init];
	if (self != nil) {
		
		// create Question data array
		
		#define QESTION_DATA_NUMBER		34
		
		QuestionStr QuestionData[QESTION_DATA_NUMBER] =
		{
			{ "受取手形",			0 },
			{ "売掛金",			0 },
			{ "仮払金",			0 },
			{ "繰越商品",			0 },
			{ "現金",			0 },
			{ "小口現金",			0 },
			{ "車両運搬具",		0 },
			{ "商品",			0 },
			{ "消耗品",			0 },
			{ "他店商品券",		0 },
			{ "手形貸付金",		0 },
			{ "当座預金",			0 },
			{ "売買目的有価証券",	0 },
			{ "前払金",			0 },
			{ "前払費用",			0 },
			{ "未収収益",			0 },
			{ "未収金",			0 },
			{ "立替金",			0 },
			{ "建物",			0 },
			{ "貸付金",			0 },
			{ "預り金",			1 },
			{ "買掛金",			1 },
			{ "仮受金	",			1 },
			{ "支払手形",			1 },
			{ "商品券	",			1 },
			{ "手形借入金",		1 },
			{ "当座借越",			1 },
			{ "前受金	",			1 },
			{ "前受収益",			1 },
			{ "未払金	",			1 },
			{ "未払費用",			1 },
			{ "借入金",			1 },
			{ "資本金	",			2 },
			{ "引出金",			2 }
		};
		
		NSArray *kamoku = [NSArray arrayWithObjects:@"資産", @"負債", @"純資産", nil];
		
		[self initData:QuestionData numberOfData:QESTION_DATA_NUMBER kamokuName:kamoku];
	}
	return self;
}

@end
