//
//  ViewController.m
//  FamiliarSpecialWork
//
//  Created by Soohyun Kim on 12. 7. 4..
//  Copyright (c) 2012년 rlatngus0333@naver.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize mTextFieldMain;

@synthesize mButtonKatok;
@synthesize mButtonEmoticonAdd;
@synthesize mButtonEmoticonMine;
@synthesize mButtonEmoticonBookmark;
@synthesize mButtonEmoticonCollection;
@synthesize mArrayButton;
             
- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view setBackgroundColor:[UIColor yellowColor]]; //다른 object들이 보이도록 임시로 view를 노란색으로.
    
    mTextFieldMain = [[UITextField alloc]initWithFrame:CGRectMake(10, 50, 300, 31)];
    mTextFieldMain.borderStyle = UITextBorderStyleRoundedRect; //모서리 부분을 둥글게
    [mTextFieldMain setBackgroundColor:[UIColor whiteColor]]; 
    
    [self.view addSubview:mTextFieldMain];
    
    mButtonKatok = [self CreateButton:@"카톡 보내기" type:UIButtonTypeRoundedRect 
                                frame:CGRectMake(10, 95, 85, 37) target:self action:nil img:@""];
    mButtonEmoticonAdd = [self CreateButton:@"이모티콘 추가" type:UIButtonTypeRoundedRect 
                                      frame:CGRectMake(200, 95, 110, 37) target:self action:nil img:@""];
    mButtonEmoticonCollection = [self CreateButton:@"이모티콘 모음" type:UIButtonTypeRoundedRect 
                                             frame:CGRectMake(180, 335, 130, 37) target:self action:nil img:@""];
    mButtonEmoticonMine = [self CreateButton:@"사용자 이모티콘" type:UIButtonTypeRoundedRect 
                                       frame:CGRectMake(180, 380, 130, 37) target:self action:nil img:@""];
    mButtonEmoticonBookmark = [self CreateButton:@"즐겨찾기" type:UIButtonTypeRoundedRect 
                                           frame:CGRectMake(20, 380, 70, 37) target:self action:nil img:@""];
    
    [self.view addSubview:mButtonKatok];
    [self.view addSubview:mButtonEmoticonAdd];
    [self.view addSubview:mButtonEmoticonCollection];
    [self.view addSubview:mButtonEmoticonMine];
    [self.view addSubview:mButtonEmoticonBookmark];
    
    mArrayButton = [NSMutableArray array];
    NSInteger _cnt = 14;
    CGFloat _width = 60;
    int _num = 0;
    for( NSInteger i=0; i<_cnt; i++ )
    {
        CGFloat _x = 20 + (i/5)*10; //2번 째 줄은 x좌표가 10만큼 더, 3번 째 줄은 20만큼 더.
        CGFloat _y = 155 + (i/5)*55;

        [mArrayButton addObject: [self CreateButton:@"" type:UIButtonTypeRoundedRect 
                                               frame:CGRectMake(_x + _width*_num, _y, 40, 40) target:self action:nil img:@""]];
        _num++;
        if( 0 == (_num%5) )
            _num = 0;
    }
    
    for( UIButton* _button in mArrayButton )
    {
        [self.view addSubview:_button];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark CreateMethod
/*    
 Button생성시 필요한 것들을 모아 Method로 만든 것.
 title : Button에 보이는 문자열
 type : Button의 생김새
 frame : Button의 위치 및 크기
 target : Button의 event를 처리할 부분을 설정하는 곳. self면 현재 소스파일에서 처리한다는 것.
 action : Button evnetf를 처리할 method. 여기선 Click Event
 img : Background에 그릴 Image
 */
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
