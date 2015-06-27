//
//  ZLog.swift
//  ZTabsViewDemo
//
//  Created by CaryZheng on 15/6/27.
//  Copyright (c) 2015年 CaryZheng. All rights reserved.
//

import Foundation

class ZLog
{
    static let prefix = "iqusong"
    
    static func d<T>(value: T)
    {
        printPrefix()
        println(value)
    }
    
    private static func printPrefix()
    {
        print(prefix + ": ")
    }
}