//
//  ARViewController.m
//  shopUser
//
//  Created by 李祎喆 on 2019/4/27.
//  Copyright © 2019 李祎喆. All rights reserved.
//

#import "ARViewController.h"

@interface ARViewController ()

@end

@implementation ARViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *newpath = [docPath stringByAppendingPathComponent:@"ARModel.usdz"];
    
    self.filePath = newpath;
    
    [self.backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    [SVProgressHUD showWithStatus:@"准备模型中"];
    [self downARModel];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
    return 1;
}

- (CGRect)previewController:(QLPreviewController *)controller frameForPreviewItem:(id<QLPreviewItem>)item inSourceView:(UIView *__autoreleasing  _Nullable *)view {
    return self.backButton.frame;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    NSURL *file = [NSURL fileURLWithPath:self.filePath];
    
    return file;
}

-(void)downARModel {
    NSURL *url = [NSURL URLWithString:@"http://lc-ahj3its7.cn-n1.lcfile.com/ff2a83b99ab2faebc5db/retrotv.usdz"];
    NSURLSession *mysession = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *tesk = [mysession downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        [[NSFileManager defaultManager] moveItemAtPath:location.path toPath:self.filePath error:nil];
        
        NSLog(@"下载完成");
        
        [SVProgressHUD dismiss];
        QLPreviewController *myView = [[QLPreviewController alloc] init];
        myView.delegate = self;
        myView.dataSource = self;
        [self presentViewController:myView animated:true completion:nil];
    }];
    
    [tesk resume];
}


-(void)goBack {
    BOOL success = [[NSFileManager defaultManager] removeItemAtPath:self.filePath error:nil];
    
    if (success) {
        NSLog(@"删除成功");
    }
    
    [self.navigationController popViewControllerAnimated:true];
}

@end
