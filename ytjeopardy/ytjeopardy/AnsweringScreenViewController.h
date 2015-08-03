//
//  AnsweringScreenViewController.h
//  ytjeopardy
//
//  Created by Poonam Hattangady on 8/2/15.
//  Copyright (c) 2015 bk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"
#import "JeopardyManager.h"

@interface AnsweringScreenViewController : UIViewController

@property JeopardyManager *jm;
@property Question *question;

@end
