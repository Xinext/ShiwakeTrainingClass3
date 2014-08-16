//
//  BackSoundController.m
//  ShiwakeTrainingClass3
//
//  Created by Hiroaki Fujisawa on 2012/12/13.
//  Copyright (c) 2012年 Hiroaki Fujisawa. All rights reserved.
//

#import "BackSoundController.h"

@implementation BackSoundController

- (id)init
{
	self = [super init];
	if (self) {
		// Initialization code
		NSString *pathOK = [[NSBundle mainBundle] pathForResource:@"se_ok" ofType:@"wav"];
		NSURL *urlOK = [NSURL fileURLWithPath:pathOK];
		m_audio_OK = [[AVAudioPlayer alloc] initWithContentsOfURL:urlOK error:nil];

		NSString *pathNG = [[NSBundle mainBundle] pathForResource:@"se_ng" ofType:@"wav"];
		NSURL *urlNG = [NSURL fileURLWithPath:pathNG];
		m_audio_NG = [[AVAudioPlayer alloc] initWithContentsOfURL:urlNG error:nil];
	}
	return self;
}

- (BOOL) getSoundEnable
{
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	
	return [ud boolForKey:@"KEY_SOUND"];
}

// Execute to play sound of OK.
- (void) playOK
{
	BOOL	enableFlag = [self getSoundEnable];

	m_audio_OK.currentTime = 0;
	[m_audio_NG stop];
	
	if ( enableFlag == TRUE ) {

		[m_audio_OK play];
	}
	else {
		// no action
	}
}

// Execute to play sound of NG.
- (void) playNG;
{
	BOOL	enableFlag = [self getSoundEnable];

	[m_audio_OK stop];
	m_audio_NG.currentTime = 0;

	if ( enableFlag == TRUE ) {
	
		[m_audio_NG play];
	}
	else {
		// no action
	}
}


@end
