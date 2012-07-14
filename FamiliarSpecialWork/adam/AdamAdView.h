//
//  AdamAdView.h
//  AdamPublisher
//
//  Copyright 2012 Daum Communications. All rights reserved.
/*
 * Copyright (c) 2007-2011, All-Seeing Interactive
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of the All-Seeing Interactive nor the
 *       names of its contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY All-Seeing Interactive ''AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL All-Seeing Interactive BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 A different license may apply to other software included in this package, 
 including GHUnit and Andrew Donoho's Reachability class. Please consult their 
 respective headers for the terms of their individual licenses.
*/
//

#import <UIKit/UIKit.h>

/**
 AdamAdView의 광고 전환효과 스타일.
 */
typedef enum {
    AdamAdViewTransitionStyleNone,              // 광고 전환효과 없음. 기본값.
    AdamAdViewTransitionStyleCurl,              // 기존 광고가 상단으로 말려 올라가며 새 광고가 나타나는 효과.
    AdamAdViewTransitionStyleFlip               // 광고 영역이 반대편으로 뒤집히며 새 광고가 나타나는 효과.
} AdamAdViewTransitionStyle;

/**
 광고 수신 실패에 대한 에러코드.
 */
typedef enum {
    AdamErrorTypeNoFillAd,                      // 현재 노출 가능한 광고가 없음.
    AdamErrorTypeNoClientId,                    // Client ID가 설정되지 않았음.
    AdamErrorTypeTooSmallAdView,                // 광고 뷰의 크기가 기준보다 작음.
    AdamErrorTypeInvisibleAdView,               // 광고 뷰가 화면에 보여지지 않고 있음.
    AdamErrorTypeAlreadyUsingAutoRequest,       // 이미 광고 자동요청 기능을 사용하고 있는 상태임.
    AdamErrorTypeTooShortRequestInterval,       // 허용되는 최소 호출 간격보다 짧은 시간 내에 광고를 재요청 했음.
    AdamErrorTypePreviousRequestNotFinished     // 이전 광고 요청에 대한 처리가 아직 완료되지 않았음.
} AdamErrorType;

@protocol AdamAdViewDelegate;

@interface AdamAdView : UIView <UIGestureRecognizerDelegate>

/**
 AdamAdViewDelegate 프로토콜을 구현한 delegate 객체.
 AdamAdViewDelegate 프로토콜의 모든 메소드는 optional이므로, 해당 메소드들을 사용하지 않는다면 할당하지 않아도 무방하다.
 일단 delegate 객체를 할당한 이후에는 해당 객체가 메모리에서 해제되지 않도록 주의해야 한다.
 delegate 객체가 해제될 때에는 이 속성에 nil 또는 새로운 delegate 객체를 할당해주어야 하며,
 그렇지 않은 경우 애플리케이션의 Crash를 유발할 수 있다.
 */
@property (nonatomic, assign) id <AdamAdViewDelegate> delegate;

/**
 Daum 으로부터 발급받은 client id 문자열.
 필수 속성이며, 정상적인 client id를 할당하지 않는 경우 유효 광고 수신이 불가능하다.
 샘플 코드에서는 TestClientId 문자열을 사용하나, 이것은 테스트 용도로만 사용해야 한다.
 또한 이 값은 적립금을 쌓는 기준이 되기 때문에, 애플리케이션 배포 전에 발급받은 Client ID를 정확히 입력했는지 반드시 확인해야 한다.
 */
@property (nonatomic, copy) NSString *clientId;

/**
 광고 클릭시 광고 페이지를 modalViewController로 화면에 보여줄 부모 뷰 컨트롤러.
 이 속성을 따로 설정해주지 않더라도 SDK 내부적으로 적절한 뷰 컨트롤러를 탐색하여 사용하도록 처리되어있다.
 따라서 특별한 경우가 아니라면 별도로 뷰 컨트롤러 객체를 할당해주지 않아도 무방하다.
 */
@property (nonatomic, retain) UIViewController *superViewController;

/**
 배너 광고가 새로 수신될 때의 전환 효과.
 게임과 같이 그래픽 퍼포먼스가 중요한 애플리케이션의 경우 기본값인 AdamAdViewTransitionStyleNone을 사용하는 것을 권장한다.
 */
@property (nonatomic, assign) AdamAdViewTransitionStyle transitionStyle;

/**
 현재 광고를 가지고 있는지 여부.
 AdamAdView 객체가 현재 광고를 가지고 있는지 여부를 알 수 있는 속성으로, 기본값은 NO이다.
 단 한번이라도 성공적으로 광고를 수신하여 현재 화면에 보여지고 있다면 YES 값을 가진다.
 */
@property (nonatomic, readonly) BOOL hasAd;

