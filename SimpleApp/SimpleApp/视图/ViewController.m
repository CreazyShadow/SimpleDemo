//
//  ViewController.m
//  SimpleApp
//
//  Created by wuyp on 16/4/27.
//  Copyright © 2016年 wuyp. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

#import <objc/runtime.h>
#import "SimpleApp-Swift.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic, copy) NSMutableArray *marr;

@property (nonatomic, strong) UIWebView *webview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addWeb];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

#pragma mark - tableview delegate & datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    return cell;
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"---finished");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"---failed");
}

#pragma mark - events

- (IBAction)btnClick:(id)sender {
    self.containerHeight.constant = 400;
    self.webview.height = 400;
    self.container.height = 1400;
    CGFloat height = self.tableview.contentSize.height;
    self.tableview.contentSize = CGSizeMake(0, height + 400);
}

#pragma mark - getter & setter


#pragma mark - private

- (void)addWeb {
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    NSString *url = @"http://10.199.101.221:8086/h5/discuss/analogCombination/analogCombination.html?sourceId=666800000587&deviceId=DFATcFuHdM46W7tQs6nJY1&v=2.8.0&snsAccount=SNS20170316045336411461002871&deviceType=3&time=2017091915&token=&clientId=&hasActive=1";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    web.delegate = self;
    [web loadRequest:request];
    [self.webviewContainer addSubview:web];
    self.webview = web;
}

@end
