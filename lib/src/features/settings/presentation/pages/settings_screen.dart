import 'package:buku_tamu/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:buku_tamu/src/features/auth/presentation/bloc/auth_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsPage2State();
}

class _SettingsPage2State extends State<SettingsScreen> {
  Future<void> logout() async {
    context.read<AuthBloc>().add(LogoutEvent());
    context.go('/login');
  }

  bool _isDark = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              _SingleSection(
                title: "General",
                children: [
                  _CustomListTile(
                    title: "Dark Mode",
                    icon: Icons.dark_mode_outlined,
                    trailing: Switch(
                      value: _isDark,
                      onChanged: (value) {
                        setState(() {
                          _isDark = value;
                        });
                      },
                    ),
                  ),
                  const _CustomListTile(
                    title: "Notifications",
                    icon: Icons.notifications_none_rounded,
                  ),
                  const _CustomListTile(
                    title: "Security Status",
                    icon: CupertinoIcons.lock_shield,
                  ),
                ],
              ),
              const Divider(),
              const _SingleSection(
                title: "Organization",
                children: [
                  _CustomListTile(
                    title: "Profile",
                    icon: Icons.person_outline_rounded,
                  ),
                  _CustomListTile(
                    title: "Messaging",
                    icon: Icons.message_outlined,
                  ),
                  _CustomListTile(title: "Calling", icon: Icons.phone_outlined),
                  _CustomListTile(
                    title: "People",
                    icon: Icons.contacts_outlined,
                  ),
                  _CustomListTile(
                    title: "Calendar",
                    icon: Icons.calendar_today_rounded,
                  ),
                ],
              ),
              const Divider(),
              _SingleSection(
                children: [
                  _CustomListTile(
                    title: "Help & Feedback",
                    icon: Icons.help_outline_rounded,
                  ),
                  _CustomListTile(
                    title: "About",
                    icon: Icons.info_outline_rounded,
                  ),
                  _CustomListTile(
                    title: "Sign out",
                    icon: Icons.exit_to_app_rounded,
                    onTap: logout,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback? onTap;
  const _CustomListTile({
    required this.title,
    required this.icon,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  const _SingleSection({this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        Column(children: children),
      ],
    );
  }
}
