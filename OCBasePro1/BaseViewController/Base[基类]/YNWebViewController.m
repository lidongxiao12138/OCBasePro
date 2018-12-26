//
//  YNWebViewController.m
//  yuenow
//
//  Created by Kraig.wu on 2018/5/11.
//  Copyright © 2018年 wanhe. All rights reserved.
//

#import "YNWebViewController.h"

@interface YNWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) JSContext *jsContext;

@end

@implementation YNWebViewController{
    UIWebView *_webView;
    UIBarButtonItem* _closeItem;
    NSMutableArray* _items;
}


-(id)initWithTitle:(NSString*)title webUrl:(NSString*)webUrl{
    
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
        self.title = title;
        self.webUrl = webUrl;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
    [self initSubViews];
    [self initData];
}

-(void)initNavigationBar{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_arrow"]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(backClick)];
    
    _closeItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_close"]
                                                  style:UIBarButtonItemStylePlain
                                                 target:self
                                                 action:@selector(closeClick)];
    
    _items = [NSMutableArray arrayWithObjects:backItem,nil];
    [self.navigationItem setLeftBarButtonItems:_items];
    
    //ios7之后设置导航栏背景
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //ios7之前设置导航栏背景
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:17],NSFontAttributeName, nil]];
}

-(void)initSubViews{
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, naviHeight, winWidth, winHeight-naviHeight)];
    [self.view addSubview:_webView];
    _webView.backgroundColor = [UIColor whiteColor];
    
    if (@available(iOS 11.0, *)) {
        _webView.scrollView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = false;
    }
}

-(void)initData{
    /** 设置cookie **/
    NSMutableDictionary *cookieDic = [NSMutableDictionary dictionary];
    NSMutableString *cookieValue = [NSMutableString stringWithFormat:@""];
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        [cookieDic setObject:cookie.value forKey:cookie.name];
    }
    // cookie重复，先放到字典进行去重，再进行拼接
    for (NSString *key in cookieDic) {
        NSString *appendString = [NSString stringWithFormat:@"%@=%@;", key, [cookieDic valueForKey:key]];
        [cookieValue appendString:appendString];
    }
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_webUrl]];
    [request addValue:cookieValue forHTTPHeaderField:@"Cookie"];
    [_webView loadRequest:request];
}

#pragma mark - 返回
-(void)backClick{
    //返回
    if([_webView canGoBack]){
        [_webView goBack];
        if(![_items containsObject:_closeItem]){
            [_items addObject:_closeItem];
            [self.navigationItem setLeftBarButtonItems:_items];
        }
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)closeClick{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark UIWebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

/**
 * 该步骤必须设置, 否则切换到其他网页cookie失效
 * wkwebview 加载完成后重新设置cookie
 */
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    self.jsContext = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //self.jsContext[@"TPshop"] = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"jsContext异常信息：%@", exceptionValue);
    };
}

@end
