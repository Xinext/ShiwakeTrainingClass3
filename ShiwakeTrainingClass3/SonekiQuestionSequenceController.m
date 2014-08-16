//
//  SonekiQuestionSequenceController.m
//  ShiwakeTrainingClass3
//
//  Created by Hiroaki Fujisawa on 2013/01/25.
//  Copyright (c) 2013年 Hiroaki Fujisawa. All rights reserved.
//

#import "SonekiQuestionSequenceController.h"

@implementation SonekiQuestionSequenceController

- (id)init
{
	self = [super init];
	if (self != nil) {
		
		// create Question data array
		
		#define QESTION_DATA_NUMBER		33
		
		QuestionStr QuestionData[QESTION_DATA_NUMBER] =
		{
			{ "貸倒損失",			0 },
			{ "貸倒引当金繰入",	0 },
			{ "減価償却費",		0 },
			{ "固定資産売却損",	0 },
			{ "雑損",			0 },
			{ "雑費",			0 },
			{ "仕入",			0 },
			{ "消耗品費",			0 },
			{ "租税公課",			0 },
			{ "通信費	",			0 },
			{ "手形売却損",		0 },
			{ "有価証券売却損",	0 },
			{ "有価証券評価損",	0 },
			{ "旅費交通費",		0 },
			{ "発送費",			0 },
			{ "給料",			0 },
			{ "支払利息",			0 },
			{ "支払保険料",		0 },
			{ "支払家賃",			0 },
			{ "支払手数料",		0 },
			{ "受取手数料",		1 },
			{ "受取配当金",		1 },
			{ "売上",			1 },
			{ "貸倒引当金戻入",	1 },
			{ "固定資産売却益",	1 },
			{ "雑益",			1 },
			{ "償却債権取立益",	1 },
			{ "有価証券売却益",	1 },
			{ "有価証券評価益",	1 },
			{ "有価証券利息",		1 },
			{ "受取家賃",			1 },
			{ "受取地代",			1 },
			{ "受取利息",			1 }
		};
		
		NSArray *kamoku = [NSArray arrayWithObjects:@"費用", @"収益", nil];
		
		[self initData:QuestionData numberOfData:QESTION_DATA_NUMBER kamokuName:kamoku];
	}
	return self;
}

@end
