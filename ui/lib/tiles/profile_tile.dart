import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../image/avatar.dart';
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
  const ProfileTile({required this.vm, this.onTap, super.key});

  final ProfileTileVm vm;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    borderRadius: BorderRadius.circular(12),
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        spacing: 8,
        children: [
          Avatar(
            source: vm.avatar,
            size: const Size.fromRadius(16),
          ),
          Flexible(child: Text(vm.userName)),
        ],
      ),
    ),
  );
}
