//
//  ViewController.h
//  example7
//
//  Created by smart on 15. 5. 19..
//  Copyright (c) 2015년 smartmobile leehyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBInterface.h"
@class AddMemoViewController; //class라고 선언된 부분은 참조한다는 의미이다.
@class EditMemoViewController;
//화면전환을 위해 넣어주는 코드이다.
@class DBInterface;

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate >
{
    //화면전환을 위해 생성한다.
    AddMemoViewController *addMemoViewController;
    EditMemoViewController *editMemoViewController;
}


@property (strong, nonatomic) IBOutlet UIBarButtonItem *gotoAddMemoViewController;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *EditBtn;
@property (strong, nonatomic) IBOutlet UITableView *MemoTableView;
@property (strong, nonatomic) NSMutableArray *cumulative_titles;
@property (strong, nonatomic) NSMutableArray *detailed_memo; //상세 정보 값을 저장한다.
@property (strong, nonatomic) IBOutlet UIImageView *imageLabel;

@property (strong, nonatomic) IBOutlet UIButton *sortByTitle;
@property (strong, nonatomic) IBOutlet UIButton *sortByDate;

@property (strong, nonatomic) IBOutlet UIButton *pickerOkBtn;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UIView *pickerPanel;
@property (strong, nonatomic) NSArray *pickerData;
@property (strong, nonatomic) IBOutlet UIButton *pickerOnBtn;

- (IBAction)pickerOnPressed:(id)sender;

- (IBAction)gotoEditPressed:(id)sender;
- (IBAction)SortByTitlePressed:(id)sender;
- (IBAction)SortByDatePressed:(id)sender;
- (IBAction)gotoAddMemoViewController:(id)sender;
- (IBAction)pickerOkBtnPressed:(id)sender;

@end
