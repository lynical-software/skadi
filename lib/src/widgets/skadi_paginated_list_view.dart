import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

class SkadiPaginatedListView extends StatefulWidget {
  ///Normal List view itemCount
  final int itemCount;

  ///Normal ListView physics
  final ScrollPhysics? physics;

  ///Normal ListView scrollDirection
  final Axis scrollDirection;

  ///Normal ListView shrinkWrap
  final bool shrinkWrap;

  ///Normal ListView reverse
  final bool reverse;

  ///Normal ListView itemBuilder
  final IndexedWidgetBuilder itemBuilder;

  ///[SkadiPaginatedListView] use ListView.separated, so you can provide divider widget
  final IndexedWidgetBuilder? separatorBuilder;

  ///Normal List view padding
  final EdgeInsets padding;

  ///Provider a widget if there's no item
  final Widget? onEmpty;

  ///If [SkadiPaginatedListView] is user inside another scroll view,
  ///you must provide a [scrollController] that also use in your parent [scrollController] scroll view
  final ScrollController? scrollController;

  ///callback for getting more data when ScrollController reach max scrollExtends
  final AsyncCallback dataLoader;

  ///condition to check if we still have more data to fetch
  ///Example: currentItems == totalItems or currentPage == totalPages
  final bool hasMoreData;

  ///widget to show when we're fetching more data
  final Widget? loadingWidget;

  ///Add provided scrollController to our PaginatedListView
  ///Use case: Provided scroll controller usually happen when this ListView is inside another ListView,
  ///So we use provided scrollController to check for paginated trigger only but not attach to PaginatedList
  ///But sometime, provided ScrollController isn't attach to any parent ListView yet. So in that case it must be attach
  ///to our PaginatedList
  final bool attachProvidedScrollControllerToListView;

  ///Indicate if there is an error when getting more data
  final bool hasError;

  ///A widget that show at the bottom of ListView when there is an error
  final Widget Function()? errorWidget;

  ///Load more data if we reach this offset start from the bottom
  ///Make sure to calculate with loading widget height
  final double fetchOffset;

  const SkadiPaginatedListView({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    required this.dataLoader,
    required this.hasMoreData,
    this.physics = const ClampingScrollPhysics(),
    this.shrinkWrap = false,
    this.fetchOffset = 0.0,
    this.loadingWidget = const CircularProgressIndicator(),
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    this.scrollDirection = Axis.vertical,
    this.attachProvidedScrollControllerToListView = false,
    this.hasError = false,
    this.reverse = false,
    this.separatorBuilder,
    this.onEmpty,
    this.scrollController,
    this.errorWidget,
  }) : super(key: key);
  @override
  State<SkadiPaginatedListView> createState() => _SkadiPaginatedListViewState();
}

class _SkadiPaginatedListViewState extends State<SkadiPaginatedListView> {
  ScrollController? scrollController;
  int loadingState = 0;

  bool get _isPrimaryScrollView => widget.scrollController == null;

  void scrollListener(ScrollController controller) {
    if (widget.hasError) {
      return;
    }
    double offsetToFetch =
        controller.position.maxScrollExtent - widget.fetchOffset;
    if (controller.offset >= offsetToFetch) {
      loadingState += 1;
      onLoadingMoreData();
    }
  }

  void onLoadingMoreData() async {
    if (loadingState > 1) return;
    if (widget.hasMoreData) {
      await widget.dataLoader();
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

  void checkInitialScrollPosition() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      double maxExtents = _isPrimaryScrollView
          ? scrollController!.position.maxScrollExtent
          : widget.scrollController!.position.maxScrollExtent;
      if (maxExtents <= 0 && !widget.hasError) {
        onLoadingMoreData();
      }
    });
  }

  void removeListener() {
    if (_isPrimaryScrollView) {
      scrollController!.removeListener(() => scrollListener(scrollController!));
      scrollController?.dispose();
    } else {
      widget.scrollController
          ?.removeListener(() => scrollListener(widget.scrollController!));
    }
  }

  @override
  void initState() {
    initController();
    checkInitialScrollPosition();
    super.initState();
  }

  @override
  void dispose() {
    removeListener();
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
        return skadiProvider!.noDataWidget!.call(widget.dataLoader);
      }
    }
    return ListView.separated(
      key: widget.key,
      separatorBuilder:
          widget.separatorBuilder ?? (context, index) => emptySizedBox,
      itemCount: widget.itemCount + 1,
      controller: _isPrimaryScrollView
          ? scrollController
          : widget.attachProvidedScrollControllerToListView
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
      return widget.errorWidget?.call() ??
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
