//
//  PathListViewController.m
//  GEtest
//
//  Created by Mohamed Alsadek on 6/18/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

#import "PathListViewController.h"
#import "PathListTableViewCell.h"
#import "ArrayDataSource.h"
#import "PathListViewModel.h"
#import <JGActionSheet/JGActionSheet.h>


static NSString *kCellIdentifier = @"PathListTableViewCell";

// ActionSheet
static NSString *kActionSheetTitle = @"Filter";
static NSString *kActionSheetMessage = @"arrange the list according to the follwing creterias";
static NSString *kActionSheetOption1 = @"Departure Time";
static NSString *kActionSheetOption2 = @"Arrival Time";
static NSString *kActionSheetOption3 = @"Path Duration";
static NSString *kButtonCancel = @"Cancel";


@interface PathListViewController ()

@property (nonatomic, strong) ArrayDataSource *pathListDataSource;
@property (nonatomic, strong) PathListViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableViewPathes;
@property (weak, nonatomic) IBOutlet UIView *footerView;

@end

@implementation PathListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    
    // init view model
    _viewModel = [[PathListViewModel alloc] initWithTravelMode:self.travelMode delegate:self];
    [_viewModel fetchDataForTravelMode:self.travelMode sortingType:PathSortingDepartureTime];
    
    // configure tableview delegate and datasource
    self.tableViewPathes.delegate = self;
    [self initTableViewDataSource];
    self.tableViewPathes.tableFooterView = [UIView new];
    [self.tableViewPathes setContentInset:UIEdgeInsetsMake(0, 0, self.footerView.frame.size.height, 0)];
    
    // init footerview
    UITapGestureRecognizer *tagGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(showFilter)];
    [self.footerView addGestureRecognizer:tagGesture];
}

#pragma mark - Table view data source
- (void) initTableViewDataSource {
    
    TableViewCellConfigureBlock configureCell = ^(PathListTableViewCell *cell, Path *path) {
        [cell initCellWithPath:path] ;
    };
    
    self.pathListDataSource = [[ArrayDataSource alloc] initWithItems:self.viewModel.allPathes
                                                         cellIdentifier:kCellIdentifier
                                                     configureCellBlock:configureCell];
    
    self.tableViewPathes.dataSource = self.pathListDataSource ;
}

#pragma mark - Update UI
- (void) updateUI {
//    [self hideLoadingIndicator];
    [self reloadTableViewOnMainThread];
}

-(void) reloadTableViewOnMainThread {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.pathListDataSource.items = self.viewModel.allPathes ;
        [self.tableViewPathes reloadData] ;
    });
}

#pragma mark - Filter
- (void)showFilter {
    
    JGActionSheetSection *section1 = [JGActionSheetSection sectionWithTitle:kActionSheetTitle message:kActionSheetMessage buttonTitles:@[kActionSheetOption1, kActionSheetOption2, kActionSheetOption3] buttonStyle:JGActionSheetButtonStyleDefault];
    JGActionSheetSection *cancelSection = [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[kButtonCancel] buttonStyle:JGActionSheetButtonStyleCancel];
    
    NSArray *sections = @[section1, cancelSection];
    
    JGActionSheet *sheet = [JGActionSheet actionSheetWithSections:sections];
    
    [sheet setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath) {
        
        [self.viewModel fetchDataForTravelMode:self.travelMode sortingType:indexPath.row];
        
        [sheet dismissAnimated:YES];
    }];
    
    [sheet showInView:self.view animated:YES];
}

#pragma mark - Memory Warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
