//
//  ViewController.m
//  LXAlertManagerDemo
//
//  Created by Liu on 16/10/18.
//  Copyright © 2016年 Liu. All rights reserved.
//

#import "ViewController.h"
#import "LXAlertManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
    button.backgroundColor = [UIColor blueColor];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonOnClick {
    [LXAlertManager showAlertViewWithTitle:@"Hello" message:@"Nice to meet you!" cancelButtonTitle:@"cancel" otherButtonTitles:@[@"OK"] dismissBlock:^(NSInteger index, NSInteger cancelIndex) {
        
    } presentVC:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
