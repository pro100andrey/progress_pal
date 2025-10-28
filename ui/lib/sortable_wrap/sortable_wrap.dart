import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

/// Configuration options for customizing the behavior and appearance of
/// [ReorderableWrap].
///
/// This class provides various options to control how dragging behavior works,
/// how draggable children are built, and how drag feedback is displayed.
///
/// Example:
/// ```dart
/// ReorderableWrapOptions(
///   isLongPressDraggable: true,
///   draggableChildBuilder: (child) => Container(
///     decoration: BoxDecoration(border: Border.all()),
///     child: child,
///   ),
/// )
/// ```
class ReorderableWrapOptions {
  /// Creates a new [ReorderableWrapOptions] with the specified configuration.
  ///
  /// All parameters are optional and have sensible defaults.
  ReorderableWrapOptions({
    this.isLongPressDraggable = false,
    this.draggableChildBuilder,
    this.draggableFeedbackBuilder = _defaultFeedbackBuilder,
  });

  /// Whether dragging should be initiated by a long press gesture.
  ///
  /// When `true`, children will only become draggable after a long press.
  /// When `false` (default), children become draggable immediately on tap.
  final bool isLongPressDraggable;

  /// Optional builder function to customize the appearance of draggable
  /// children.
  ///
  /// This function is called for each child widget and allows you to wrap
  /// or modify the child before it becomes draggable. For example, you might
  /// add a border or background color to indicate that the item is draggable.
  ///
  /// If null, children are used as-is without modification.
  final Widget Function(Widget child)? draggableChildBuilder;

  /// Builder function for customizing the drag feedback widget.
  ///
  /// This function is called when a drag operation starts and determines
  /// what widget is shown under the user's finger during the drag.
  ///
  /// Defaults to [_defaultFeedbackBuilder] which wraps the child in a
  /// [Material] widget with elevation for a subtle shadow effect.
  final Widget Function(Widget child) draggableFeedbackBuilder;

  /// Default feedback builder that provides a Material Design drag feedback.
  ///
  /// Creates a [Material] widget with elevation to give the dragged item
  /// a lifted appearance during the drag operation.
  static Widget _defaultFeedbackBuilder(Widget child) => Material(
    elevation: 18,
    color: Colors.transparent,
    shadowColor: Colors.transparent,
    borderRadius: BorderRadius.zero,
    child: child,
  );

  /// Creates a copy of this [ReorderableWrapOptions] with the given fields
  /// replaced.
  ///
  /// Any parameter that is not provided will retain its current value.
  ReorderableWrapOptions copyWith({
    bool? isLongPressDraggable,
    Widget Function(Widget child)? draggableChildBuilder,
    Widget Function(Widget child)? draggableFeedbackBuilder,
  }) => ReorderableWrapOptions(
    isLongPressDraggable: isLongPressDraggable ?? this.isLongPressDraggable,
    draggableChildBuilder: draggableChildBuilder ?? this.draggableChildBuilder,
    draggableFeedbackBuilder:
        draggableFeedbackBuilder ?? this.draggableFeedbackBuilder,
  );
}

/// A widget that displays children in a wrap layout with drag-and-drop
/// reordering support.
///
/// [ReorderableWrap] allows users to drag and drop children to reorder them.
/// It supports both immediate dragging and long-press dragging, with smooth
/// animations when items are reordered.
///
/// The widget uses a [Wrap] layout internally, so children will flow to new
/// rows when they exceed the available width. During drag operations, adjacent
/// items will animate to their new positions.
///
/// ## Example
///
/// ```dart
/// ReorderableWrap(
///   children: [
///     Container(width: 100, height: 50, color: Colors.red),
///     Container(width: 100, height: 50, color: Colors.blue),
///     Container(width: 100, height: 50, color: Colors.green),
///   ],
///   onSorted: (oldIndex, newIndex) {
///     // Handle reordering logic here
///     setState(() {
///       final item = items.removeAt(oldIndex);
///       items.insert(newIndex, item);
///     });
///   },
///   spacing: 8.0,
///   runSpacing: 8.0,
/// )
/// ```
///
/// ## Ignoring specific children
///
/// To prevent certain children from being draggable, assign them the
/// [ignoreKey]:
///
/// ```dart
/// Container(
///   key: ReorderableWrap.ignoreKey,
///   child: Text('This cannot be dragged'),
/// )
/// ```
class ReorderableWrap extends StatefulWidget {
  /// Creates a [ReorderableWrap] widget.
  ///
  /// The [children] and [onReorder] parameters are required.
  /// [children] contains the widgets to be displayed and made sortable.
  /// [onReorder] is called when the user completes a reordering operation.
  const ReorderableWrap({
    required this.children,
    required this.onReorder,
    this.alignment = WrapAlignment.start,
    super.key,
    this.onSortStart,
    this.onSortCancel,
    this.spacing = 0.0,
    this.runSpacing = 0.0,
    this.borderRadius,
    this.contentPadding,
    this.options,
  });

