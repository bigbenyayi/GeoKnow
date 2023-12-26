import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String _title;

  const CustomAppBar({
    super.key,
    required String title,
  }) : _title = title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark, // Android
        statusBarBrightness: Brightness.light, // iOS
      ),
      title: Text(
        _title,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w900,
          fontSize: 30.0,
        ),
      ),
      backgroundColor: Colors.transparent,
      titleSpacing: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_rounded, color: Theme.of(context).primaryColor),
        padding: EdgeInsets.zero,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }
}
