//
//  ViewController.m
//  Demo-iOS
//
//  Created by William Towe on 9/29/17.
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
@property (weak,nonatomic) IBOutlet UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    (void)NSBundle.KST_currentBundle;
    
    [self.label setText:[KSTReachabilityManager localizedStringForStatus:KSTReachabilityManagerStatusUnknown]];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(_statusDidChange:) name:KSTReachabilityManagerNotificationDidChangeStatus object:nil];
    
    [KSTReachabilityManager.sharedManager startMonitoringReachability];
}

- (void)_statusDidChange:(NSNotification *)note {
    KSTReachabilityManagerStatus status = [note.userInfo[KSTReachabilityManagerUserInfoKeyStatus] integerValue];
    
    [self.label setText:[KSTReachabilityManager localizedStringForStatus:status]];
}

@end
