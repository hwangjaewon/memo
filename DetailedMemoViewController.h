//
//  DetailedMemoViewController.h
//  example7
//
//  Created by smart on 15. 5. 20..
//  Copyright (c) 2015년 smartmobile leehyo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController;
@class EditMemoViewController;

@interface DetailedMemoViewController : UIViewController
{
    //화면전환을 위해 생성한다.
    ViewController *viewController;
    EditMemoViewController *editMemoController;
    NSMutableArray *updating_memo;
}
@property (strong, nonatomic) NSMutableArray *receivedMemo;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editBtn;
@property (strong, nonatomic) IBOutlet UINavigationItem *dateiledMemoNavigation;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateViewLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleViewLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentViewLabel;
@property (strong, nonatomic) NSMutableArray *updating_memo; //업데이트할 정보 값을 넘기는 배열이다.
- (IBAction)gotoEditMemoViewController:(id)sender;

@end
