import 'package:flutter/material.dart';
import 'package:kiwkemart/ui/widgets/scrolling_list_with_tabbar/rect_getter.dart';
import 'package:kiwkemart/ui/widgets/scrolling_list_with_tabbar/scroll_to_index.dart';

class VerticalScrollableTabBarStatus {
  static bool isOnTap = false;
  static int isOnTapIndex = 0;

  static void setIndex(int index) {
    VerticalScrollableTabBarStatus.isOnTap = true;
    VerticalScrollableTabBarStatus.isOnTapIndex = index;
  }
}

enum VerticalScrollPosition { begin, middle, end }

class VerticalScrollableTabView extends StatefulWidget {
  final TabController _tabController;
  final List<dynamic> _listItemData;
  final Widget Function(dynamic aaa, int index) _eachItemChild;
  final VerticalScrollPosition _verticalScrollPosition;
  final List<Widget> _slivers;

  VerticalScrollableTabView({
    required TabController tabController,
    required List<dynamic> listItemData,
    required Widget Function(dynamic aaa, int index) eachItemChild,
    VerticalScrollPosition verticalScrollPosition =
        VerticalScrollPosition.begin,
    required List<Widget> slivers,
  })  : _tabController = tabController,
        _listItemData = listItemData,
        _eachItemChild = eachItemChild,
        _verticalScrollPosition = verticalScrollPosition,
        _slivers = slivers;

  @override
  _VerticalScrollableTabViewState createState() =>
      _VerticalScrollableTabViewState();
}

class _VerticalScrollableTabViewState extends State<VerticalScrollableTabView>
    with SingleTickerProviderStateMixin {
  late AutoScrollController scrollController;

  bool pauseRectGetterIndex = false;

  final listViewKey = RectGetter.createGlobalKey();

  Map<int, dynamic> itemsKeys = {};

  @override
  void initState() {
    widget._tabController.addListener(() {
      if (VerticalScrollableTabBarStatus.isOnTap) {
        animateAndScrollTo(VerticalScrollableTabBarStatus.isOnTapIndex);
        VerticalScrollableTabBarStatus.isOnTap = false;
      }
    });
    scrollController = AutoScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RectGetter(
      key: listViewKey,
      child: NotificationListener<ScrollNotification>(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          controller: scrollController,
          slivers: [...widget._slivers, buildVerticalSliverList()],
        ),
        onNotification: onScrollNotification,
      ),
    );
  }

  SliverList buildVerticalSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(List.generate(
        widget._listItemData.length,
        (index) {
          itemsKeys[index] = RectGetter.createGlobalKey();
          return buildItem(index);
        },
      )),
    );
  }

  Widget buildItem(int index) {
    dynamic category = widget._listItemData[index];
    return RectGetter(
      key: itemsKeys[index],
      child: AutoScrollTag(
        key: ValueKey(index),
        index: index,
        controller: scrollController,
        child: widget._eachItemChild(category, index),
      ),
    );
  }

  void animateAndScrollTo(int index) async {
    pauseRectGetterIndex = true;
    widget._tabController.animateTo(index);
    switch (widget._verticalScrollPosition) {
      case VerticalScrollPosition.begin:
        scrollController
            .scrollToIndex(index, preferPosition: AutoScrollPosition.begin)
            .then((value) => pauseRectGetterIndex = false);
        break;
      case VerticalScrollPosition.middle:
        scrollController
            .scrollToIndex(index, preferPosition: AutoScrollPosition.middle)
            .then((value) => pauseRectGetterIndex = false);
        break;
      case VerticalScrollPosition.end:
        scrollController
            .scrollToIndex(index, preferPosition: AutoScrollPosition.end)
            .then((value) => pauseRectGetterIndex = false);
        break;
    }
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (pauseRectGetterIndex) return true;

    int lastTabIndex = widget._tabController.length - 1;

    List<int> visibleItems = getVisibleItemsIndex();
    bool reachLastTabIndex = visibleItems.isNotEmpty &&
        visibleItems.length <= 2 &&
        visibleItems.last == lastTabIndex;
    if (reachLastTabIndex) {
      widget._tabController.animateTo(lastTabIndex);
    } else {
      int sumIndex = visibleItems.reduce((value, element) => value + element);
      int middleIndex = sumIndex ~/ visibleItems.length;
      if (widget._tabController.index != middleIndex) {
        widget._tabController.animateTo(middleIndex);
      }
    }
    return false;
  }

  List<int> getVisibleItemsIndex() {
    Rect? rect = RectGetter.getRectFromKey(listViewKey);
    List<int> items = [];
    if (rect == null) return items;

    /// TODO Horizontal ScrollDirection
    bool isHoriontalScroll = false;
    itemsKeys.forEach((index, key) {
      Rect? itemRect = RectGetter.getRectFromKey(key);
      if (itemRect == null) return;
      switch (isHoriontalScroll) {
        case true:
          if (itemRect.left > rect.right) return;
          if (itemRect.right < rect.left) return;
          break;
        default:
          if (itemRect.top > rect.bottom) return;
          if (itemRect.bottom < rect.top) return;
      }

      items.add(index);
    });
    return items;
  }
}
