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
    // Do any additional setup after loading the view.
    
    self.nameCounter =0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveTeamName:(id)sender {
    // This replaces the first team
    // self.team1.text = @"";
    // self.team1.text = self.teamName.text;
    
    if (self.nameCounter == 0) {
        
        //self.team1.text = @"";
        self.team1.text = self.teamName.text;
        self.teamName.text=@"";
        
        (self.nameCounter)++;
    }
    else if (self.nameCounter == 1) {
        //self.team2.text = @"";
        self.team2.text = self.teamName.text;
        self.nameCounter++;
        self.teamName.text=@"";
        
    }
    else if (self.nameCounter == 2) {
        // self.team3.text = @"";
        self.team3.text = self.teamName.text;
        self.nameCounter++;
        self.teamName.text=@"";}
    
    else{
        UIAlertView *naw = [[UIAlertView alloc] initWithTitle:@"Woah..." message:@"who do you know here?" delegate:self cancelButtonTitle:@"leave" otherButtonTitles:nil];
        [naw show];
    
    }
        }
    // else {
        // disable add button
        
   // }




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)startTapped:(id)sender {
    if (self.nameCounter >= 3) {
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
        
        
    
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"you can't do that" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
    }
    
    // Disable the transition if counter is less then 3, or conversely only enable if it's above 3
}

@end
