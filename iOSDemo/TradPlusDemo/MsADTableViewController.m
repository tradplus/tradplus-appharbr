//
//  MsADTableViewController.m
//  TradPlusDemo
//
//  Created by ms-mac on 2017/1/9.
//  Copyright © 2017年 TradPlus. All rights reserved.
//

#import "MsADTableViewController.h"
#import "TPListViewController.h"

@interface MsADTableViewController ()

@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,strong)NSArray *titleList;
@end

@implementation MsADTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorColor = [UIColor colorWithRed:0.31 green:0.31 blue:0.31 alpha:1];
    self.tableView.rowHeight = 50;
    self.tableView.sectionHeaderHeight = 30;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.accessibilityLabel = @"Ad Table View";
    CGRect rect = [UIScreen mainScreen].bounds;
    rect.size.height = 20;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:rect];
    
    self.titleArray = @[@"Interstitial"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return self.titleArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    if(indexPath.row < self.titleArray.count)
    {
        cell.textLabel.text = self.titleArray[indexPath.row];
    }
    cell.textLabel.textColor = [UIColor colorWithRed:0.42 green:0.66 blue:0.85 alpha:1];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *detailViewController = nil;
    if(indexPath.section == 0)
    {
        switch (indexPath.row)
        {
            case 0://Interstitial
            {
                detailViewController = [[TPListViewController alloc] initWithNibName:@"TPListViewController" bundle:nil];
            }
//            case 2://Native
//            {
//                detailViewController = [[TradPlusAdNativeViewController alloc] initWithNibName:@"TradPlusAdNativeViewController" bundle:nil];
//                break;
//            }
//            case 1://Banner
//            {
//                detailViewController = [[TradPlusAdBannerViewController alloc] initWithNibName:@"TradPlusAdBannerViewController" bundle:nil];
//                break;
//            }
//            case 3://Rewarded
//            {
//                detailViewController = [[TradPlusAdRewardedViewController alloc] initWithNibName:@"TradPlusAdRewardedViewController" bundle:nil];
//                break;
//            }
//            case 4://Splash
//            {
//                detailViewController = [[TradPlusAdSplashViewController alloc] initWithNibName:@"TradPlusAdSplashViewController" bundle:nil];
//                break;
//            }
        }
    }
    if(detailViewController != nil)
    {
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}


@end
