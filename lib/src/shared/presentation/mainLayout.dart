import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainLayout extends StatelessWidget {
  final String title;
  final Widget child;
  const MainLayout({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true,),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Guest'),
              onTap: () {
                context.go('/');
                context.pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Login'),
              onTap: () {
                context.go('/login');
                context.pop();
              },
            ),
          ],
        ),
      ),
      body: child,
    );
  }
}
