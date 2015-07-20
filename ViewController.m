//
//  ViewController.m
//  example7
//
//  Created by smart on 15. 5. 19..
//  Copyright (c) 2015년 smartmobile leehyo. All rights reserved.
//

#import "ViewController.h"
#import "AddMemoViewController.h" //닙파일 연결 1: 서브로 보여주고 싶은 뷰의 컨트롤러 헤더파일을 삽입시킨다.
#import "DetailedMemoViewController.h"
#import "DBInterface.h"
#import "EditMemoViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad
{
    self.navigationItem.title = @"메모장";
    [self.navigationItem setRightBarButtonItem:self.gotoAddMemoViewController];
    [self.navigationItem setLeftBarButtonItem:self.EditBtn];
    
    self.EditBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(gotoEditPressed:)];
    
    // 닙 파일 연결 3 : 맨 처음 뷰가 실행될 때 컴파일러에게 add~ 는 Add~의 컨트롤러이다 라고 인식을 시켜준다.
    addMemoViewController = [[AddMemoViewController alloc] init];
    editMemoViewController = [[EditMemoViewController alloc]init];
    
    //디테일 메모를 보기 위한 객체를 하나 생성한다.
    self.detailed_memo = [[NSMutableArray alloc]initWithCapacity:0];

    //피커에 대해 환경설정한다.
    self.pickerData = @[@"날짜순",@"제목순"];  //총 놓이 150짜리 뷰, 피커는 100, 버튼 50  - 피커는 162, 180 , 216 만 valid하다고 함.
    self.pickerPanel.frame = CGRectMake(0, 390, 320, 170); // x , y , width , height
    self.pickerView.frame = CGRectMake(0, 358, 320, 162);
    
    CGAffineTransform t0 = CGAffineTransformMakeTranslation (0,self.pickerView.bounds.size.height/2);
    CGAffineTransform s0 = CGAffineTransformMakeScale (0.6, 0.6);
    CGAffineTransform t1 = CGAffineTransformMakeTranslation (0,-self.pickerView.bounds.size.height/2);
    self.pickerView.transform = CGAffineTransformConcat(t0, CGAffineTransformConcat(s0, t1));
    
    
    //title 과 id 를 가진 객체를 받아와 각 Array에 넣어준다. -> 딕셔너리를 가진 Array로 만들어줘야한다.
    self.cumulative_titles= [[NSMutableArray alloc]initWithCapacity:0];
    
    [super viewDidLoad];
}

//화면을 호출할 때마다 실행한다. 업데이트된 데이터를 보고 싶으면 viewDidLoad가 아닌 이 함수에 넣어야 한다.
-(void)viewWillAppear:(BOOL)animated
{
    self.MemoTableView.dataSource = self;
    self.MemoTableView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    
    //DB를 오픈한다.
    [[DBInterface sharedDB] openDB];
    //[[DBInterface sharedDB] deleteRecord:@""];
    //타이틀 행을 가져온다. 리턴값은 NSMutableArray
    self.cumulative_titles = [[DBInterface sharedDB] getTitleRowsFromTbleNamed];
    
    //incompatible pointer types initializing 'NSMutableArray *' with an expression of type 'NSArray *'
    //error 를 없애기 위해 (NSMytable *) 형변환 한다.
    
   // NSMutableArray *reversedArray = (NSMutableArray *) [[self.cumulative_titles reverseObjectEnumerator] allObjects];
    //reversedArray = [NSMutableArray arrayWithArray:reversedArray];
   // self.cumulative_titles = reversedArray;
    
    NSLog(@"array (will paper) is %@", self.cumulative_titles);
    
    [self.MemoTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//테이블의 행 수를 리턴한다.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cumulative_titles count];
}


//테이블의 데이터를 뿌려서 화면에 보여준다. 셀 카운트 만큼 실행한다.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Right Detail";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    //Configure(display) the cell
    cell.textLabel.text = [[self.cumulative_titles objectAtIndex:[indexPath row]] objectForKey:@"title"];
    cell.detailTextLabel.text =[[self.cumulative_titles objectAtIndex:[indexPath row]] objectForKey:@"date"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:([UIFont systemFontSize]-2)];
    return cell;
}

//테이블 cell을 하나 누르면 세부 메모 보기로 이동한다.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * keyword = [[self.cumulative_titles objectAtIndex:indexPath.row] objectForKey:@"id"];
    [[DBInterface sharedDB] openDB];
    
    self.detailed_memo = [[DBInterface sharedDB] getDetailedMemoFromKeyword:keyword];
    
    editMemoViewController.receivedMemo = self.detailed_memo;

    //화면전환을 한다.
    [self.navigationController pushViewController:editMemoViewController    animated:YES];
}


//Add 버튼 클릭 이벤트.
- (IBAction)gotoAddMemoViewController:(id)sender {
    // 닙파일 연결 2 : 서브 뷰로 메모를 추가하는 창을 보여주는 함수를 호출한다.
    [self.navigationController pushViewController:addMemoViewController animated:YES];
}

- (IBAction)pickerOkBtnPressed:(id)sender {
    [self.pickerPanel removeFromSuperview];
}

