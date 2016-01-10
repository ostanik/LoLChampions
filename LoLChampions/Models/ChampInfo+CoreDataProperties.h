//
//  ChampInfo+CoreDataProperties.h
//  LoLChampions
//
//  Created by Alan Ostanik on 1/9/16.
//  Copyright © 2016 Ostanik. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ChampInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChampInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *attack;
@property (nullable, nonatomic, retain) NSNumber *defense;
@property (nullable, nonatomic, retain) NSNumber *difficulty;
@property (nullable, nonatomic, retain) NSNumber *identifier;
@property (nullable, nonatomic, retain) NSNumber *magic;
@property (nullable, nonatomic, retain) NSString *splashPath;
@property (nullable, nonatomic, retain) Champions *championID;

@end

NS_ASSUME_NONNULL_END
