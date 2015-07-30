//
//  ViewController.m
//  ytjeopardy
//
//  Created by Brandon K on 7/27/15.
//  Copyright (c) 2015 bk. All rights reserved.
//

#import "ViewController.h"
#import "JeopordyButton.h"

@interface ViewController ()


@end

@implementation ViewController
- (IBAction)buttonTapped:(JeopordyButton *)sender {
    NSLog(@"%ld ", sender.questionValue);
    UIViewController *destination = [[UIStoryboard storyboardWithName:@"Question" bundle:nil] instantiateInitialViewController];
    
    
    
    [self presentViewController:destination animated:YES completion:nil];

    
    
}

/////
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
