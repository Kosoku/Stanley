//
//  ViewController.m
//  Demo-macOS
//
//  Created by William Towe on 4/18/17.
//  Copyright © 2017 Kosoku Interactive, LLC. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "ViewController.h"

#import <Stanley/Stanley.h>

@interface ViewController ()
@property (weak,nonatomic) IBOutlet NSTextField *phoneNumberTextField;

@property (strong,nonatomic) KSTDirectoryWatcher *directoryWatcher;
@property (strong,nonatomic) KSTFileWatcher *fileWatcher;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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

@end
