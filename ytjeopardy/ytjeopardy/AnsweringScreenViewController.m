//
//  AnsweringScreenViewController.m
//  ytjeopardy
//
//  Created by Poonam Hattangady on 8/2/15.
//  Copyright (c) 2015 bk. All rights reserved.
//

#import "AnsweringScreenViewController.h"
#import "Question.h"
#import "JeopardyManager.h"

#define _RGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface AnsweringScreenViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *team1Label;
@property (weak, nonatomic) IBOutlet UILabel *team2Label;
@property (weak, nonatomic) IBOutlet UILabel *team3Label;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@property NSUInteger timeAlloted;
@property NSTimer *questionTimer;
@property NSUInteger timeRemaining;

@end

@implementation AnsweringScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated
{
#if DEBUG
    self.question.time = 20;
#endif
    
    self.timeAlloted = self.question.time;
    self.questionLabel.text = self.question.text;    
    
    self.team1Label.text = self.jm.team1.name;
    self.team2Label.text = self.jm.team2.name;
    self.team3Label.text = self.jm.team3.name;
    
    [self updateTeamNames];
    [self startTimer];
    [self updateTimerLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)correctTapped:(id)sender {
    // Stop the timer.
    [self.questionTimer invalidate];
    self.questionTimer = nil;
    
    [self handleAnswer:YES];
}

- (void) handleAnswer:(BOOL)answeredCorrectly
{
    BOOL result = [[JeopardyManager sharedInstance] questionAnswered:answeredCorrectly];
    
    if (result)
    {
        // close this popup.
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        // next team gets to answer.
        self.timeAlloted = self.timeAlloted / 2;
        [self startTimer];
        [self updateTeamNames];
    }
}

- (void) startTimer
{
    [self.questionTimer invalidate];
    self.questionTimer = nil;
    
    self.timeRemaining = self.timeAlloted;
    self.questionTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    [self updateTimerLabel];
}

- (void) timerFired:(NSTimer *)timer
{
    self.timeRemaining--;
    
    if (self.timeRemaining == 0)
    {
        [self handleAnswer:NO];
    }
    else
    {
        [self updateTimerLabel];
    }
}

- (void) updateTimerLabel
{
    self.timerLabel.text = [NSString stringWithFormat:@"%lu seconds", self.timeRemaining];
}

- (void) updateTeamNames
{
    [self updateTeamLabel:self.team1Label forTeam:self.jm.team1];
    [self updateTeamLabel:self.team2Label forTeam:self.jm.team2];
    [self updateTeamLabel:self.team3Label forTeam:self.jm.team3];
}

- (void)updateTeamLabel:(UILabel *)teamLabel forTeam:(Team *)team
{
    teamLabel.textColor = team.canAnswer ? [UIColor yellowColor] : [UIColor grayColor];
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