  /// Special key that can be assigned to children to prevent them from being
  /// draggable.
  ///
  /// Children with this key will be rendered normally but will not respond
  /// to drag gestures and cannot be reordered.
  static final notDraggableKey = UniqueKey();

  /// The list of child widgets to display and make sortable.
  ///
  /// Each child can be dragged and dropped to reorder the list, unless
  /// it has the [notDraggableKey] assigned.
  final List<Widget> children;

  /// How the children within a run should be placed in the main axis.
  ///
  /// This follows the same behavior as [Wrap.alignment].
  final WrapAlignment alignment;

  /// Called when a drag operation completes successfully with a reorder.
  ///
  /// The `oldIndex` parameter is the original position of the dragged item,
  /// and `newIndex` is its new position. Use this callback to update your
  /// data model to reflect the new order.
  final void Function(int oldIndex, int newIndex) onReorder;

  /// Called when a drag operation starts.
  ///
  /// The `index` parameter indicates which child (by its original position)
  /// started being dragged. This can be useful for providing visual feedback
  /// or preparing for the drag operation.
  final void Function(int index)? onSortStart;

  /// Called when a drag operation is cancelled without reordering.
  ///
  /// This happens when the user drops the item back to its original position
  /// or cancels the drag gesture. The `index` parameter indicates which
  /// child was being dragged.
  final void Function(int index)? onSortCancel;

  /// The amount of space to place between children in a run in the main axis.
  ///
  /// This follows the same behavior as [Wrap.spacing].
  final double spacing;

  /// The amount of space to place between the runs themselves in the cross
  /// axis.
  ///
  /// This follows the same behavior as [Wrap.runSpacing].
  final double runSpacing;

  /// The border radius to apply to the container that clips the wrap.
  ///
  /// If provided, the entire wrap will be clipped to this border radius.
  /// This is useful when you want rounded corners for the sortable area.
  final BorderRadiusGeometry? borderRadius;

  /// Padding to apply inside the decoration around the wrap.
  ///
  /// This is useful for adding space between the wrap's border and its
  /// children.
  final EdgeInsetsGeometry? contentPadding;

  /// Configuration options for customizing drag behavior and appearance.
  ///
  /// If null, default options will be used. See [ReorderableWrapOptions] for
  /// available configuration options.
  final ReorderableWrapOptions? options;

  @override
  State<ReorderableWrap> createState() => _ReorderableWrapState();
}

class _ReorderableWrapState extends State<ReorderableWrap> {
  static const double _dragOpacity = 0.2;

  final _wrapperKey = GlobalKey();
  _SortableElement? _draggingElement;
  final List<_SortableElement> _preservedElements = [];
  final List<_SortableElement> _animationElements = [];
  final Map<_SortableElement, _SortableItemState> _elementStates = {};
  ReorderableWrapOptions? _options;

  ReorderableWrapOptions get _effectiveOptions =>
      widget.options ?? (_options ??= ReorderableWrapOptions());

  @override
  void initState() {
    super.initState();
    _initializeElements();
  }

  @override
  void didUpdateWidget(covariant ReorderableWrap oldWidget) {
    super.didUpdateWidget(oldWidget);
    _cleanupElements();
    _initializeElements();
  }

  @override
  void dispose() {
    _cleanupElements();
    super.dispose();
  }

  void _initializeElements() {
    _preservedElements.clear();

    for (var i = 0; i < widget.children.length; i++) {
      final element = _SortableElement(
        child: widget.children[i],
        originalIndex: i,
      );

      _preservedElements.add(element);
    }

    _animationElements
      ..clear()
      ..addAll(_preservedElements);
  }

  void _cleanupElements() {
    _draggingElement = null;
    _preservedElements.clear();
    _animationElements.clear();
    _elementStates.clear();
  }

