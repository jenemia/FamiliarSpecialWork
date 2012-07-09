//
//  SpecialWordViewController.m
//  FamiliarSpecialWord
//
//  Created by Soohyun Kim on 12. 7. 7..
//  Copyright (c) 2012년 rlatngus0333@naver.com. All rights reserved.
//

#import "SpecialWordViewController.h"
#import "AppDelegate.h"
#import "DBAdapter.h"

@interface SpecialWordViewController ()

@end

@implementation SpecialWordViewController

@synthesize mScrollView;
@synthesize mDBAdater;
@synthesize mCountView;

static NSString* g_Con;

- (id)init{
    self = [super init];
    [self.view setFrame:CGRectMake(0, 0, 320, 460)];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor yellowColor]];   

    mDBAdater = [AppDelegate sharedDBAdapter];
    
	// Do any additional setup after loading the view.    
    mScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 145, 320, 235)];

    mScrollView.pagingEnabled = YES; //스크롤 할때 페이지 마다 툭툭 끊키게
    [self.view addSubview:mScrollView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewWillAppear:(BOOL)animated
{   
    //mScrollView에 기존에 있던 subView들을 삭제.
    for( UIView* temp in mScrollView.subviews )
    {
        [temp removeFromSuperview];
    }
    
    //DB에서 특수 문자를 가져온다.
    NSMutableArray* _array = [mDBAdater SelectToSpecialWord:g_Con];
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 235)];
    
    NSInteger _ViewCnt = 0;
    NSInteger _XCnt = 0;
    NSInteger _YCnt = 0;
    for( NSString* _str in _array )
    {
        CGFloat _x = 20 + 60*_XCnt;
        CGFloat _y = 5 +  60*_YCnt;
        UIButton* _button = [self CreateButton:_str type:UIButtonTypeRoundedRect 
                                         frame:CGRectMake(_x, _y, 45, 45) target:self action:nil img:@""];
        [view addSubview:_button];
      
        NSLog(@"%@%f%f", _str, _x, _y );
        
        _XCnt++;
        if( _XCnt == 5 ) //한 줄에 5개, 
        {
            _XCnt = 0;
            _YCnt++;
        }
        if( _YCnt == 4 ) //한 View에 4줄
        {
            [mScrollView addSubview:view];
            
            _XCnt = 0;
            _YCnt = 0;
            _ViewCnt++;
            //다음 페이지에 보여질 View 생성
            view = [[UIView alloc]initWithFrame:CGRectMake(320*_ViewCnt, 0, 320, 235)];
        }
    }
    [mScrollView addSubview:view]; //마지막 View 생성
    mScrollView.contentSize = CGSizeMake(320*(_ViewCnt+1), 235);
    [super viewWillAppear:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

+(void)SetCon:(NSString *)con
{
    g_Con = [[NSString alloc]initWithFormat:con];
}

#pragma mark Method
-(UIButton*)CreateButton:(NSString *)title type:(UIButtonType)type frame:(CGRect)frame target:(id)target action:(SEL)action img:(NSString *)img
{
    UIButton* button = [UIButton buttonWithType:type];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    if( img != @"" )
    {
        UIImage* _img = [UIImage imageNamed:img];
        [button setBackgroundImage:_img forState:UIControlStateNormal];
    }
    return button;
}

@end
