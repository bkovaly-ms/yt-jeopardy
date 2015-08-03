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

@property (weak, nonatomic) IBOutlet UILabel *teamOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamThreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamOneScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamTwoScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamThreeScoreLabel;


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
-(void) viewWillAppear:(BOOL)animated
{
    JeopardyManager *jm = [JeopardyManager sharedInstance];
    self.teamOneLabel.text = jm.team1.name;
    self.teamTwoLabel.text = jm.team2.name;
    self.teamThreeLabel.text = jm.team3.name;
    
    self.teamOneScoreLabel.text = [NSString stringWithFormat:@"%ld",jm.team1.score];
    self.teamTwoScoreLabel.text = [NSString stringWithFormat:@"%ld",jm.team2.score];
    self.teamThreeScoreLabel.text = [NSString stringWithFormat:@"%ld",jm.team3.score];
    
    if ([jm checkGameOver]) {
        
        UIViewController *vs =[[UIStoryboard storyboardWithName:@"VictoryScreen" bundle:nil] instantiateInitialViewController];
        [self.navigationController pushViewController:vs animated:YES];

    }
        
        
         

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
