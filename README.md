# CollectionViewWithTableView
仿Boss的交互效果

在`UICollectionView`上集成了`UITableView`，来实现`Boss直聘`的交互效果

效果图如下

![仿Boss的转场和交互.gif](https://ooo.0o0.ooo/2016/04/07/57061ef5e53d9.gif)

备注：由于最近离职时遇到了一些坑忙的焦头烂额，因此一些小的地方还没做处理：

1. 在`ViewController`中左右滑动时，没有通知`FirstViewController`的`tableView`滚动到对应的位置
2. `TestCollectionViewCell`中进行的下载用的是 `GCD` 模仿的因此你在快速左右滑动时会出现一些小BUG
3. 带动画的`button`没来得及写出来 
