//
//  ViewController.swift
//  ZTabsViewDemo
//
//  Created by CaryZheng on 15/6/27.
//  Copyright (c) 2015年 CaryZheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, IZTabsView {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initTabsView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initTabsView()
    {
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
        
        let parentWidth = self.view.bounds.size.width
        let parentHeight = self.view.bounds.size.height
        
        let tabsView = ZTabsView()
        tabsView.delegate = self
        
        tabsView.frame = CGRectMake(0, statusBarHeight, parentWidth, parentHeight)
        
        let tabTitles = ["Tab1", "Tab2", "Tab3"]
        
        let view1 = UIView()
        view1.backgroundColor = UIColor.redColor()
        
        let view2 = UIView()
        view2.backgroundColor = UIColor.yellowColor()
        
        let view3 = UIView()
        view3.backgroundColor = UIColor.blueColor()
        
        let contentViews = [view1, view2, view3]
        tabsView.initView(tabTitles, contentViews: contentViews)
        
        self.view.addSubview(tabsView)
    }
    
    func onTabChanged(currentTabIndex: Int, lastTabIndex: Int)
    {
        ZLog.d("onTabChanged currentTabIndex = \(currentTabIndex), lastTabIndex = \(lastTabIndex)")
    }
}

