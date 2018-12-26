//
//  HomeViewController.m
//  OCBasePro1
//
//  Created by 李东晓 on 2018/12/25.
//  Copyright © 2018年 李东晓. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

-(void)requsetLoadList
{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [[LDXNetworking sharedInstance] GET:@"http://199.10.238.94:8000/test_api/" parameters:params success:^(id  _Nonnull responseObject) {
        NSLog(@"responseObject ==== %@",responseObject);
        self.LabTezt.text = k_NSString(responseObject[@"data"]);
        NSLog(@"msg ===== %@",k_NSString(responseObject[@"msg"]));
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self requsetLoadList];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
