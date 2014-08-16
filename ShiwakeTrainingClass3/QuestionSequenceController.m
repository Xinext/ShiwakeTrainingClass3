//
//  QuestionSequenceController.m
//  ShiwakeTrainingClass3
//
//  Created by Hiroaki Fujisawa on 2012/12/16.
//  Copyright (c) 2012年 Hiroaki Fujisawa. All rights reserved.
//

#import "QuestionSequenceController.h"

@implementation QuestionSequenceController

// *****************************************************************
//	@brief	Initilazer
//	@note
//
// *****************************************************************
- (id)init
{
	self = [super init];
	if (self != nil) {

		// Initialize for member variable
		m_questionNumber = 0;
		m_questionArray = [NSMutableArray array];
		m_questionNumberArray = [NSMutableArray array];
		m_KamokuDictionary = [NSMutableDictionary dictionary];
		
		// create Question data array

		#define QESTION_DATA_NUMBER		2
		
		QuestionStr QuestionData[QESTION_DATA_NUMBER] =
		{
			{ "test1", 0 },
			{ "test2", 1 }
		};
		
		NSArray *kamoku = [NSArray arrayWithObjects:@"dummy1", @"dummy2", nil];
		
		[self initData:QuestionData numberOfData:QESTION_DATA_NUMBER kamokuName:kamoku];
	}
	return self;
}

// *****************************************************************
//	@brief	(Re)Initiolaize data
//	@note
//
// *****************************************************************
- (void) initData:(QuestionStr*)questionData numberOfData: (NSInteger)num kamokuName:(NSArray*)kamoku
{
	[self initQuestionArrayData:questionData numberOfData:num];
	[self initKamokuList:questionData numberOfData:num kamokuName:kamoku];
}

// *****************************************************************
//	@brief	(Re)Initiolaize Question data
//	@note
//
// *****************************************************************
- (void) initQuestionArrayData: (QuestionStr*)questionData numberOfData: (NSInteger)num
{
	// Initilaize array
	[m_questionArray removeAllObjects];
	[m_questionNumberArray removeAllObjects];

	// create question data array
	NSMutableArray *tmpNumberArray = [NSMutableArray array];
	NSInteger dataIndex;
	for (dataIndex = 0; dataIndex<num; dataIndex++) {
		
		NSString* name = [NSString stringWithCString: questionData[dataIndex].kamokuName encoding:NSUTF8StringEncoding];
		[self addQuestion:name typeOfkamoku:questionData[dataIndex].kamokuType];
		
		// prepare for random number array
		[tmpNumberArray addObject:[NSNumber numberWithInteger:dataIndex]];
	}
	
	// create random number array
	srand([[NSDate date] timeIntervalSinceReferenceDate]);
	[m_questionNumberArray removeAllObjects];
	for (dataIndex = num; dataIndex > 0; dataIndex--) {
		int pickupPosition = rand()%dataIndex;
		[m_questionNumberArray addObject:[tmpNumberArray objectAtIndex:pickupPosition]];
		[tmpNumberArray removeObjectAtIndex:pickupPosition];
	}
}

// *****************************************************************
//	@brief	(Re)Initiolaize Kamoku list dictionary
//	@note
//
// *****************************************************************
- (void) initKamokuList: (QuestionStr*)questionData numberOfData: (NSInteger)num kamokuName:(NSArray*)kamokuKind
{
	if ( m_KamokuDictionary != nil ) {
		[m_KamokuDictionary removeAllObjects];
	}
	else {
		m_KamokuDictionary = [NSMutableDictionary dictionary];
	}
	
	NSInteger	index;
	for (index=0; index<[kamokuKind count]; index++) {
		NSMutableArray *newMArray = [NSMutableArray array];
		[m_KamokuDictionary setObject:newMArray forKey:[kamokuKind objectAtIndex:index]];
	}
	
	for (index=0; index<num; index++)
	{
		NSString* key = [kamokuKind objectAtIndex:questionData[index].kamokuType];
		NSMutableArray*	tempMArray = [m_KamokuDictionary objectForKey:key];
		
		[tempMArray addObject:[NSString stringWithCString: questionData[index].kamokuName encoding:NSUTF8StringEncoding]];
	}
}

- (void) initSeq
{
	[m_questionArray removeAllObjects];
}

- (void) nextQuestion;
{
	m_questionNumber += 1;
	if ( m_questionNumber >= m_questionArray.count) {	// check ring buffer
		m_questionNumber = 0;
	}
}

- (NSString*) getQuestionKamoku;
{
	QuestionObjct* question = [self getQuestion:m_questionNumber];

	return question.kamokuName;
	
}

- (NSInteger) getAnswerNumber
{
	QuestionObjct* question = [self getQuestion:m_questionNumber];
	
	return question.kamokuType;
}

- (BOOL) checkAnswer: (NSInteger)answerNumber
{
	QuestionObjct* question = [self getQuestion:m_questionNumber];
	
	BOOL checkResult = FALSE;
	if ( question.kamokuType == answerNumber ) {
		checkResult = TRUE;
	}
	else {
		checkResult = FALSE;
	}
	
	return checkResult;
}

- (void) addQuestion: (NSString*)name typeOfkamoku: (NSInteger)type
{
	QuestionObjct* question = [[QuestionObjct alloc]initWithData:name typeOfkamoku:type];
	[m_questionArray addObject:question];
}

- (QuestionObjct*) getQuestion: (NSInteger)position
{
	QuestionObjct* question = nil;
	
	if ( m_questionNumberArray.count > position) {
		
		NSNumber* index = [m_questionNumberArray objectAtIndex:position];
		question = [m_questionArray objectAtIndex:[index integerValue]];
	}
	else {
		question = nil;
	}
	
	NSAssert( question != nil, @"Invalid access to question array.");

	return question;
}

// *****************************************************************
//	@brief	Provide Kamoku name list
//	@note
//
// *****************************************************************
- (NSMutableDictionary*) getKamokuDictionary
{
	return m_KamokuDictionary;
}


@end

#pragma mark ----- struct Question -----

@implementation QuestionObjct

- (id)initWithData:(NSString*)name typeOfkamoku: (UInt16)type
{
	self = [super init];
	if (self != nil) {
		self.kamokuName = name;
		self.kamokuType = type;
	}
	return self;
}


@end
