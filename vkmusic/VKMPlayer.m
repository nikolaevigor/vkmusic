//
//  VKMPlayer.m
//  vkmusic
//
//  Created by Igor Nikolaev on 02/01/16.
//  Copyright © 2016 Igor Nikolaev. All rights reserved.
//

#import "VKMPlayer.h"
#import "AVFoundation/AVFoundation.h"
#import "VKMFileManager.h"
#import "STKAudioPlayer.h"
#import "STKLocalFileDataSource.h"

@interface VKMPlayer() <STKAudioPlayerDelegate>

@property (strong, nonatomic) STKAudioPlayer *player;
@property (strong, nonatomic) VKMAudioNode *currentNode;
@property (strong, nonatomic) NSArray *tracks;
@property (strong, nonatomic) NSMutableArray *frequenciesSet;

@end

@implementation VKMPlayer

- (nonnull instancetype)init
{
    if (self = [super init]) {
        self.player = [[STKAudioPlayer alloc] init];
        self.player.delegate = self;
        self.frequenciesSet = [NSMutableArray arrayWithArray:@[@0, @0, @0, @0, @0, @0]];
    }
    return self;
}

- (void)play:(NSArray *)tracks startingFrom:(NSInteger)initialTrack
{
    self.tracks = tracks;
    switch ([self.player state]) {
        case STKAudioPlayerStatePlaying:
            if ([self.currentNode isEqual:tracks[initialTrack]])
            {
                [self.player pause];
            }
            else
            {
                self.currentNode = tracks[initialTrack];
                [self.player dispose];
                [self setupPlayer];
            }
            break;
        case STKAudioPlayerStatePaused:
            if ([self.currentNode isEqual:tracks[initialTrack]])
            {
                [self.player resume];
            }
            else
            {
                self.currentNode = tracks[initialTrack];
                [self setupPlayer];
            }
            break;
        case STKAudioPlayerStateStopped:
            self.currentNode = tracks[initialTrack];
            [self setupPlayer];
            break;
            
        case STKAudioPlayerStateError:
            self.currentNode = tracks[initialTrack];
            [self setupPlayer];
            break;
            
        default:
            NSLog(@"It's a trap!");
            break;
    }
    
}

- (void)stop
{
    [self.player stop];
}

- (void)pause
{
    [self.player pause];
}

- (void)resume
{
    [self.player resume];
}

- (void)playNext
{
    self.tracks = [VKMFileManager loadTracksFromEntity:@"Track"];
    if (self.tracks.count == 0) {
        return;
    }
    NSUInteger currentNodeIndex = [self getIndexOfCurrentNode];
    if (currentNodeIndex+1 < self.tracks.count)
    {
        self.currentNode = self.tracks[currentNodeIndex+1];
    }
    else
    {
        self.currentNode = self.tracks[0];
    }
    [self.player dispose];
    [self setupPlayer];
}

- (void)playPrevious
{
    self.tracks = [VKMFileManager loadTracksFromEntity:@"Track"];
    if (self.tracks.count == 0) {
        return;
    }
    NSInteger currentNodeIndex = [self getIndexOfCurrentNode];
    if (currentNodeIndex-1 >= 0)
    {
        self.currentNode = self.tracks[currentNodeIndex-1];
    }
    else
    {
        self.currentNode = self.tracks[self.tracks.count-1];
    }
    [self.player dispose];
    [self setupPlayer];
}

- (void)setEqualizerWithGain:(float)gain forBand:(int)band
{
    [self.player setGain:gain forEqualizerBand:band];
    self.frequenciesSet[band] = [NSNumber numberWithFloat:gain];
}

- (void)resetEQU
{
    for (int i = 0; i < self.frequenciesSet.count; i++) {
        [self.player setGain:0.0 forEqualizerBand:i];
    }
    self.frequenciesSet = [NSMutableArray arrayWithArray:@[@0, @0, @0, @0, @0, @0]];
}

- (NSArray *)getCurrentEQUFrequenciesSet
{
    return [NSArray arrayWithArray:self.frequenciesSet];
}

- (void)setupPlayer
{
    self.player = [[STKAudioPlayer alloc] initWithOptions:(STKAudioPlayerOptions){.equalizerBandFrequencies = {50, 100, 400, 800, 1600, 2600}}];
    self.player.delegate = self;
    self.player.equalizerEnabled = YES;
    for (int i = 0; i < self.frequenciesSet.count; i++) {
        [self.player setGain:[self.frequenciesSet[i] floatValue] forEqualizerBand:i];
    }
    STKLocalFileDataSource *localDataSource = [[STKLocalFileDataSource alloc] initWithFilePath:[self.currentNode path]];
    
    [self.player playDataSource:localDataSource withQueueItemID:[self.currentNode name]];
}

- (NSInteger)getIndexOfCurrentNode
{
    for (VKMAudioNode *node in self.tracks)
    {
        if ([[node path] isEqual:[self.currentNode path]]) {
            return (NSInteger)[self.tracks indexOfObject:node];
        }
    }
    return NSNotFound;
}

#pragma mark - STKAudioPlayerDelegate methods

/// Raised when an item has started playing
- (void)audioPlayer:(STKAudioPlayer*)audioPlayer didStartPlayingQueueItemId:(NSObject*)queueItemId
{
    
}
/// Raised when an item has finished buffering (may or may not be the currently playing item)
/// This event may be raised multiple times for the same item if seek is invoked on the player
- (void)audioPlayer:(STKAudioPlayer*)audioPlayer didFinishBufferingSourceWithQueueItemId:(NSObject*)queueItemId
{
    
}
/// Raised when the state of the player has changed
- (void)audioPlayer:(STKAudioPlayer*)audioPlayer stateChanged:(STKAudioPlayerState)state previousState:(STKAudioPlayerState)previousState
{
    
}
/// Raised when an item has finished playing
- (void)audioPlayer:(STKAudioPlayer*)audioPlayer didFinishPlayingQueueItemId:(NSObject*)queueItemId withReason:(STKAudioPlayerStopReason)stopReason andProgress:(double)progress andDuration:(double)duration
{
    //здесь исходя из стейта плеера надо условие намутить
    if (stopReason == STKAudioPlayerStopReasonEof)
    {
        [self playNext];
    }
}
/// Raised when an unexpected and possibly unrecoverable error has occured (usually best to recreate the STKAudioPlauyer)
- (void)audioPlayer:(STKAudioPlayer*)audioPlayer unexpectedError:(STKAudioPlayerErrorCode)errorCode
{
    
}

@end
