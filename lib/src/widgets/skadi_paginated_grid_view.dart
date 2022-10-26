import 'package:flutter/material.dart';

import '../provider/skadi_provider.dart';
import 'spacing.dart';

class SkadiPaginatedGridBuilder extends StatefulWidget {
  ///Delegate for GridView
  final SliverGridDelegate gridDelegate;

  ///Normal GridView padding
  final EdgeInsets padding;

  ///Normal GridView padding
  final int itemCount;

  ///Normal GridView padding
  final bool hasMoreData;

  ///Normal GridView padding
  final Future<void> Function() dataLoader;

  ///If [SkadiPaginatedGridBuilder] is user inside another scroll view,
  ///you must provide a [scrollController] that also use in your parent [scrollController] scroll view
  final ScrollController? scrollController;

  ///GridView [physics]
  final ScrollPhysics physics;

  ///GridView [shrinkwrap]
  final bool shrinkWrap;

  ///Widget when loading for more data
  final Widget? loadingWidget;

  ///Widget to show when there is no data
  final Widget? onEmpty;

  ///Add provided scrollController to our PaginatedGridView
  ///Use case: Provided scroll controller usually happen when this GridView is inside another ListView,
  ///So we use provided scrollController to check for paginated trigger only but not attach to PaginatedList
  ///But sometime, provided ScrollController isn't attach to any parent ListView yet. So in that case it must be attach
  ///to our PaginatedList
  final bool attachProvidedScrollControllerToListView;

  ///Indicate if there is an error when getting more data
  final bool hasError;

  ///A widget that show at the bottom of ListView when there is an error
  final Widget Function()? errorWidget;

  final Widget Function(BuildContext context, int index) itemBuilder;
  const SkadiPaginatedGridBuilder({
    Key? key,
    required this.gridDelegate,
    required this.dataLoader,
    required this.itemCount,
    required this.itemBuilder,
    required this.hasMoreData,
    this.onEmpty,
    this.shrinkWrap = false,
    this.loadingWidget = const CircularProgressIndicator(),
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    this.physics = const ClampingScrollPhysics(),
    this.scrollController,
    this.attachProvidedScrollControllerToListView = false,
    this.hasError = false,
    this.errorWidget,
  }) : super(key: key);
  @override
  State<SkadiPaginatedGridBuilder> createState() => _SkadiPaginatedGridBuilderState();
}

class _SkadiPaginatedGridBuilderState extends State<SkadiPaginatedGridBuilder> {
  ScrollController? scrollController;
  int loadingState = 0;

  bool get _isPrimaryScrollView => widget.scrollController == null;

  void scrollListener(ScrollController controller) {
    if (controller.offset == controller.position.maxScrollExtent) {
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
      widget.scrollController?.addListener(() => scrollListener(widget.scrollController!));
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
    return Column(
      children: [
        Expanded(
          flex: _isPrimaryScrollView ? 1 : 0,
          child: GridView.builder(
            gridDelegate: widget.gridDelegate,
            shrinkWrap: widget.shrinkWrap,
            padding: widget.padding,
            controller: _isPrimaryScrollView
                ? scrollController
                : widget.attachProvidedScrollControllerToListView
                    ? widget.scrollController
                    : null,
            physics: widget.physics,
            itemCount: widget.itemCount,
            itemBuilder: widget.itemBuilder,
          ),
        ),
        _buildBottomLoadingWidget(),
      ],
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
