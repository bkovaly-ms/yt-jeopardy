//
//  GameScreenViewController.m
//  ytjeopardy
//
//  Created by Robert Pena on 7/29/15.
//  Copyright (c) 2015 bk. All rights reserved.
//

#import "GameScreenViewController.h"
#import "JeopordyButton.h"

@interface GameScreenViewController ()

@property NSArray *questions;

@end

@implementation GameScreenViewController


- (IBAction)buttonTapped:(JeopordyButton *)sender {
    
   // NSLog(@"%ld and %ld", sender.questionValue, sender.categoryValue); // printing the key paths for the questions
    
    UIViewController *destination = [[UIStoryboard storyboardWithName:@"Question" bundle:nil] instantiateInitialViewController]; //Transition to other VC
    
    [self.navigationController pushViewController:destination animated:YES];
    
    NSArray *questions = @[ @[ @"A", @"B", @"C",@"D" ], // 2D array that holds the questions
                            @[ @"F",@"G", @"H",@"I" ],
                            @[ @"1", @"2", @"3",@"4"],
                            @[ @"6", @"7", @"8",@"9" ],
                            @[ @"x", @"y", @"z",@"zz" ]
                            ];
    
    
   // NSLog(@"Q: %@", [[questions objectAtIndex:sender.questionValue] objectAtIndex:sender.categoryValue] ); // Printing out the contents of array
   // [[strings objectAtIndex:i] objectAtIndex:j];
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
