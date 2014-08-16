//
//  UIMemoView.h
//  ShiwakeTrainingClass3
//
//  Created by Hiroaki Fujisawa on 2012/12/27.
//  Copyright (c) 2012年 Hiroaki Fujisawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIMemoView : UIView
{
	UILabel*	m_lblMemo;
}

- (void) setText: (NSString*)dispText;

@end
