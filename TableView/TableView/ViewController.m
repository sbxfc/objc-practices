//
//  ViewController.m
//  TableView
//
//  Created by sbxfc on 16/7/22.
//  Copyright © 2016年 me.rungame.sbxfc. All rights reserved.
//

#import "ViewController.h"
#import "Comment.h"
#import "CommentCell.h"
#import "UITableView+ExtHeightCache.h"

#define COMMENT_CELL_IDENTIFIER @"CommentCell"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *commentsArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.commentsArray = @[].mutableCopy;
    [self loadJsonDataThen:^{
        [self.tableView reloadData];
    }];
}

-(void)loadJsonDataThen:(void (^)(void))then {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString* path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
        NSData* data = [NSData dataWithContentsOfFile:path];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *comments = dict[@"comments"];
        
        NSMutableArray *entities = @[].mutableCopy;
        [comments enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [entities addObject:[[Comment alloc] initWithDictionary:obj]];
        }];
        self.commentsArray = entities;
        
        // Callback
        dispatch_async(dispatch_get_main_queue(), ^{
            !then ?: then();
        });
    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:COMMENT_CELL_IDENTIFIER];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(CommentCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.comment = self.commentsArray[indexPath.row];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Comment *comment = self.commentsArray[indexPath.row];
    return [tableView heightForCellWithIdentifier:COMMENT_CELL_IDENTIFIER cacheByKey:comment.identifier configuration:^(CommentCell *cell){
        [self configureCell:cell atIndexPath:indexPath];
    }];
}

#pragma mark - Actions


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
