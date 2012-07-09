//
//  SpecialWordViewController.h
//  FamiliarSpecialWord
//
//  Created by Soohyun Kim on 12. 7. 7..
//  Copyright (c) 2012년 rlatngus0333@naver.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DBAdapter;
@interface SpecialWordViewController : UIViewController

@property (strong, nonatomic) UIScrollView* mScrollView;
@property (nonatomic) NSInteger mCountView;

- (id)init;
@property (strong, nonatomic) DBAdapter* mDBAdater;
+(void)SetCon:(NSString*)con;
@end
