import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('More'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MoreListTile(
              icon: Icons.settings,
              title: 'Settings',
              onTap: () {
                // Use the MoreNavigator to navigate to the settings screen
                Provider.of<MoreNavigator>(context, listen: false)
                    .navigateToSettingsScreen(context);
              },
            ),
            MoreListTile(
              icon: Icons.info,
              title: 'About Us',
              onTap: () {
                // Use the MoreNavigator to navigate to the about us screen
                Provider.of<MoreNavigator>(context, listen: false)
                    .navigateToAboutUsScreen(context);
              },
            ),
            MoreListTile(
              icon: Icons.help,
              title: 'Help',
              onTap: () {
                // Use the MoreNavigator to navigate to the help screen
                Provider.of<MoreNavigator>(context, listen: false)
                    .navigateToHelpScreen(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MoreListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function()? onTap;

  MoreListTile({
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}

class MoreNavigator with ChangeNotifier {
  void navigateToSettingsScreen(BuildContext context) {
    // Navigate to the settings screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsScreen()),
    );
  }

  void navigateToAboutUsScreen(BuildContext context) {
    // Navigate to the about us screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AboutUsScreen()),
    );
  }

  void navigateToHelpScreen(BuildContext context) {
    // Navigate to the help screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HelpScreen()),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: (Text(
        'Settings Screen',
        style: TextStyle(
          fontSize: 20,
        ),
      )),
    );
  }
}

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('About Us'),
        ),
        body: (Text(
          'About Us Screen',
          style: TextStyle(
            fontSize: 20,
          ),
        )) // Your about us screen content
        );
  }
}

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Help'),
        ),
        body: Text(
          'Help Screen',
          style: TextStyle(
            fontSize: 20,
          ),
        ));
  }
}
