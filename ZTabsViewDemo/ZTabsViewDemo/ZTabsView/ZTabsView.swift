//
//  ZTabsView.swift
//  ZTabsViewDemo
//
//  Created by CaryZheng on 15/6/27.
//  Copyright (c) 2015年 CaryZheng. All rights reserved.
//

import UIKit

protocol IZTabsView
{
    func onTabChanged(currentTabIndex: Int, lastTabIndex: Int)
}

class ZTabsView : UIView
{
    var delegate: IZTabsView?
    
    private var mTabIndicatorViews = [UIView]()
    private var mTabContentViews = [UIView]()
    
    private var mCurrentSelectedIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(tabTitles: [String], contentViews: [UIView])
    {
        let tabIndicatorViewHeight: CGFloat = 40
        
        let parentWidth = self.bounds.width
        
        let tabIndicatorView = UIView()
        tabIndicatorView.layer.anchorPoint = CGPointZero
        tabIndicatorView.frame = CGRectMake(0, 0, parentWidth, tabIndicatorViewHeight)
        tabIndicatorView.backgroundColor = UIColor.whiteColor()
        
        let tabCount = tabTitles.count
        for(var i = 0; i < tabCount; ++i)
        {
            // tab
            let width = parentWidth/CGFloat(tabCount)
            
            let indicatorView = UIView()
            indicatorView.layer.anchorPoint = CGPoint(x: 0, y: 0)
            
            let x = width * CGFloat(i)
            indicatorView.frame = CGRectMake(x, 0, width, tabIndicatorView.bounds.height)
            
            let btn = UIButton()
            btn.frame = CGRectMake(0, 0, indicatorView.bounds.width, indicatorView.bounds.height)
            
            btn.titleLabel?.font = btn.titleLabel?.font.fontWithSize(14)
            btn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            btn.setTitle(tabTitles[i], forState: UIControlState.Normal)
            
            btn.tag = i
            btn.addTarget(self, action: "onTabPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            
            indicatorView.addSubview(btn)
            
            // underline
            let underlineView = UIView()
            underlineView.layer.anchorPoint = CGPointMake(0.5, 1)
            underlineView.frame = CGRectMake(0, 0, indicatorView.bounds.width*2/3, 2)
            underlineView.center = CGPointMake(indicatorView.bounds.width/2, indicatorView.bounds.height)
            underlineView.backgroundColor = ColorUtility.colorize(ColorConstant.main_theme)
            
            indicatorView.addSubview(underlineView)
            
            mTabIndicatorViews.append(indicatorView)
            
            tabIndicatorView.addSubview(indicatorView)
            
            // content
            let contentView = contentViews[i]
            let contentViewY = tabIndicatorView.bounds.origin.y + tabIndicatorView.bounds.height
            contentView.frame = CGRectMake(0, contentViewY, parentWidth, self.bounds.height-tabIndicatorViewHeight)
            
            mTabContentViews.append(contentView)
            
            self.addSubview(mTabContentViews[i])
        }
        
        self.addSubview(tabIndicatorView)
        
        // divider
        let dividerView = UIView()
        dividerView.frame = CGRectMake(0, tabIndicatorView.frame.origin.y+tabIndicatorView.bounds.height, parentWidth, 1)
        dividerView.backgroundColor = ColorUtility.colorize(ColorConstant.common_divider)
        self.addSubview(dividerView)
        
        mCurrentSelectedIndex = 0
        setCurrentTab(mCurrentSelectedIndex)
    }
    
    func getTabView(index: Int) -> UIView
    {
        return mTabIndicatorViews[index]
    }
    
    func getContentView(index: Int) -> UIView
    {
        return mTabContentViews[index]
    }
    
    func onTabPressed(sender: UIButton)
    {
        let index = sender.tag
        
        ZLog.d("onTabPressed index = \(index)")
        
        setCurrentTab(index)
    }
    
    func getCurrentSelectedIndex() -> Int
    {
        return mCurrentSelectedIndex
    }
    
    func setCurrentTab(index: Int)
    {
        for(var i = 0; i < mTabIndicatorViews.count; ++i)
        {
            let tabIndicatorView = mTabIndicatorViews[i]
            
            if(index == i)
            {
                for childView in tabIndicatorView.subviews
                {
                    if childView is UIButton
                    {
                        (childView as! UIButton).setTitleColor(ColorUtility.colorize(ColorConstant.main_theme), forState: UIControlState.Normal)
                    }
                    else
                    {
                        childView.hidden = false
                    }
                }
            }
            else
            {
                for childView in tabIndicatorView.subviews
                {
                    if childView is UIButton
                    {
                        (childView as! UIButton).setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
                    }
                    else
                    {
                        childView.hidden = true
                    }
                }
            }
        }
        
        for(var i = 0; i < mTabContentViews.count; ++i)
        {
            let contentView = mTabContentViews[i]
            
            if(index == i)
            {
                contentView.hidden = false
            }
            else
            {
                contentView.hidden = true
            }
        }
        
        if(mCurrentSelectedIndex != index)
        {
            // tab changed
            if(nil != delegate)
            {
                let currentSelectedIndex = index
                let lastSelectedIndex = mCurrentSelectedIndex
                delegate?.onTabChanged(currentSelectedIndex, lastTabIndex: lastSelectedIndex)
            }
            
            mCurrentSelectedIndex = index
        }
    }
}
