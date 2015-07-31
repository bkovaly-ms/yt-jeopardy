//
//  GameScreenViewController.m
//  ytjeopardy
//
//  Created by Robert Pena on 7/29/15.
//  Copyright (c) 2015 bk. All rights reserved.
//

#import "GameScreenViewController.h"
#import "JeopordyButton.h"
#import "QuestionRetriever.h"
#import "QuestionViewController.h"
#import "JeopardyManager.h"
@interface GameScreenViewController ()

@property NSArray *questions;

@end

@implementation GameScreenViewController


- (IBAction)buttonTapped:(JeopordyButton *)sender {
    

    JeopardyManager *jm = [JeopardyManager sharedInstance];
    
    Question *question = [jm startQuestionForCategory:sender.categoryString index:sender.questionValue];
    
    NSLog(@"question: %@ for %ld", question.category, question.pointValue );
    
    
    
    QuestionViewController *destination = [[UIStoryboard storyboardWithName:@"Question" bundle:nil] instantiateInitialViewController]; //Transition to other VC
    
    destination.question = question;

    NSLog(@"desc: %@", destination);
    
    [self.navigationController pushViewController:destination animated:YES];
    

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
