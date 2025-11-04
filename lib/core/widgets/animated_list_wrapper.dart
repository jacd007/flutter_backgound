// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

extension AnimatedListWrapperExtension on ItemAnimationType {
  ItemAnimationType get reverse {
    switch (this) {
      case ItemAnimationType.slideLeft:
        return ItemAnimationType.slideRight;
      case ItemAnimationType.slideRight:
        return ItemAnimationType.slideLeft;
      case ItemAnimationType.slideUp:
        return ItemAnimationType.slideDown;
      case ItemAnimationType.slideDown:
        return ItemAnimationType.slideUp;
      case ItemAnimationType.fadeIn:
        return ItemAnimationType.fadeOut;
      case ItemAnimationType.fadeOut:
        return ItemAnimationType.fadeIn;
      case ItemAnimationType.scaleUp:
        return ItemAnimationType.scaleDown;
      case ItemAnimationType.scaleDown:
        return ItemAnimationType.scaleUp;
      case ItemAnimationType.sizeVertical:
        return ItemAnimationType.sizeHorizontal;
      case ItemAnimationType.sizeHorizontal:
        return ItemAnimationType.sizeVertical;
    }
  }
}

enum ItemAnimationType {
  slideLeft,
  slideRight,
  slideUp,
  slideDown,
  fadeIn,
  fadeOut,
  scaleUp,
  scaleDown,
  sizeVertical,
  sizeHorizontal,
  // You can add more animation types here.
}

enum CurveType {
  linear,
  easeIn,
  easeOut,
  easeInOut,
  fastLinearToSlowEaseIn,
  slowMiddle,
  bounceIn,
  bounceOut,
  elasticIn,
  elasticOut,
  // You can add more curve types here.
}

/// Enum to specify the layout type for the animated widgets.
enum LayoutType { list, grid }

/// A StatefulWidget that wraps either [AnimatedList] or [AnimatedGrid] to provide
/// animated insertion and removal of items with customizable animation types and curves
/// for both list and grid layouts. It allows external control over adding and removing
/// items and provides access to the item data within the [itemBuilder]. The animation
/// is handled internally based on the specified [insertAnimationType] and
/// [removeAnimationType].
class AnimatedListWrapper<T> extends StatefulWidget {
  /// The initial list of items to display. The type [T] can be any object.
  final List<T> initialList;

  /// The duration of the animation when inserting a new item. Defaults to 300 milliseconds.
  final Duration insertDuration;

  /// The duration of the animation when removing an item. Defaults to 300 milliseconds.
  final Duration removeDuration;

  /// A builder function that is called for each item in the list. It receives the
  /// [BuildContext] and the current item of type [T]. The animation is handled
  /// internally based on [insertAnimationType] and [removeAnimationType].
  final Widget Function(T item, int index) itemBuilder;

  /// The type of animation to use when inserting a new item. Defaults to [ItemAnimationType.slideRight].
  final ItemAnimationType insertAnimationType;

  /// The type of curve to use for the insert animation. Defaults to [CurveType.easeInOut].
  final CurveType insertCurveType;

  /// The type of animation to use when removing an item. Defaults to [ItemAnimationType.fadeOut].
  final ItemAnimationType removeAnimationType;

  /// The type of curve to use for the remove animation. Defaults to [CurveType.easeInOut].
  final CurveType removeCurveType;

  /// Specifies the layout type of the animated widgets. Defaults to [LayoutType.list].
  final LayoutType layoutType;

  /// If [layoutType] is [LayoutType.grid], this specifies the number of columns in the grid.
  final int gridCrossAxisCount;

  final SliverGridDelegate? gridDelegate;

  /// An optional key builder function that receives the current item [T] and
  /// returns a [Key]. This can be useful for Flutter to identify widgets
  /// more efficiently during updates.
  final Key? itemKeyBuilder;

  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final Clip clipBehavior;
  final Widget? emptyWidget;

  /// Returns a global key that can be used to access the internal state of the
  /// [AnimatedListWrapper] widget. This can be useful for accessing the
  /// internal state of the widget from outside the widget tree.
  static GlobalKey<_AnimatedListWrapperState<T>> globalKey<T>() =>
      GlobalKey<_AnimatedListWrapperState<T>>();

