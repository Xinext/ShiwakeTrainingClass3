//
//  BackSoundController.h
//  ShiwakeTrainingClass3
//
//  Created by Hiroaki Fujisawa on 2012/12/13.
//  Copyright (c) 2012年 Hiroaki Fujisawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <AVFoundation/AVFoundation.h>

@interface BackSoundController : NSObject
{
	AVAudioPlayer *m_audio_OK;
	AVAudioPlayer *m_audio_NG;
}

- (void) playOK;
- (void) playNG;

@end
