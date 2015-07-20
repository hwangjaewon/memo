//
//  AddMemoViewController.h
//  example7
//
//  Created by smart on 15. 5. 19..
//  Copyright (c) 2015년 smartmobile leehyo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController;

@interface AddMemoViewController : UIViewController
{
    //화면전환을 위해 생성한다.
    ViewController *viewController;
}
@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveBtn;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *bodyLabel;
@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UITextView *bodyTextField;


- (IBAction)saveMemoBtn:(id)sender;

@end
