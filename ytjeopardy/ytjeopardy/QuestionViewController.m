//
//  QuetionViewController.m
//  ytjeopardy
//
//  Created by Yarelly Janet Gomez on 7/29/15.
//  Copyright (c) 2015 bk. All rights reserved.
//

#import "QuestionViewController.h"
#import "JeopardyManager.h"
#import "Team.h"
#import "GameScreenViewController.h"

@interface QuestionViewController ()
@property (weak, nonatomic) IBOutlet UIButton *rightAnswerButton;
@property (weak, nonatomic) IBOutlet UIButton *wrongAnswerButton;
@property (weak, nonatomic) IBOutlet UILabel *timer;
@property (weak, nonatomic) IBOutlet UITextView *questionTextView;
@property (weak, nonatomic) IBOutlet UILabel *category;
@property (weak, nonatomic) IBOutlet UILabel *pointValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamName;
@property NSTimer *questionTimer;
@property NSUInteger allowedTime;
@property NSUInteger secondsRemaining;

@end

@implementation QuestionViewController
- (IBAction)rightAnswerButtonTapped:(id)sender  {
    [self.questionTimer invalidate];
    self.timer = nil;
    [self handleAnswer:YES];
}

- (IBAction)wrongAsnwerTapped:(id)sender {
    [self.questionTimer invalidate];
    self.timer = nil;
    [self handleAnswer:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //adds border to button to make it easier for the user to identify it as a button as opposed to a label
    self.rightAnswerButton.layer.cornerRadius = 10;
    
   
    
    //string displays category for jeopardy
   self.category.text = self.question.category;
    
    //this string displays how many points to go hand in hand with the category string on the top of the screen
    self.pointValueLabel.text = [NSString stringWithFormat:@"%ld Points", self.question.pointValue];
    
    //this string displays the label that identifies what team is currently nswering the question
    //self.teamName.text = [NSString stringWithFormat:@"Team %@",self.teamName];


    self.allowedTime = self.question.time;
    
    
    [self startQuestion];
}

-(void)startQuestion{
    if ([[[JeopardyManager sharedInstance] team1] canAnswer])
    {
        self.teamName.text = [NSString stringWithFormat:@"Team %@",[[[JeopardyManager sharedInstance]team1] name]];
    }
    else if ([[[JeopardyManager sharedInstance] team2] canAnswer])
    {
        self.teamName.text = [NSString stringWithFormat:@"Team %@",[[[JeopardyManager sharedInstance]team2] name]];
    
    }
    else if ([[[JeopardyManager sharedInstance] team3] canAnswer])
    {
        self.teamName.text = [NSString stringWithFormat:@"Team %@",[[[JeopardyManager sharedInstance]team3] name]];

    }
    
    self.secondsRemaining = self.allowedTime;
    self.timer.text = [NSString stringWithFormat:@"Time left: %ld", self.secondsRemaining];
    
    self.questionTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimeRemaining:) userInfo:nil repeats:YES];
    
}

- (void)updateTimeRemaining:(NSTimer*)timer
{
    self.secondsRemaining = self.secondsRemaining - 1;
    self.timer.text = [NSString stringWithFormat:@"%lu seconds", self.secondsRemaining];
    
    if (self.secondsRemaining == 0)
        
    {
        [self.questionTimer invalidate];
        self.questionTimer = nil;
       
        UIAlertController *alert = [UIAlertController
                                     alertControllerWithTitle:@"Out of Time!"
                                     message:@"Did the team answer correctly?"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *rightAnswer = [UIAlertAction actionWithTitle:@"Right" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                      {
                                          [self handleAnswer:YES];
                                          
                                      }];
        UIAlertAction *wrongAnswer = [UIAlertAction actionWithTitle:@"Wrong" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                      {
                                        self.allowedTime = self.allowedTime / 2;
                                        [self handleAnswer:NO];
                                          
                                      }];
        [alert addAction:rightAnswer];
        [alert addAction:wrongAnswer];
        
        [self presentViewController: alert animated:YES completion:nil];
    }
}




- (void) handleAnswer:(BOOL)answeredCorrectly
    {
        // Get the result from JeopardyManager questionAnswered.
        if ([[JeopardyManager sharedInstance]questionAnswered:answeredCorrectly] == YES)
        {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self startQuestion];
        }

    }












@end
