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


static NSString *kCellIdentifier = @"PathListTableViewCell";

@interface PathListViewController () <UITableViewDelegate>

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

#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"notify user that the feature not implemented ");
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
    
    NSLog(@"Filter");
    
}

#pragma mark - Memory Warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
