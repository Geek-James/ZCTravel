//
//  ZCTravailDetailViewController.m
//  xiaoDengTravel
//
//  Created by James on 16/12/18.
//  Copyright © 2016年 ZhangCong. All rights reserved.
//

#import "ZCTravailDetailViewController.h"
#import "AFNetworking.h"

@interface ZCTravailDetailViewController () {
    
    UIWebView *_webView;
}

@end

@implementation ZCTravailDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createWeb];
}

-(void)createData{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *URL = [NSString stringWithFormat:DISCOUNTDETAIL1,self.ID,DISCOUNTDETAIL2];
    [manager GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *dic = [rootDic objectForKey:@"data"];
        NSString *url = [dic objectForKey:@"app_url"];
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
        [_webView loadRequest:request];
                                                                 
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (void)createWeb {
    _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    _webView.scalesPageToFit = YES;
    if (self.ID == nil) {
        [_webView loadRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.url]]];
    } else {
        [self createData];
    }
    [self.view addSubview:_webView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 10, 50, 50);
    [button setImage:[UIImage imageNamed:@"login_close_icon@3x"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnLeftClick) forControlEvents:UIControlEventTouchUpInside];
    [_webView addSubview:button];
}

- (void)btnLeftClick {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
