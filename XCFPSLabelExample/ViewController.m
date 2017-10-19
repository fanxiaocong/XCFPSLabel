//
//  ViewController.m
//  XCFPSLabelExample
//
//  Created by 樊小聪 on 2017/10/19.
//  Copyright © 2017年 樊小聪. All rights reserved.
//

#import "ViewController.h"

#import <XCHover/UIView+XCHover.h>

#import "XCFPSLabel.h"


@interface ViewController ()

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    XCFPSLabel *l = [[XCFPSLabel alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    
    [self.view addSubview:l];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [l hoverInView:self.view];
    });
}


@end
