//
//  VictoryScreenViewController.m
//  ytjeopardy
//
//  Created by Poonam Hattangady on 7/31/15.
//  Copyright (c) 2015 bk. All rights reserved.
//

#import "VictoryScreenViewController.h"
#import "JeopardyManager.h"

@interface VictoryScreenViewController ()
@property (weak, nonatomic) IBOutlet UILabel *winnerLabel;
@property (weak, nonatomic) IBOutlet UILabel *winningScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *runnerUpLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastTeamLabel;

@end

@implementation VictoryScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    JeopardyManager *jm = [JeopardyManager sharedInstance];
    
    /*
    TODO: remove this when it all comes together.
    [jm startGameWithTeam1:@"Team1" team2:@"Team2" team3:@"Team3" questionFileName:@"QuestionsData"];
    jm.team1.score = 100;
    jm.team2.score = 200;
    jm.team3.score = 150;
    */
    
    [self updateScreenWithWinners:[jm teamsSortedByScore]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateScreenWithWinners:(NSArray *)sortedTeams
{
    Team *winner = sortedTeams[0];
    Team *runnerUp = sortedTeams[1];
    Team *lastTeam = sortedTeams[2];
    
    self.winnerLabel.text = [NSString stringWithFormat:@"You rule, %@", winner.name];
    self.winningScoreLabel.text = [NSString stringWithFormat:@"You scored %d points.", (int)winner.score];
    
    self.runnerUpLabel.text = [NSString stringWithFormat:@"You beat %@ by %d points.", runnerUp.name, (int)(winner.score - runnerUp.score)];
    self.lastTeamLabel.text = [NSString stringWithFormat:@"You beat %@ by %d points.", lastTeam.name, (int)(winner.score - lastTeam.score)];
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
