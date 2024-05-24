//
//  AppDelegate.h
//  MoneyMorphApp
//
//  Created by Mert Özcan on 24.05.2024.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

