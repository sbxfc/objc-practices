//
//  CarMarketViewController.m
//  CarRental
//
//  Created by sbxfc on 16/7/29.
//  Copyright © 2016年 me.rungame.sbxfc. All rights reserved.
//

#import "CarMarketViewController.h"
#import "CarMarket.h"
#import "CarMarketTableViewCell.h"
#import "UITableView+ExtHeightCache.h"
#import "SVPullToRefresh.h"
#import "MarketMenuBar.h"

#define MARKET_CELL_IDENTIFIER @"MARKET_CELL_IDENTIFIER"
#define MARKET_MENU_BAR_TYPE_AREA 0

@interface CarMarketViewController()<MarketMenuBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *marketDataListJson;
@property (nonatomic, strong) NSMutableArray *marketDataList;
@end

@implementation CarMarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.marketDataList = @[].mutableCopy;
    [self initWithJsonDataThen:^{
        [self.tableView reloadData];
    }];
    
    //[self setupTableViewHeaderView];
    
    // setup infinite scrolling
    __weak CarMarketViewController *weakSelt = self;
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelt insertRowAtBottom];
    }];
}

-(void)setupTableViewHeaderView
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"全北京",@0,@"东城",@1,@"西城",@2,@"南城",@3,@"北城",@4,@"海淀区",@5,@"昌平区",@6,@"门头沟",@7,@"房山",@8,@"大兴",@9,@"顺义",@10,nil];
    
    CGFloat width = self.tableView.frame.size.width - 40;//左右边距20
    MarketMenuBar* menu = [[MarketMenuBar alloc] initWithFrame:CGRectMake(0,0, width,MARKET_MENU_BAR_HEIGHT_DEFAULT) dictionary:dict andType:MARKET_MENU_BAR_TYPE_AREA];
    menu.delegate = self;
    self.tableView.tableHeaderView = menu;
}

/**
 *  初始化TableView数据
 *
 *  @param then
 */
-(void)initWithJsonDataThen:(void (^)(void))then {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString* path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
        NSData* data = [NSData dataWithContentsOfFile:path];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *comments = dict[@"comments"];
        self.marketDataListJson = comments;
        
        NSMutableArray *entities = @[].mutableCopy;
        [comments enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [entities addObject:[[CarMarket alloc] initWithDictionary:obj]];
        }];
        self.marketDataList = entities.mutableCopy;
        
        // Callback
        dispatch_async(dispatch_get_main_queue(), ^{
            !then ?: then();
        });
    });
}

/**
 *  
 */
- (void)insertRowAtBottom {
    __weak CarMarketViewController *weakSelf = self;
    
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [weakSelf.tableView beginUpdates];
        NSMutableArray *entities = @[].mutableCopy;
        [weakSelf.marketDataListJson enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [entities addObject:[[CarMarket alloc] initWithDictionary:obj]];
        }];
        
        NSMutableArray *insertions = @[].mutableCopy;
        NSUInteger insertRow = [weakSelf.marketDataList count];
        for (NSUInteger i = 0; i < entities.count; ++i) {
            [insertions addObject:[NSIndexPath indexPathForRow:insertRow + i inSection:0]];
        }
        [weakSelf.tableView insertRowsAtIndexPaths:insertions withRowAnimation:UITableViewRowAnimationNone];
        [weakSelf.marketDataList addObjectsFromArray:entities.mutableCopy];
        [weakSelf.tableView endUpdates];
        
        [weakSelf.tableView.infiniteScrollingView stopAnimating];
    });
}

#pragma mark - MarketMenuBarDelegate

- (void) marketMenuBarTouched:(NSInteger)menuType withTag:(NSInteger)tag
{
    NSLog(@"---->%d:%d",menuType,tag);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.marketDataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CarMarketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MARKET_CELL_IDENTIFIER];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(CarMarketTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.marketData = self.marketDataList[indexPath.row];
}


#pragma mark - UITableViewDelegate



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CarMarket *comment = self.marketDataList[indexPath.row];
    return [tableView heightForCellWithIdentifier:MARKET_CELL_IDENTIFIER cacheByKey:comment.identifier configuration:^(CarMarketTableViewCell *cell){
        [self configureCell:cell atIndexPath:indexPath];
    }];
}

#pragma mark - Actions

@end
