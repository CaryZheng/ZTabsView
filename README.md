# ZTabsView

![alt tag](https://github.com/CaryZheng/ZTabsView/blob/master/demo.gif)

Use:

```Swift
var tabsView = ZTabsView()
        
tabsView.frame = ...
        
let tabTitles = ["Tab1", "Tab2", "Tab3"]
        
var view1 = ...
var view2 = ...
var view3 = ...
        
let contentViews = [view1, view2, view3]
tabsView.initView(tabTitles, contentViews: contentViews)
        
self.view.addSubview(tabsView)

```