  /// ```
  ///  final _animatedListKey = AnimatedListWrapper.globalKey<String>();
  ///
  /// AnimatedListWrapper(
  ///   key: _animatedListKey,
  ///   ...
  /// );
  ///
  /// // remove
  ///    _animatedListKey.currentState?.removeItem(0);
  ///
  /// // add
  ///      _animatedListKey.currentState?.insertItem(newItem);
  ///
  /// ```
  const AnimatedListWrapper({
    super.key,
    required this.initialList,
    this.insertDuration = const Duration(milliseconds: 300),
    this.removeDuration = const Duration(milliseconds: 300),
    required this.itemBuilder,
    this.insertAnimationType = ItemAnimationType.slideLeft,
    this.insertCurveType = CurveType.easeInOut,
    this.removeAnimationType = ItemAnimationType.slideRight,
    this.removeCurveType = CurveType.easeInOut,
    this.layoutType = LayoutType.list,
    this.gridCrossAxisCount = 2,
    this.itemKeyBuilder,
    this.gridDelegate,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics = const BouncingScrollPhysics(),
    this.padding,
    this.emptyWidget,
    this.clipBehavior = Clip.hardEdge,
  }) : assert(
         layoutType == LayoutType.grid ? gridCrossAxisCount > 0 : true,
         'gridCrossAxisCount must be provided and greater than 0 when layoutType is grid.',
       );

  @override
  State<AnimatedListWrapper<T>> createState() => _AnimatedListWrapperState<T>();
}

