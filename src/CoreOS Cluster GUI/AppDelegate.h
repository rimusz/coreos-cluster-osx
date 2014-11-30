//
//  AppDelegate.h
//  CoreOS Cluster GUI for OS X
//
//  Created by Rimantas on 01/04/2014.
//  Copyright (c) 2014 Rimantas Mocevicius. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSUserNotificationCenterDelegate>

@property (strong, nonatomic) IBOutlet NSMenu *statusMenu;
@property (strong, nonatomic) NSStatusItem *statusItem;

@property(strong) NSWindowController *myWindowController;

@property(strong) NSString *resoucesPathFromApp;

@end
