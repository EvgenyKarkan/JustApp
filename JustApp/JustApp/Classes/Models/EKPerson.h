//
//  EKPerson.h
//  JustApp
//
//  Created by Evgeny Karkan on 03.02.14.
//  Copyright (c) 2014 EvgenyKarkan. All rights reserved.
//


@interface EKPerson : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) UIImage  *avatar;

- (instancetype)initWithName:(NSString *)name
                    lastName:(NSString *)lastNAme
                      avatar:(UIImage *)avatar;

@end
