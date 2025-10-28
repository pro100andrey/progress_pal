import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../borders/dashed_border.dart';
import '../sortable_wrap/sortable_wrap.dart';
import 'editor/image_editor.dart';
import 'image_preview.dart';
import 'model.dart';
import 'pick_image.dart';

class ImagesInput extends StatefulWidget {
  const ImagesInput({
    required this.editorConfig,
    this.initialValue,
    this.label,
    this.errorText,
    this.focusNode,
    this.controller,
    this.autofocus = false,
    this.onChanged,
    this.maxImages = 0,
    this.reorderableOptions,
    super.key,
  });

  final List<ImageVm>? initialValue;
  final bool autofocus;
  final String? errorText;
  final FocusNode? focusNode;
  final Widget? label;
  final ImageEditorConfig editorConfig;
  final ImagesSelectorController? controller;
  final ValueChanged<List<ImageVm>>? onChanged;
  final ReorderableWrapOptions? reorderableOptions;
  final int maxImages;

  @override
  State<ImagesInput> createState() => ImagesInputState();
}

class ImagesInputState extends State<ImagesInput> {
  ImagesSelectorController? _controller;
  ImagesSelectorController get _effectiveController =>
      widget.controller ?? _controller!;

  FocusNode? _focusNode;
  FocusNode get _effectiveFocusNode => widget.focusNode ?? _focusNode!;
  bool _hasFocus = false;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      _controller = ImagesSelectorController(
        initialValue: widget.initialValue,
        maxImages: widget.maxImages,
      );
    }

    if (widget.focusNode == null) {
      _focusNode = FocusNode();
    }

    _effectiveFocusNode.addListener(_onFocusChange);
    _effectiveController.addListener(_onControllerChange);

    if (widget.autofocus && !_effectiveFocusNode.hasFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _effectiveFocusNode.requestFocus();
        }
      });
    }
  }

  void _onControllerChange() {
    setState(() {
      if (widget.onChanged != null) {
        final images = _effectiveController.images;
        widget.onChanged!(images);
      }
    });
  }

  void _onFocusChange() {
    setState(() {
      _hasFocus = _effectiveFocusNode.hasFocus;
    });
  }

  @override
  void didUpdateWidget(covariant ImagesInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.removeListener(_onFocusChange);
      _effectiveFocusNode.addListener(_onFocusChange);
    }

    // If the controller is not provided, create a new one
    if (widget.controller == null && oldWidget.controller != null) {
      _controller = ImagesSelectorController(
        initialValue: oldWidget.controller!.images,
        maxImages: oldWidget.maxImages,
      );
    } else if (widget.controller != null && oldWidget.controller == null) {
      _controller!.dispose();
      _controller = null;
    }
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_onFocusChange);

    if (widget.focusNode == null) {
      _focusNode?.dispose();
    }

    _effectiveController.removeListener(_onControllerChange);

    if (widget.controller == null) {
      _controller?.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final images = _effectiveController.images;
    final canAddMore = images.length < _effectiveController.maxImages;

    return MouseRegion(
      onHover: (event) => setState(() => _isHovering = true),
      onExit: (event) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: () => _effectiveFocusNode.requestFocus(),
        behavior: HitTestBehavior.translucent,
        child: Focus(
          focusNode: _effectiveFocusNode,
          child: InputDecorator(
            isFocused: _hasFocus,
            isHovering: _isHovering,
            decoration: InputDecoration(
              label: widget.label,
              errorText: widget.errorText,
            ),
            child: ReorderableWrap(
              options: widget.reorderableOptions,
              spacing: 8,
              runSpacing: 8,
              contentPadding: const EdgeInsets.all(2),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              onReorder: (oldIndex, newIndex) {
                _effectiveController.onReorder(oldIndex, newIndex);
              },
              children: [
                ...images.mapIndexed(
                  (index, image) => Stack(
                    key: ValueKey(index),
                    children: [
                      ImagePreview(
                        size: const Size(100, 100),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        source: image,
                        cacheSize: const Size(100, 100),
                      ),
                      Positioned(
                        top: 2,
                        right: 2,
                        child: IconButton(
                          padding: const EdgeInsets.all(2),
                          style: IconButton.styleFrom(
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            backgroundColor: theme.colorScheme.scrim.withAlpha(
                              100,
                            ),
                          ),
                          iconSize: 20,
                          onPressed: () =>
                              _effectiveController.removeImageAt(index),
                          icon: const Icon(LucideIcons.x),
                        ),
                      ),
                    ],
                  ),
                ),
                if (canAddMore)
                  SizedBox(
                    key: ReorderableWrap.notDraggableKey,
                    width: 100,
                    height: 100,
                    child: DashedBorder(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide.none,
                        ),
                        onPressed: () async {
                          await pickImage(
                            context: context,
                            editorConfig: widget.editorConfig,
                            onImageSelect: (image) {
                              _effectiveController.addImage(
                                MemoryImageVm(
                                  bytes: image.bytes,
                                  name: image.name,
                                ),
                              );
                            },
                          );
                        },
                        child: const Icon(LucideIcons.plus, size: 24),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImagesSelectorController extends ChangeNotifier {
  ImagesSelectorController({
    required this.maxImages,
    List<ImageVm>? initialValue,
  }) {
    if (initialValue != null) {
      _images.addAll(initialValue);
    }
  }

  final List<ImageVm> _images = [];

  /// Maximum number of images, 0 means no limit
  final int maxImages;

  List<ImageVm> get images => _images;

  void addImage(ImageVm image) {
    if (_images.length < maxImages || maxImages == 0) {
      _images.add(image);
      notifyListeners();
    }
  }

  void setImages(List<ImageVm> images) {
    _images
      ..clear()
      ..addAll(images);
    notifyListeners();
  }

  void removeImageAt(int index) {
    _images.removeAt(index);
    notifyListeners();
  }

  void onReorder(int oldIndex, int newIndex) {
    _images.swap(oldIndex, newIndex);
    notifyListeners();
  }

  void reset() {
    _images.clear();
    notifyListeners();
  }
}
