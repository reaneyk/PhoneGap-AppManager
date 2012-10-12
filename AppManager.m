//
//  AppManager.m
//  
// Created by KC Reaney 12/05/2011.
//
// Copyright 2011 KC Reaney. All rights reserved.
// MIT Licensed

#import "AppManager.h"
#import <Cordova/JSONKit.h>

@implementation AppManager

//Thanks to: http://www.iphonedevsdk.com/forum/iphone-sdk-development/37103-finding-out-what-apps-installed.html
//for a good start getting this function pulled together
-(void)listApps:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options 
{
  NSString* callbackID = [arguments pop];

  static NSString *const cacheFileName = @"com.apple.mobile.installation.plist";
	NSString *relativeCachePath = [[@"Library" stringByAppendingPathComponent: @"Caches"] stringByAppendingPathComponent: cacheFileName];
  
	NSDictionary *cacheDict = nil;
	NSString *path = nil;
	// Loop through all possible paths the cache could be in
	for (short i = 0; 1; i++)
	{
    
		switch (i) {
      case 0: // Jailbroken apps will find the cache here; their home directory is /var/mobile
        path = [NSHomeDirectory() stringByAppendingPathComponent: relativeCachePath];
        break;
      case 1: // App Store apps and Simulator will find the cache here; home (/var/mobile/) is 2 directories above sandbox folder
        path = [[NSHomeDirectory() stringByAppendingPathComponent: @"../.."] stringByAppendingPathComponent: relativeCachePath];
        break;
      case 2: // If the app is anywhere else, default to hardcoded /var/mobile/
        path = [@"/var/mobile" stringByAppendingPathComponent: relativeCachePath];
        break;
      default: // Cache not found (loop not broken)
        return;
      break; }
		
		BOOL isDir = NO;
		if ([[NSFileManager defaultManager] fileExistsAtPath: path isDirectory: &isDir] && !isDir) // Ensure that file exists
			cacheDict = [NSDictionary dictionaryWithContentsOfFile: path];
		
		if (cacheDict) // If cache is loaded, then break the loop. If the loop is not "broken," it will return NO later (default: case)
			break;
	}
	
	NSDictionary *user = [cacheDict objectForKey: @"User"]; // Then all the user (App Store /var/mobile/Applications) apps
  /*for(id key in user)
    NSLog(@"key=%@ value=%@", key, [user objectForKey:key]);
   */
  
  //NSString *json = [user cdvjk_JSONString];
  
  CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary: user];
  [self writeJavascript: [pluginResult toSuccessCallbackString:callbackID]];

}
@end