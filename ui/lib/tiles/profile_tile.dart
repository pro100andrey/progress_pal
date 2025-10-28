import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../image/image_preview.dart';
import '../image/model.dart';

class ProfileTileVm extends Equatable {
  const ProfileTileVm({
    required this.userName,
    required this.avatar,
  });

  final ImageVm avatar;
  final String userName;

  @override
  List<Object?> get props => [avatar, userName];
}

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    required this.vm,
    super.key,
    this.onTap,
  });

  final ProfileTileVm vm;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Row(
      children: [
        SizedBox(
          width: 66,
          height: 60,
          child: ImagePreview.avatar(
            source: vm.avatar,
            cacheSize: const Size.fromRadius(20),
          ),
        ),
        Expanded(child: Text(vm.userName)),
      ],
    ),
  );
}
