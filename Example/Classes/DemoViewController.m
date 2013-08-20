//
//  DemoViewController.m
//  CJAMacros
//
//  Created by Carl Jahn on 20.08.13.
//  Copyright (c) 2013 Carl Jahn. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self performLogMacros];
  [self performLocalizationMacro];
  [self performMainThreadMacro];
  [self performRuntimeChecks];

}

- (void)performLogMacros {

  //Should output the current function fingerprint
	kNSLogFunction
  
  //Should output the current function fingerprint + and the given object description
  kNSLogFunctionWithObject(@"My test log");
  kNSLogFunctionWithObject(self);
  
  //Use the Error Log to log statements in RELEASE mode
  ErrorLog(@"Always print this");


}

- (void)performLocalizationMacro {

  //Localization Shortcut
  NSString *localString = _(@"MyTestLocalizationStrinKey");
  kNSLogFunctionWithObject(localString);
}

- (void)performNotificationMacros {
  
  static NSString *testNotificationName = @"TestNotificationName";
  
  addObserver(testNotificationName, self, testNotification:, nil);
  
  notify(testNotificationName, nil, nil);
  
  removeObserver(self);
}

- (void)testNotification:(NSNotification *)notification {
  kNSLogFunctionWithObject(notification.name);
}


- (void)performMainThreadMacro {

  onMainThread(
               kNSLogFunctionWithObject(@"This should be on the Main Thread");
               notify(@"NotificationOnMainThread", nil, nil);
  );
  
}

- (void)performRuntimeChecks {

  if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO( _iOS_7_0) ) {
    kNSLogFunctionWithObject(@"Why are on iOS 7")
  }
  
  //you can always use the normal NSFoundationVersionNumber's
  if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO( NSFoundationVersionNumber_iOS_7_0)) {
    kNSLogFunctionWithObject(@"same runtime check as above")
  }
  
  if (SYSTEM_VERSION_LESS_THAN( _iOS_7_0) ) {
    kNSLogFunctionWithObject(@"Why are on iOS 6, 5, 4, 3 or 2");
  }
  

  
}

@end
