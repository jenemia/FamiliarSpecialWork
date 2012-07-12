//
//  AppDelegate.m
//  FamiliarSpecialWork
//
//  Created by Soohyun Kim on 12. 7. 4..
//  Copyright (c) 2012년 rlatngus0333@naver.com. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "DBAdapter.h"
#import "SpecialWordViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

static DBAdapter* g_DBAdapter;
static SpecialWordViewController* g_SpecialWord;
static NSMutableArray* g_WordArray;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[ViewController alloc]init];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

+(DBAdapter*)sharedDBAdapter
{
    if( g_DBAdapter == nil )
    {
        g_DBAdapter = [[DBAdapter alloc]init];
    }
    return g_DBAdapter;
}

+(SpecialWordViewController*)shareSpeciaWord
{
    if( g_SpecialWord == nil )
    {
        g_SpecialWord = [[SpecialWordViewController alloc]init];        
    }
    return g_SpecialWord;
}

+(NSMutableArray*)shareWordArray
{
    if( g_WordArray == nil )
    {
        g_WordArray = [[NSMutableArray alloc]init];
    }
    return g_WordArray;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