class _AnimatedListWrapperState<T> extends State<AnimatedListWrapper<T>> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedGridState> _gridKey = GlobalKey<AnimatedGridState>();
  late List<T> _items;

  @override
  void initState() {
    super.initState();
    _items = List<T>.from(widget.initialList);
  }

  @override
  void didUpdateWidget(covariant AnimatedListWrapper<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Compara la propiedad actual con la propiedad antigua
    if (widget.initialList != oldWidget.initialList) {
      // Si la propiedad ha cambiado, actualiza el estado interno
      setState(() {
        _items = List<T>.from(widget.initialList);
      });
      debugPrint(
        'didUpdateWidget: _currentText actualizado a -> ${widget.initialList}',
      );
    }
  }

  /// Inserts a new [item] into the list at the specified [index]. If [index] is
  /// not provided, the item is added to the end of the list. This method also
  /// triggers the insert animation of the [AnimatedList] or [AnimatedGrid].
  void insertItem(T item, [int? index]) {
    final insertIndex = index ?? _items.length;
    _items.insert(insertIndex, item);
    if (widget.layoutType == LayoutType.list) {
      _listKey.currentState?.insertItem(
        insertIndex,
        duration: widget.insertDuration,
      );
    } else if (widget.layoutType == LayoutType.grid) {
      _gridKey.currentState?.insertItem(
        insertIndex,
        duration: widget.insertDuration,
      );
    }
  }

  /// Removes the item at the given [index] from the list. The [itemBuilder] is
  /// used to build the widget that will be animated during the removal process.
  /// This method also triggers the remove animation of the [AnimatedList] or [AnimatedGrid].
  void removeItem(int index) {
    final T removedItem = _items[index];
    //
    //

    if (widget.layoutType == LayoutType.list) {
      _listKey.currentState?.removeItem(
        index,
        (context, animation) => _buildAnimatedItem(
          context,
          removedItem,
          animation,
          widget.removeAnimationType.reverse,
          widget.removeCurveType,
        ),
        duration: widget.removeDuration,
      );
    } else if (widget.layoutType == LayoutType.grid) {
      _gridKey.currentState?.removeItem(
        index,
        (context, animation) => _buildAnimatedItem(
          context,
          removedItem,
          animation,
          widget.removeAnimationType.reverse,
          widget.removeCurveType,
        ),
        duration: widget.removeDuration,
      );
    }
    _items.removeAt(index);
  }

  /// Updates the item at the specified [index] with the provided [item].
  /// This method replaces the current item at the given index in the list
  /// and triggers a state update to rebuild the UI with the updated data.
  void updateItem(T item, int index) {
    _items[index] = item;
    setState(() {});
  }

  /// Updates the current list with a new [newList]. This implementation performs
  /// a simple replacement of the internal list and triggers a rebuild.
  void updateList(List<T> newList) {
    // ignore: unused_local_variable
    final oldList = List<T>.from(_items);
    _items = List<T>.from(newList);
    setState(() {});
  }

  /// Builds the animated widget for each item based on the specified
  /// [ItemAnimationType] and [CurveType]. This method wraps the widget returned
  /// by the [itemBuilder] with the appropriate animation transition widget.
  Widget _buildAnimatedItem(
    BuildContext context,
    T item,
    Animation<double> animation,
    ItemAnimationType animationType,
    CurveType curveType,
  ) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: _getCurve(curveType),
    );
    final Widget content = widget.itemBuilder(item, _items.indexOf(item));

    switch (animationType) {
      case ItemAnimationType.slideLeft:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: content,
        );
      case ItemAnimationType.slideRight:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1.0, 0.0),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: content,
        );
      case ItemAnimationType.slideUp:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: content,
        );
      case ItemAnimationType.slideDown:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, -1.0),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: content,
        );
      case ItemAnimationType.fadeIn:
        return FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
          child: content,
        );
      case ItemAnimationType.fadeOut:
        return FadeTransition(
          opacity: Tween<double>(begin: 1.0, end: 0.0).animate(curvedAnimation),
          child: content,
        );
      case ItemAnimationType.scaleUp:
        return ScaleTransition(
          scale: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
          child: content,
        );
      case ItemAnimationType.scaleDown:
        return ScaleTransition(
          scale: Tween<double>(begin: 1.0, end: 0.0).animate(curvedAnimation),
          child: content,
        );
      case ItemAnimationType.sizeVertical:
        return SizeTransition(
          sizeFactor: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(curvedAnimation),
          axis: Axis.vertical,
          axisAlignment: -1.0, // Ensures it grows from the top
          child: content,
        );
      case ItemAnimationType.sizeHorizontal:
        return SizeTransition(
          sizeFactor: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(curvedAnimation),
          axis: Axis.horizontal,
          axisAlignment: -1.0, // Ensures it grows from the left
          child: content,
        );
    }
  }

  /// Returns the Flutter [Curve] object corresponding to the provided [CurveType] enum value.
  Curve _getCurve(CurveType curveType) {
    switch (curveType) {
      case CurveType.linear:
        return Curves.linear;
      case CurveType.easeIn:
        return Curves.easeIn;
      case CurveType.easeOut:
        return Curves.easeOut;
      case CurveType.easeInOut:
        return Curves.easeInOut;
      case CurveType.fastLinearToSlowEaseIn:
        return Curves.fastLinearToSlowEaseIn;
      case CurveType.slowMiddle:
        return Curves.slowMiddle;
      case CurveType.bounceIn:
        return Curves.bounceIn;
      case CurveType.bounceOut:
        return Curves.bounceOut;
      case CurveType.elasticIn:
        return Curves.elasticIn;
      case CurveType.elasticOut:
        return Curves.elasticOut;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_items.isEmpty) {
      return widget.emptyWidget ?? Center(child: Text('List is empty'));
    }
    if (widget.layoutType == LayoutType.list) {
      return AnimatedList(
        key: _listKey,
        scrollDirection: widget.scrollDirection,
        reverse: widget.reverse,
        controller: widget.controller,
        primary: widget.primary,
        physics: widget.physics,
        padding: widget.padding,
        clipBehavior: widget.clipBehavior,
        initialItemCount: _items.length,
        itemBuilder: (context, index, animation) {
          final item = _items[index];
          return _buildAnimatedItem(
            context,
            item,
            animation,
            widget.insertAnimationType,
            widget.insertCurveType,
          );
        },
      );
    } else if (widget.layoutType == LayoutType.grid) {
      return AnimatedGrid(
        key: _gridKey,
        scrollDirection: widget.scrollDirection,
        reverse: widget.reverse,
        controller: widget.controller,
        primary: widget.primary,
        physics: widget.physics,
        padding: widget.padding,
        clipBehavior: widget.clipBehavior,
        gridDelegate:
            widget.gridDelegate ??
            SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.gridCrossAxisCount,
            ),
        initialItemCount: _items.length,
        itemBuilder: (context, index, animation) {
          final item = _items[index];
          return _buildAnimatedItem(
            context,
            item,
            animation,
            widget.insertAnimationType,
            widget.insertCurveType,
          );
        },
      );
    } else {
      return const SizedBox.shrink(); // Fallback in case of unknown layout type
    }
  }
}
