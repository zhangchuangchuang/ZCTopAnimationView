//
//  ViewController.m
//  ZCTopAnimationView
//
//  Created by 张闯闯 on 2018/7/9.
//  Copyright © 2018年 张闯闯. All rights reserved.
//

#import "ViewController.h"
#import "ZCTopNavView.h"
#import <WebKit/WebKit.h>
@interface ViewController ()<WKNavigationDelegate,WKUIDelegate,UIScrollViewDelegate>
{
     ZCTopNavView *topToolView;//自定义导航栏
   
}
@property (nonatomic,strong) WKWebView *webView;
@end
#define CreateWeakSelf __weak __typeof(self) weakSelf = self
#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height
#define SCREEN_HEIGHT [ UIScreen mainScreen ].bounds.size.height
#define SCREEN_WIDTH  [ UIScreen mainScreen ].bounds.size.width
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]
#define K_SAFEAREA_TOP_HEIGHT (SCREEN_HEIGHT == 812.0 ? 88 : 64)
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    
    [self.webView loadRequest:request];
    
    self.webView.navigationDelegate = self;//该代理可以用来追踪加载过程以及决定是否执行跳转。
    
    self.webView.UIDelegate = self;
    self.webView.scrollView.delegate = self;
    
    [self.view addSubview:self.webView];
    [self setBackAndShareButton];

}

-(void)setBackAndShareButton{
    topToolView = [[ZCTopNavView alloc]init];
    
    topToolView.frame =CGRectMake(0, 0, SCREEN_WIDTH, K_SAFEAREA_TOP_HEIGHT);
   
    topToolView.leftItemClickBlock = ^{
        NSLog(@"你点击了左边按钮");
    };
    topToolView.rightItemClickBlock = ^{
        NSLog(@"你点击了右边按钮");
        
    };
    topToolView.rightRItemClickBlock = ^{
        
        NSLog(@"====");
    };
    [self.view addSubview:topToolView];
}
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat alpha ;
    CGFloat alp;
 
        alpha = (scrollView.contentOffset.y+20)/300;
        alp = (scrollView.contentOffset.y+20)/200;
    
    topToolView.backgroundColor= [UIColor colorWithRed:250 green:250 blue:250 alpha:alpha];
    topToolView.leftItemButton.alpha = 1-alp;
    topToolView.rightItemButton.alpha = 1-alp;
    topToolView.rightRItemButton.alpha = 1-alp;
    if ((scrollView.contentOffset.y)>=180) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"SHOWTOPTOOLVIEW" object:nil];
        CGFloat alphaj ;
        
            alphaj = (scrollView.contentOffset.y-100)/200;
        
        
        topToolView.leftItemButton.alpha = alphaj;
        topToolView.rightItemButton.alpha = alphaj;
        topToolView.rightRItemButton.alpha = alphaj;
        topToolView.topCenterTitleImage.alpha = alphaj;
        
        
    }else {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"HIDETOPTOOLVIEW" object:nil];
    }
}
#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"%@",navigationAction.request.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}
#pragma mark - WKUIDelegate
// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    return [[WKWebView alloc]init];
}
// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    completionHandler(@"http");
}
// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    completionHandler(YES);
}
// 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    NSLog(@"%@",message);
    completionHandler();
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
