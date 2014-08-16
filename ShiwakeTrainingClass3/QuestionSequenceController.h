//
//  QuestionSequenceController.h
//  ShiwakeTrainingClass3
//
//  Created by Hiroaki Fujisawa on 2012/12/16.
//  Copyright (c) 2012年 Hiroaki Fujisawa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionSequenceController : NSObject
{
	
	NSInteger				m_questionNumber;
	NSMutableArray*			m_questionArray;
	NSMutableArray*			m_questionNumberArray;
	NSMutableDictionary*	m_KamokuDictionary;

}

- (void) initSeq;
- (void) nextQuestion;
- (NSString*) getQuestionKamoku;
- (NSInteger) getAnswerNumber;
- (BOOL) checkAnswer: (NSInteger)answerNumber;
- (NSMutableDictionary*) getKamokuDictionary;

typedef struct {
	char*		kamokuName;
	int			kamokuType;
} QuestionStr;

- (void) initData:(QuestionStr*)questionData numberOfData: (NSInteger)num kamokuName:(NSArray*)kamoku;

@end

#pragma mark ----- struct Question  -----

@interface QuestionObjct : NSObject
{
}

@property (nonatomic, retain) NSString*	kamokuName;
@property NSInteger	kamokuType;

- (id)initWithData:(NSString*)name typeOfkamoku: (UInt16)type;

@end