//swipe하여 삭제하기 이벤트.
-(void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * keyword = [[self.cumulative_titles objectAtIndex:[indexPath row]] objectForKey:@"id"];
    [[DBInterface sharedDB] openDB];
    
    [[DBInterface sharedDB] deleteRecord:keyword];
    
    NSUInteger row = [indexPath row];
    NSUInteger count = [self.cumulative_titles count];
    
    
    if (row < count) {
        [self.cumulative_titles removeObjectAtIndex:row];
    }
    
    [self.MemoTableView reloadData];
    
}

//제목 순 정렬 (가나다 순) 버튼 클릭 이벤트
- (IBAction)SortByTitlePressed:(id)sender
{
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    NSMutableArray *sortDescriptors = [NSMutableArray arrayWithObjects:sortDescriptor, nil];
    NSMutableArray *sortedArray = [[NSMutableArray alloc] initWithArray:[self.cumulative_titles sortedArrayUsingDescriptors:sortDescriptors]];
    self.cumulative_titles = (NSMutableArray *) sortedArray;
    
    [self.MemoTableView reloadData];
}

//날짜 순 정렬 (최근 날짜가 맨 위로 간다) 버튼 클릭 이벤트
- (IBAction)SortByDatePressed:(id)sender
{
    //sortDescriptor는 Dictionary의 키워드를 기준으로 sorting해주는 객체이다.
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    NSMutableArray *sortDescriptors = [NSMutableArray arrayWithObjects:sortDescriptor, nil];
    //NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSMutableArray *sortedArray = [[NSMutableArray alloc] initWithArray:[self.cumulative_titles sortedArrayUsingDescriptors:sortDescriptors]];
    self.cumulative_titles = sortedArray;
    [self.MemoTableView reloadData];
}



// 피커 ; Catpure the picker view selection, 피커값에 따라 정렬 방법을 바꿔준다.
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch(row)
    {
        case 0:
        {
            //날짜 순 정렬 (최근 날짜가 맨 위로 간다)
            //sortDescriptor는 Dictionary의 키워드를 기준으로 sorting해주는 객체이다.
            NSSortDescriptor *sortDescriptor;
            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
            NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
            NSMutableArray *sortedArray = [[NSMutableArray alloc] initWithArray:[self.cumulative_titles sortedArrayUsingDescriptors:sortDescriptors]];
            self.cumulative_titles = sortedArray;
            [self.MemoTableView reloadData];
            break;
        }
        case 1:
        {
            //제목 순 정렬 (가나다 순)
            NSSortDescriptor *sortDescriptor;
            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
            NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
            NSMutableArray *sortedArray = [[NSMutableArray alloc] initWithArray:[self.cumulative_titles sortedArrayUsingDescriptors:sortDescriptors]];
            self.cumulative_titles = sortedArray;
            [self.MemoTableView reloadData];
            break;
        }
    }
    
}


//edit mode 버튼 클릭 이벤트
- (IBAction)gotoEditPressed:(id)sender {
    [self.MemoTableView setEditing: !self.MemoTableView.editing];
}


//셀을 이동시킬 때의 이벤트, 함수가 구현되면 자연히 셀이 이동을 뜻하는 작대기 세 줄 이미지가 생성된다.
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
    //셀은 dictionary로 되어있으므로 한 개를 받아온다.
    //dictionaryWithDictionary로 하는 이유는 objectAtIndex는 주소만 받아오기 때문에 다음 코드에서 remove할 경우 지워져버리기 때문이다. 리스트에서 빼도 데이터가 지워지지 않게 하기 위해 사용한다.
    
    NSDictionary *source = [NSDictionary dictionaryWithDictionary:[self.cumulative_titles objectAtIndex:sourceIndexPath.row]];
    
    NSLog(@"start %ld , end %ld ",(long)sourceIndexPath.row,(long)destinationIndexPath.row);
    
    
    [self.cumulative_titles removeObject:[self.cumulative_titles objectAtIndex:sourceIndexPath.row]];
    [self.cumulative_titles insertObject:source atIndex:destinationIndexPath.row];
    
    NSLog(@"빼고 넣고 한 직후 self.cumulative_titles (in moverow) = %@",self.cumulative_titles);
    
    NSString *sourcePath = [self.cumulative_titles[sourceIndexPath.row] objectForKey:@"position"];
    NSString *destinationPath = [self.cumulative_titles[destinationIndexPath.row] objectForKey:@"position"];
    
    NSLog(@"source %@, destination %@", sourcePath, destinationPath);
    //수정사항을 position으로 전달하여 DB에 저장한다.
    [[DBInterface sharedDB] openDB];
    [[DBInterface sharedDB] updateChangePositionRecord:sourcePath : destinationPath];
    
    //타이틀 행을 가져온다. 리턴값은 NSMutableArray
    self.cumulative_titles = [[DBInterface sharedDB] getTitleRowsFromTbleNamed];
}

//피커 버튼 클릭 이벤트
- (IBAction)pickerOnPressed:(id)sender {
    [self.view addSubview:self.pickerPanel];
}

// 피커의 columns를 리턴한다.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// 피커의 각 component의 rows의 #을 리턴한다.
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerData.count;
}

// 피커의 데이터를 넣는다.
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickerData[row];
}
@end
