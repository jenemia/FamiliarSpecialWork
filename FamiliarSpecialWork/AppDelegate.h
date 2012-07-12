//
//  AppDelegate.h
//  FamiliarSpecialWork
//
//  Created by Soohyun Kim on 12. 7. 4..
//  Copyright (c) 2012년 rlatngus0333@naver.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;
@class DBAdapter;
@class SpecialWordViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;

+(DBAdapter*)sharedDBAdapter;
+(SpecialWordViewController*)shareSpeciaWord;
+(NSMutableArray*)shareWordArray;

@end
