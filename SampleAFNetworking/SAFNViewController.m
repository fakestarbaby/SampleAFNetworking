//
//  SAFNViewController.m
//  SampleAFNetworking
//
//  Created by fakestarbaby on 2012/09/18.
//  Copyright (c) 2012年 Fun & Cool Ventures Pte. Ltd. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>

#import "SAFNViewController.h"

@interface SAFNViewController ()

@end

@implementation SAFNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [SVProgressHUD show];

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip"]];

    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [directory stringByAppendingPathComponent:@"download.lzh"];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:filePath append:NO];

    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        NSString *status = [NSString stringWithFormat:@"Now downloading\n%0.2f MB", totalBytesRead / 1024.0f / 1000.0f];
        [SVProgressHUD setStatus:status];
    }];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];

    [operation start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
