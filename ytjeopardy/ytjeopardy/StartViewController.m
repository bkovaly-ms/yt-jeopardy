//
//  StartViewController.m
//  ytjeopardy
//
//  Created by Munya on 7/29/15.
//  Copyright (c) 2015 bk. All rights reserved.
//

#import "StartViewController.h"
#import "JeopardyManager.h"

@interface StartViewController ()
@property (weak, nonatomic) IBOutlet UILabel *team1;
@property (weak, nonatomic) IBOutlet UILabel *team2;
@property (weak, nonatomic) IBOutlet UILabel *team3;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *addTeam;
@property (weak, nonatomic) IBOutlet UITextField *teamName;
@property int nameCounter;

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameCounter = 0;
    
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    
    [self.addTeam setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [self.startButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    self.startButton.enabled = NO;
    self.team1.textColor = [UIColor grayColor];
    self.team2.textColor = [UIColor grayColor];
    self.team3.textColor = [UIColor grayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveTeamName:(id)sender {
    NSString *teamName = self.teamName.text;
    teamName = [teamName stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([teamName  isEqual:@""]) {
        self.teamName.text=@"";
        UIAlertView *dont = [[UIAlertView alloc] initWithTitle:@"Woah..." message:@"who do you know here?" delegate:self cancelButtonTitle:@"leave" otherButtonTitles:nil];
        [dont show];
    } else {
        if (self.nameCounter == 0) {
            self.team1.text = teamName;
            self.team1.textColor = [UIColor whiteColor];
        }
        else if (self.nameCounter == 1) {
            self.team2.text = teamName;
            self.team2.textColor = [UIColor whiteColor];
        }
        else if (self.nameCounter == 2) {
            self.team3.text = teamName;
            [self disableAddingNewTeams];
            self.team3.textColor = [UIColor whiteColor];
        }
        
        self.teamName.text=@"";
        (self.nameCounter)++;
    }
}

- (void)disableAddingNewTeams
{
    self.addTeam.enabled = NO;
    self.teamName.enabled = NO;
    self.teamName.backgroundColor = [UIColor lightGrayColor];
    self.startButton.enabled = YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)startTapped:(id)sender {
    JeopardyManager *jm = [JeopardyManager sharedInstance];
    [jm startGameWithTeam1:@"team1" team2:@"team2" team3:@"team3" questionFileName:@"QuestionData"];
    
    // Capture team1's name
    NSString *name1 = self.team1.text;
    
    // Capture team2's name
    NSString *name2 = self.team2.text;
    
    // Capture team3's name
    NSString *name3 = self.team3.text;
    
    // Start the game
    [jm startGameWithTeam1:name1 team2:name2 team3:name3 questionFileName: @"QuestionData"];
    UIViewController *destination = [[UIStoryboard storyboardWithName:@"GameScreen" bundle:nil] instantiateInitialViewController];
    [self.navigationController pushViewController:destination animated:YES];
}

@end
