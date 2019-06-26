//
//  ViewController.m
//  LDNetworkManager
//
//  Created by lidi on 2019/5/30.
//  Copyright © 2019 Li. All rights reserved.
//

#import "ViewController.h"
#import "Network/QDNetWorkClient.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [QDNetWorkClient getRankListWithPageNum:0 pageSize:10 success:^(QDResponseObject *responseObject) {
        NSLog(@"%@",responseObject.result);
    } failed:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
}


@end
