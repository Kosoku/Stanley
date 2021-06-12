//
//  ViewController.m
//  Demo-macOS
//
//  Created by William Towe on 4/18/17.
//  Copyright © 2021 Kosoku Interactive, LLC. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

#import "ViewController.h"

#import <Stanley/Stanley.h>

@interface ViewController ()
@property (weak,nonatomic) IBOutlet NSTextField *phoneNumberTextField;
@property (weak,nonatomic) IBOutlet NSTextField *reachabilityLabel;

@property (strong,nonatomic) KSTDirectoryWatcher *directoryWatcher;
@property (strong,nonatomic) KSTFileWatcher *fileWatcher;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(_statusDidChange:) name:KSTReachabilityManagerNotificationDidChangeStatus object:nil];
    
    [KSTReachabilityManager.sharedManager startMonitoringReachability];
}
- (void)viewDidAppear {
    [super viewDidAppear];
    
    [self.phoneNumberTextField becomeFirstResponder];
}

- (IBAction)_watchDirectoryAction:(id)sender {
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    
    [openPanel setCanChooseDirectories:YES];
    [openPanel setCanChooseFiles:NO];
    [openPanel setPrompt:@"Watch"];
    
    [openPanel beginSheetModalForWindow:self.view.window completionHandler:^(NSInteger result) {
        [self setDirectoryWatcher:[[KSTDirectoryWatcher alloc] initWithURLs:@[openPanel.URLs.firstObject] block:^(KSTDirectoryWatcher * _Nonnull fileWatcher, FSEventStreamEventId eventID, FSEventStreamEventFlags flags, NSURL * _Nonnull URL) {
            NSLog(@"%@ %@ %@",@(eventID),@(flags),URL);
        }]];
        
        [self.directoryWatcher startWatchingURLs];
    }];
}
- (IBAction)_watchFilesAction:(id)sender {
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    
    [openPanel setAllowsMultipleSelection:YES];
    [openPanel setPrompt:@"Watch"];
    
    [openPanel beginSheetModalForWindow:self.view.window completionHandler:^(NSInteger result) {
        [self setFileWatcher:[[KSTFileWatcher alloc] initWithURLs:openPanel.URLs block:^(KSTFileWatcher * _Nonnull fileWatcher, NSURL * _Nonnull URL, KSTFileWatcherFlags flags) {
            NSLog(@"%@ %@",URL,@(flags));
        }]];
    }];
}

- (void)_statusDidChange:(NSNotification *)note {
    KSTReachabilityManagerStatus status = [note.userInfo[KSTReachabilityManagerUserInfoKeyStatus] integerValue];
    NSColor *textColor = NSColor.textColor;
    
    switch (status) {
        case KSTReachabilityManagerStatusNotReachable:
            textColor = [NSColor colorWithRed:0.75 green:0 blue:0 alpha:1];
            break;
        case KSTReachabilityManagerStatusReachableViaWWAN:
            textColor = NSColor.orangeColor;
            break;
        case KSTReachabilityManagerStatusReachableViaWiFi:
            textColor = [NSColor colorWithRed:0 green:0.75 blue:0 alpha:1];
            break;
        default:
            break;
    }
    
    [self.reachabilityLabel setTextColor:textColor];
    [self.reachabilityLabel setStringValue:[KSTReachabilityManager localizedStringForStatus:status]];
}

@end