  @override
  Widget build(BuildContext context) => Container(
    clipBehavior: Clip.antiAlias,
    padding: widget.contentPadding,
    decoration: BoxDecoration(
      borderRadius: widget.borderRadius,
    ),
    child: Wrap(
      key: _wrapperKey,
      spacing: widget.spacing,
      runSpacing: widget.runSpacing,
      alignment: widget.alignment,
      children: _buildDraggableChildren(),
    ),
  );

  List<Widget> _buildDraggableChildren() =>
      _animationElements.map(_buildDraggableChild).toList(growable: false);

  Widget _buildDraggableChild(_SortableElement element) {
    if (element.child.key == ReorderableWrap.notDraggableKey) {
      return element.child;
    }

    if (_draggingElement != null) {
      return _buildDraggingChild(element);
    }

    return _buildNormalChild(element);
  }

  Widget _buildDraggingChild(_SortableElement element) {
    if (_draggingElement == element) {
      return IgnorePointer(
        child: Opacity(
          opacity: _dragOpacity,
          child: element.child,
        ),
      );
    }

    final index = _preservedElements.indexOf(element);
    return _SortableItem(
      key: ValueKey(index),
      element: element,
      onEventHit: _handleRollingEvent,
      animationElements: _animationElements,
      parentSpacing: widget.spacing,
      parentSize: _wrapperSize,
      onStateCreated: (state) => _elementStates[element] = state,
    );
  }

  Widget _buildNormalChild(_SortableElement element) {
    final child =
        _effectiveOptions.draggableChildBuilder?.call(element.child) ??
        element.child;

    var wrappedChild = child;

    // Wrap child to cache size after rendering
    wrappedChild = _SizeCapturingWidget(
      onSizeCaptured: (size) => element.size = size,
      child: wrappedChild,
    );

    if (_effectiveOptions.isLongPressDraggable) {
      return LongPressDraggable<_SortableElement>(
        data: element,
        key: element.key,
        feedback: _effectiveOptions.draggableFeedbackBuilder(element.child),
        onDragEnd: (_) => _onDragFinished(element),
        onDragStarted: () => _onDragStarted(element),
        onDragCompleted: () => _onDragFinished(element),
        onDraggableCanceled: (_, __) => _onDragFinished(element),
        child: wrappedChild,
      );
    }

    return Draggable<_SortableElement>(
      data: element,
      key: element.key,
      feedback: _effectiveOptions.draggableFeedbackBuilder(element.child),
      onDragEnd: (_) => _onDragFinished(element),
      onDragStarted: () => _onDragStarted(element),
      onDragCompleted: () => _onDragFinished(element),
      onDraggableCanceled: (_, __) => _onDragFinished(element),
      child: wrappedChild,
    );
  }

  Size get _wrapperSize {
    final renderBox =
        _wrapperKey.currentContext?.findRenderObject() as RenderBox?;
    return renderBox?.size ?? Size.zero;
  }

  void _onDragStarted(_SortableElement element) {
    setState(() {
      _draggingElement = element;
    });

    final index = _preservedElements.indexOf(element);
    widget.onSortStart?.call(index);
  }

  void _onDragFinished(_SortableElement element) {
    final newIndex = _animationElements.indexOf(element);
    final oldIndex = _preservedElements.indexOf(element);

    setState(() {
      _preservedElements
        ..clear()
        ..addAll(_animationElements);
      _draggingElement = null;
    });

    _notifyDragResult(oldIndex, newIndex);
  }

  void _notifyDragResult(int oldIndex, int newIndex) {
    if (oldIndex == newIndex) {
      widget.onSortCancel?.call(oldIndex);
    } else {
      widget.onReorder(oldIndex, newIndex);
    }
  }

  void _handleRollingEvent(
    _SortableItemState beHitItemState,
    _SortableElement holdingElement,
  ) {
    assert(_draggingElement != null, 'Dragging status inconsistency detected');
    assert(_draggingElement == holdingElement, 'Dragging element mismatch');

    final dragging = _draggingElement!;
    final targetElement = beHitItemState.widget.element;

    _performRollingAnimation(dragging, targetElement);
    setState(() {});
  }

  void _performRollingAnimation(
    _SortableElement dragging,
    _SortableElement targetElement,
  ) {
    final toIndex = _animationElements.indexOf(targetElement);
    final draggingIndex = _animationElements.indexOf(dragging);

    if (toIndex == draggingIndex) {
      return;
    }

    final animationConfig = _calculateAnimationConfig(
      draggingIndex: draggingIndex,
      toIndex: toIndex,
      dragging: dragging,
    );

    _executeRollingAnimation(animationConfig);
  }

