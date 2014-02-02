//
//  EKFileSystemUtil.h
//  JustApp
//
//  Created by Evgeny Karkan on 01.02.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//


@interface EKFileSystemUtil : NSObject

+ (void)createNewFolderInDocumentsWithName:(NSString *)folderName;
+ (void)copyFile:(NSString *)fileToCopy toFolder:(NSString *)folderName;
+ (NSArray *)filesFromFolder:(NSString *)folderName;

@end