/**
 광고 자동요청을 사용하고 있는지 여부.
 AdamAdView 객체가 현재 광고를 자동으로 요청하고 있는지 여부를 알 수 있는 속성으로, 기본값은 NO이다.
 startAutoRequestAd: 메소드를 호출한 이후에는 YES 값을 가지며, stopAutoRequest 메소드를 호출하면 다시 NO 값을 가지게 된다.
 */
@property (nonatomic, readonly) BOOL usingAutoRequest;


/**
 AdamAdView 클래스의 Singlton 객체인 sharedAdView를 리턴한다.
 AdamAcView 클래스는 Singleton으로 구현되었으므로, 하나의 앱에서는 하나의 AdamAdView 객체만을 사용할 수 있다.
 @return AdamAdView 객체
 */
+ (AdamAdView *)sharedAdView;

/**
 광고를 1회 요청한다.
 기존과 같이 타이머를 이용해 직접 광고를 요청하고자 할 때 사용할 수 있다.
 최소 호출 가능한 시간 간격은 12초이고, 그 이내에 다시 광고 요청을 할 경우 새로운 광고가 수신되지 않는다.
 */
- (void)requestAd;

/**
 주어진 interval에 따라 자동으로 광고를 요청한다.
 interval 인자로는 12.0 이상의 값만 넘길 수 있으며, 그보다 작은 값을 사용하는 경우 최소 허용값인 12.0으로 고정되어 동작한다.
 광고 효과의 극대화를 위해서는 일반적으로 60초를 사용하는 것을 권장한다.
 startAutoRequestAd: 메소드를 호출한 이후에는 stopAutoRequestAd 메소드를 호출해야만 자동요청을 중지할 수 있다.
 또한 광고 자동요청을 사용하고 있는 동안에는 requestAd, startAutoRequestAd: 메소드를 호출하여도 새로운 광고가 수신되지 않는다.
 @param interval 광고를 자동으로 요청할 시간 간격.
 */
- (void)startAutoRequestAd:(NSTimeInterval)interval;

/**
 광고 자동요청을 중지한다.
 */
- (void)stopAutoRequestAd;

@end



@protocol AdamAdViewDelegate <NSObject>
@optional
/**
 광고 수신 성공시 호출되는 메소드.
 @param adView 광고 수신 성공 이벤트가 발생한 AdamAdView 객체.
 */
- (void)didReceiveAd:(AdamAdView *)adView;

/**
 광고 수신 실패시 호출되는 메소드.
 광고 수신에 실패한 원인을 알고자 하는 경우, error.localizedDescription 값을 출력해보면 된다.
 @param adView 광고 수신 실패 이벤트가 발생한 AdamAdView 객체.
 @param error 광고 수신에 실패한 원인이 되는 error 객체.
 */
- (void)didFailToReceiveAd:(AdamAdView *)adView error:(NSError *)error;

/**
 전체화면 광고가 보여질 때 호출되는 메소드.
 배너 광고를 터치하여 광고 페이지가 전체화면에 보여질 때 호출된다.
 @param adView 광고 페이지 열림 이벤트가 발생한 AdamAdView 객체.
 */
- (void)willOpenFullScreenAd:(AdamAdView *)adView;

/**
 전체화면 광고가 보여진 직후 호출되는 메소드.
 배너 광고를 터치하여 광고 페이지가 전체화면에 보여진 직후 호출된다.
 @param adView 광고 페이지 열림 완료 이벤트가 발생한 AdamAdView 객체.
 */
- (void)didOpenFullScreenAd:(AdamAdView *)adView;

/**
 전체화면 광고가 닫힐 때 호출되는 메소드.
 전체화면으로 보여지고 있는 광고 페이지가 닫힐 때 호출된다.
 @param adView 광고 페이지 닫힘 이벤트가 발생한 AdamAdView 객체.
 */
- (void)willCloseFullScreenAd:(AdamAdView *)adView;

/**
 전체화면 광고가 닫힌 직후 호출되는 메소드.
 전체화면으로 보여지고 있는 광고 페이지가 닫히고 난 직후 호출된다.
 @param adView 광고 페이지 닫힘 완료 이벤트가 발생한 AdamAdView 객체.
 */
- (void)didCloseFullScreenAd:(AdamAdView *)adView;

/**
 광고 터치로 인해 애플리케이션이 종료될 때 호출되는 메소드.
 배너 광고를 터치하여 전화 걸기 또는 앱스토어로 이동하는 경우, 애플리케이션이 백그라운드로 들어가게 될 때 호출된다.
 @param adView 백그라운드로 전환 이벤트를 발생시킨 AdamAdView 객체.
 */
- (void)willResignByAd:(AdamAdView *)adView;

@end