  _AnimationConfig _calculateAnimationConfig({
    required int draggingIndex,
    required int toIndex,
    required _SortableElement dragging,
  }) {
    final width = _wrapperSize.width;

    // Only calculate if we have cached size, otherwise defer
    var countPerRow = 1;
    if (dragging.hasSize && dragging.size != null) {
      final elementWidth = dragging.size!.width;
      countPerRow = elementWidth > 0 && width > 0
          ? (width / elementWidth).floor()
          : 1;
    }

    final isDraggingInSameRow =
        toIndex ~/ countPerRow == draggingIndex ~/ countPerRow;
    final isDraggingToLowerIndex = toIndex < draggingIndex;

    return _AnimationConfig(
      startIndex: isDraggingToLowerIndex
          ? draggingIndex - 1
          : draggingIndex + 1,
      endIndex: toIndex,
      isDraggingToLowerIndex: isDraggingToLowerIndex,
      isDraggingInSameRow: isDraggingInSameRow,
      draggingIndex: draggingIndex,
    );
  }

  void _executeRollingAnimation(_AnimationConfig config) {
    for (
      var sourceIndex = config.startIndex;
      config.isDraggingToLowerIndex
          ? sourceIndex >= config.endIndex
          : sourceIndex <= config.endIndex;
      config.isDraggingToLowerIndex ? sourceIndex-- : sourceIndex++
    ) {
      final element = _animationElements[sourceIndex];
      final destinationIndex = config.isDraggingToLowerIndex
          ? sourceIndex + 1
          : sourceIndex - 1;

      _animationElements.swap(sourceIndex, destinationIndex);

      final elementState = _elementStates[element];
      if (elementState != null) {
        elementState.startAnimation(
          isDraggingInSameRow: config.isDraggingInSameRow,
          draggingIndex: config.draggingIndex,
          sourceIndex: sourceIndex,
          destinationIndex: destinationIndex,
        );
      }
    }
  }
}

class _SizeCapturingWidget extends StatefulWidget {
  const _SizeCapturingWidget({
    required this.onSizeCaptured,
    required this.child,
  });

  final void Function(Size size) onSizeCaptured;
  final Widget child;

  @override
  State<_SizeCapturingWidget> createState() => _SizeCapturingWidgetState();
}

class _SizeCapturingWidgetState extends State<_SizeCapturingWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final renderBox = context.findRenderObject()! as RenderBox;
        widget.onSizeCaptured(renderBox.size);
      }
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _AnimationConfig {
  const _AnimationConfig({
    required this.startIndex,
    required this.endIndex,
    required this.isDraggingToLowerIndex,
    required this.isDraggingInSameRow,
    required this.draggingIndex,
  });

  final int startIndex;
  final int endIndex;
  final bool isDraggingToLowerIndex;
  final bool isDraggingInSameRow;
  final int draggingIndex;
}

class _SortableItem extends StatefulWidget {
  const _SortableItem({
    required this.element,
    required this.onEventHit,
    required this.animationElements,
    required this.parentSpacing,
    required this.parentSize,
    super.key,
    this.onStateCreated,
  });

  final void Function(_SortableItemState, _SortableElement) onEventHit;
  final _SortableElement element;
  final List<_SortableElement> animationElements;
  final double parentSpacing;
  final Size parentSize;
  final void Function(_SortableItemState)? onStateCreated;

  @override
  _SortableItemState createState() => _SortableItemState();
}

