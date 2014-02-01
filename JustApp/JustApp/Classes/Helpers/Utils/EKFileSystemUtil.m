    //
    //  EKFileSystemUtil.m
    //  JustApp
    //
    //  Created by Evgeny Karkan on 01.02.14.
    //  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
    //

#import "EKFileSystemUtil.h"


@implementation EKFileSystemUtil;

#pragma mark - Public APIs

+ (void)createNewFolderInDocumentsWithName:(NSString *)folderName;
{
	NSParameterAssert(folderName != nil);
	NSParameterAssert([folderName length] > 0);
	NSParameterAssert(![folderName isEqualToString:@" "]);
    
	NSError *error = nil;
	NSString *dataPath = [[self documentDirectoryPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", @"/", folderName]];
    
	if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
		[[NSFileManager defaultManager] createDirectoryAtPath:dataPath
		                          withIntermediateDirectories:NO
		                                           attributes:nil
		                                                error:&error];
		NSParameterAssert(error == nil);
	}
    /*
     else {
     NSString *exceptionString = [NSString stringWithFormat:@"Folder %@ already exist", folderName];
     NSException *exception = [NSException exceptionWithName:exceptionString reason:exceptionString userInfo:nil];
     [exception raise];
     }
     */
}

+ (void)copyFile:(NSString *)fileToCopy toFolder:(NSString *)folderName
{
    NSParameterAssert(fileToCopy != nil);
	NSParameterAssert([fileToCopy length] > 0);
	NSParameterAssert(![fileToCopy isEqualToString:@" "]);
    
    NSParameterAssert(folderName != nil);
	NSParameterAssert([folderName length] > 0);
	NSParameterAssert(![folderName isEqualToString:@" "]);
    
    NSError *error = nil;
	NSString *path = [[[self documentDirectoryPath] stringByAppendingPathComponent:folderName] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", @"/", fileToCopy]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
		NSString *resourcePath = [[NSBundle mainBundle] pathForResource:[fileToCopy stringByDeletingPathExtension]
		                                                         ofType:[fileToCopy pathExtension]];
		[[NSFileManager defaultManager] copyItemAtPath:resourcePath
		                                        toPath:path
		                                         error:&error];
		NSParameterAssert(error == nil);
	}
    /*
     else {
     NSString *exceptionString = [NSString stringWithFormat:@"File %@ already exist in %@", fileToCopy ,folderName];
     NSException *exception = [NSException exceptionWithName:exceptionString reason:exceptionString userInfo:nil];
     [exception raise];
     }
     */
}

+ (NSArray *)filesFromFolder:(NSString *)folderName
{
	NSParameterAssert(folderName != nil);
	NSParameterAssert([folderName length] > 0);
	NSParameterAssert(![folderName isEqualToString:@" "]);
    
	NSMutableArray *result = [@[] mutableCopy];
	NSArray *filesNames = [self filesNamesInFolder:folderName];
    
	NSData *file = nil;
    
	for (NSUInteger i = 0; i < [filesNames count]; i++) {
		NSParameterAssert(filesNames[i] != nil);
		NSString *name = [(NSString *)filesNames[i] stringByDeletingPathExtension];
		file = [[NSFileManager defaultManager] contentsAtPath:[self pathForFile:(NSString *)filesNames[i]
		                                                               inFolder:folderName]];
		[result addObject:@{ name: file }];
	}
    
	return [result copy];
}

#pragma mark - Private APIs

+ (NSString *)documentDirectoryPath
{
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString *)pathForFileName:(NSString *)fileName
{
	NSParameterAssert(fileName != nil);
	NSParameterAssert([fileName length] > 0);
	NSParameterAssert(![fileName isEqualToString:@" "]);
    
	return [[self documentDirectoryPath] stringByAppendingPathComponent:fileName];
}

+ (NSString *)pathForFile:(NSString *)fileName inFolder:(NSString *)folderName
{
	NSParameterAssert(fileName != nil);
	NSParameterAssert([fileName length] > 0);
	NSParameterAssert(![fileName isEqualToString:@" "]);
    
	NSParameterAssert(folderName != nil);
	NSParameterAssert([folderName length] > 0);
	NSParameterAssert(![folderName isEqualToString:@" "]);
    
	NSString *resultPath = nil;
    
	if ([[NSFileManager defaultManager] fileExistsAtPath:[[[self documentDirectoryPath] stringByAppendingPathComponent:folderName] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", @"/", fileName]]]) {
		resultPath = [[[self documentDirectoryPath] stringByAppendingPathComponent:folderName] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", @"/", fileName]];
	}
    /*
     else {
     NSString *exceptionString = [NSString stringWithFormat:@"Folder %@ and/or file %@ doesn't exist", folderName, fileName];
     NSException *exception = [NSException exceptionWithName:exceptionString reason:exceptionString userInfo:nil];
     [exception raise];
     }
     */
    
	return resultPath;
}

+ (NSArray *)filesNamesInFolder:(NSString *)folderName
{
	NSParameterAssert(folderName != nil);
	NSParameterAssert([folderName length] > 0);
	NSParameterAssert(![folderName isEqualToString:@" "]);
    
	NSArray *result = nil;
    NSError *error = nil;
    
	if ([[NSFileManager defaultManager] fileExistsAtPath:[[self documentDirectoryPath] stringByAppendingPathComponent:folderName]]) {
		result = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[[self documentDirectoryPath] stringByAppendingPathComponent:folderName]
		                                                             error:&error];
        NSParameterAssert(error == nil);
	}
    else {
        NSString *exceptionString = [NSString stringWithFormat:@"Folder %@ doesn't exist", folderName];
        NSException *exception = [NSException exceptionWithName:exceptionString reason:exceptionString userInfo:nil];
        [exception raise];
    }
    
    NSAssert([result count] > 0, @"Folder is empty");
    
	return result;
}

@end
