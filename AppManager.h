//
//  AppManager.h
//  
// Created by KC Reaney on 12/05/2011.
//
// Copyright 2011 KC Reaney. All rights reserved.
// MIT Licensed

#import <Foundation/Foundation.h>

#import <Cordova/CDVPlugin.h>

@interface AppManager : CDVPlugin {}

//List out all installed Applications on the device
- (void) listApps:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;
 
@end
