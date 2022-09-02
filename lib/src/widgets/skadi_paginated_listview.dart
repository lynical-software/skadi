import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

class SkadiPaginatedListView extends StatefulWidget {
  ///Normal Listview itemCount
  final int itemCount;

  ///Normal Listview physics
  final ScrollPhysics? physics;

  ///Normal Listview scrollDirection
  final Axis scrollDirection;

  ///Normal Listview shrinkWrap
  final bool shrinkWrap;

  ///Normal Listview reverse
  final bool reverse;

  ///Normal Listview itemBuilder
  final IndexedWidgetBuilder itemBuilder;

  ///[SkadiPaginatedListView] use ListView.separated, so you can provide divider widget
  ///This can be use to replace separatorBuilder
  final Widget? separator;

  ///[SkadiPaginatedListView] use ListView.separated, so you can provide divider widget
  final IndexedWidgetBuilder? separatorBuilder;

  ///Normal Listview padding
  final EdgeInsets padding;

  ///Provider a widget if there's no item
  final Widget? onEmpty;

  ///If [SkadiPaginatedListView] is user inside another scroll view,
  ///you must provide a [scrollController] that also use in your parent [scrollController] scroll view
  final ScrollController? scrollController;

  ///callback for getting more data when ScrollController reach max scrolExtends
  final Future<void> Function() dataLoader;

  ///condition to check if we still have more data to fetch
  ///Example: currentItems == totalItems or currentPage == totalPages
  final bool hasMoreData;

  ///widget to show when we're fetching more data
  final Widget? loadingWidget;

  ///Add provided scrollController to our PaginatedListview
  ///Use case: Provided scroll controller usually happen when this ListView is inside another Listview,
  ///So we use provided scrollController to check for paginated trigger only but not attach to PaginatedList
  ///But sometime, provided ScrollController isn't attach to any parent Listview yet. So in that case it must be attach
  ///to our PaginatedList
  final bool attachProvidedScrollControllerToListview;

  ///Indicate if there is an error when getting more data
  final bool hasError;

  ///A widget that show at the bottom of listview when there is an error
  final Widget? errorWidget;

  const SkadiPaginatedListView({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    required this.dataLoader,
    required this.hasMoreData,
    this.physics = const ClampingScrollPhysics(),
    this.shrinkWrap = false,
    this.loadingWidget = const CircularProgressIndicator(),
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    this.scrollDirection = Axis.vertical,
    this.attachProvidedScrollControllerToListview = false,
    this.hasError = false,
    this.reverse = false,
    this.separator,
    this.separatorBuilder,
    this.onEmpty,
    this.scrollController,
    this.errorWidget,
  }) : super(key: key);
  @override
  _SkadiPaginatedListViewState createState() => _SkadiPaginatedListViewState();
}

class _SkadiPaginatedListViewState extends State<SkadiPaginatedListView> {
  ScrollController? scrollController;
  int loadingState = 0;

  bool get _isPrimaryScrollView => widget.scrollController == null;

  void scrollListener(ScrollController controller) {
    if (widget.hasError) {
      return;
    }
    if (controller.offset == controller.position.maxScrollExtent) {
      loadingState += 1;
      onLoadingMoreData();
    }
  }

  void onLoadingMoreData() async {
    if (loadingState > 1) return;
    if (widget.hasMoreData) {
      await widget.dataLoader.call();
      if (mounted) {
        loadingState = 0;
      }
    }
  }

  void initController() {
    if (_isPrimaryScrollView) {
      scrollController = ScrollController();
      scrollController!.addListener(() => scrollListener(scrollController!));
    } else {
      widget.scrollController
          ?.addListener(() => scrollListener(widget.scrollController!));
    }
  }

  @override
  void initState() {
    initController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SkadiProvider? skadiProvider = SkadiProvider.of(context);
    final bool isEmpty = widget.itemCount == 0;
    if (isEmpty) {
      if (widget.onEmpty != null) {
        return widget.onEmpty!;
      }
      if (skadiProvider?.noDataWidget != null) {
        return skadiProvider!.noDataWidget!;
      }
    }
    return ListView.separated(
      key: widget.key,
      separatorBuilder: widget.separatorBuilder ??
          (context, index) => widget.separator ?? emptySizedBox,
      itemCount: widget.itemCount + 1,
      controller: _isPrimaryScrollView
          ? scrollController
          : widget.attachProvidedScrollControllerToListview
              ? widget.scrollController
              : null,
      padding: widget.padding,
      scrollDirection: widget.scrollDirection,
      physics: widget.physics,
      reverse: widget.reverse,
      shrinkWrap: widget.shrinkWrap,
      itemBuilder: (context, index) {
        if (index == widget.itemCount) {
          return _buildBottomLoadingWidget();
        }
        return widget.itemBuilder(context, index);
      },
    );
  }

  Widget _buildBottomLoadingWidget() {
    if (widget.hasError) {
      return widget.errorWidget ??
          IconButton(
            onPressed: () => widget.dataLoader(),
            icon: const Icon(Icons.refresh),
          );
    }
    return widget.hasMoreData
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: widget.loadingWidget),
          )
        : emptySizedBox;
  }
}