class _SortableItemState extends State<_SortableItem>
    with TickerProviderStateMixin {
  static const _animationDuration = Duration(milliseconds: 200);

  late final _slideToRightController = AnimationController(
    vsync: this,
    duration: _animationDuration,
  );

  late final _slideToLeftController = AnimationController(
    vsync: this,
    duration: _animationDuration,
  );

  _GhostType _ghostType = _GhostType.none;

  _SortableElement get element => widget.element;

  @override
  void initState() {
    super.initState();

    widget.onStateCreated?.call(this);
  }

  @override
  void dispose() {
    _slideToRightController.dispose();
    _slideToLeftController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _buildAnimatedItem();

  Widget _buildAnimatedItem() {
    final children = [
      element.child,
      Positioned.fill(
        child: DragTarget<_SortableElement>(
          builder: (context, candidateData, rejectedData) => const SizedBox(),
          onWillAcceptWithDetails: (details) {
            widget.onEventHit(this, details.data);
            return true;
          },
          onAcceptWithDetails: (_) {},
          onLeave: (_) {},
        ),
      ),
    ];

    _addGhostViewIfNeeded(children);

    return SlideTransition(
      position: Tween(
        begin: Offset.zero,
        end: const Offset(-1, 0),
      ).animate(_slideToLeftController),
      child: SlideTransition(
        position: Tween(
          begin: Offset.zero,
          end: const Offset(1, 0),
        ).animate(_slideToRightController),
        child: Stack(
          clipBehavior: Clip.none,
          children: children,
        ),
      ),
    );
  }

  void _addGhostViewIfNeeded(List<Widget> children) {
    if (_ghostType == _GhostType.none) {
      return;
    }

    final ghostWidget = _createGhostWidget();
    if (ghostWidget != null) {
      final isInFront = _ghostType == _GhostType.previous;
      children.insert(isInFront ? 0 : children.length, ghostWidget);
    }
  }

  Widget? _createGhostWidget() {
    final elements = widget.animationElements;
    final visibleIndex = elements.indexOf(element);
    final isInFrontOfMe = _ghostType == _GhostType.previous;
    final resultIndex = isInFrontOfMe ? visibleIndex - 1 : visibleIndex + 1;

    if (resultIndex < 0 || resultIndex >= elements.length) {
      return null;
    }

    final sibling = elements[resultIndex];
    final spacing = widget.parentSpacing;
    final width = sibling.size!.width;
    final x = isInFrontOfMe ? -width - spacing : width + spacing;

    return Positioned(
      top: 0,
      bottom: 0,
      left: x,
      child: sibling.child,
    );
  }

  void startAnimation({
    required bool isDraggingInSameRow,
    required int draggingIndex,
    required int sourceIndex,
    required int destinationIndex,
  }) {
    final animationDirection = _determineAnimationDirection(
      sourceIndex,
      destinationIndex,
    );
    final animationFuture = _executeSlideAnimation(animationDirection);

    if (!isDraggingInSameRow) {
      final ghostType = _determineGhostType(animationDirection);

      if (ghostType != _GhostType.none && destinationIndex != draggingIndex) {
        setState(() {
          _ghostType = ghostType;
        });

        final _ = animationFuture.then(
          (_) => setState(() {
            _ghostType = _GhostType.none;
          }),
        );
      }
    }
  }

  _AnimationDirection _determineAnimationDirection(
    int sourceIndex,
    int destinationIndex,
  ) {
    if (destinationIndex > sourceIndex) {
      return _AnimationDirection.slideToRight;
    } else if (destinationIndex < sourceIndex) {
      return _AnimationDirection.slideToLeft;
    }

    throw ArgumentError(
      'Source and destination indices are the same: $sourceIndex',
    );
  }

  TickerFuture _executeSlideAnimation(_AnimationDirection direction) {
    switch (direction) {
      case _AnimationDirection.slideToRight:
        return _slideToLeftController.reverse(from: 1);
      case _AnimationDirection.slideToLeft:
        return _slideToRightController.reverse(from: 1);
    }
  }

  _GhostType _determineGhostType(_AnimationDirection direction) {
    // If element size is not cached, skip ghost type calculation
    if (!element.hasSize || element.size == null) {
      return _GhostType.none;
    }

    final width = widget.parentSize.width;

    final elementWidth = element.size!.width;
    final countPerRow = elementWidth > 0 && width > 0
        ? (width / elementWidth).floor()
        : 1;
    final elements = widget.animationElements;
    final index = elements.indexOf(element);

    switch (direction) {
      case _AnimationDirection.slideToRight:
        final isLastInRow =
            index != elements.length - 1 && (index + 1) % countPerRow == 0;
        return isLastInRow ? _GhostType.next : _GhostType.none;

      case _AnimationDirection.slideToLeft:
        final isFirstInRow = index != 0 && index % countPerRow == 0;
        return isFirstInRow ? _GhostType.previous : _GhostType.none;
    }
  }
}

enum _AnimationDirection { slideToLeft, slideToRight }

class _SortableElement {
  _SortableElement({
    required this.child,
    required this.originalIndex,
  }) : key = GlobalKey();

  final Widget child;
  final int originalIndex;
  final GlobalKey key;

  Size? _size;
  Size? get size => _size;

  bool get hasSize => _size != null;

  set size(Size size) {
    _size = size;
  }
}

enum _GhostType { none, previous, next }
