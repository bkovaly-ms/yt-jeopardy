//
//  StartViewController.m
//  ytjeopardy
//
//  Created by Munya on 7/29/15.
//  Copyright (c) 2015 bk. All rights reserved.
//

#import "StartViewController.h"

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveTeamName:(id)sender {
    // This replaces the first team
    // self.team1.text = @"";
    // self.team1.text = self.teamName.text;
    static int i ;
    if (i == 0) {

        self.team1.text = @"";
        self.team1.text = self.teamName.text;
        i++;
    }
    else if (i == 1) {
        self.team2.text = @"";
        self.team2.text = self.teamName.text;
        i++;
    }
    else if (i == 2) {
        self.team3.text = @"";
        self.team3.text = self.teamName.text;
        i++;
    }
    // else {
        // disable add button
        
   // }

    
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
