import 'package:flutter/material.dart';
import 'package:sw32_mad_project/components/widgets/rounded_button.dart';
import 'package:sw32_mad_project/model/custom_padding.dart';
import 'package:sw32_mad_project/screens/about_us_screen.dart';
import 'package:sw32_mad_project/screens/privacy_policy_screen.dart';
import 'package:sw32_mad_project/styles/colors.dart';
import 'package:sw32_mad_project/styles/text_styles.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer(
      {Key? key, required this.onFvr8Selected, required this.isFvvr8Selected})
      : super(key: key);
  final Function() onFvr8Selected;
  final bool isFvvr8Selected;
  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  final CustomPadding customPadding = CustomPadding();
  int rating = 0;
  bool isLightTheme = false;
  bool isFvr8Selected = false;
  @override
  void initState() {
    super.initState();
    isFvr8Selected = widget.isFvvr8Selected;
  }

  @override
  Widget build(BuildContext context) {
    IconData icon =
        isLightTheme ? Icons.light_mode_outlined : Icons.dark_mode_outlined;
    return Drawer(
      child: Material(
        child: ListView(
          padding: customPadding.symmetricPadding(20, 0),
          children: [
            const SizedBox(height: 50),
            ListTile(
              title: Text(
                isLightTheme ? 'Light Mode' : 'Dark Mode',
                style: kTextFieldTextStyle,
              ),
              leading: Icon(icon, size: 30),
              trailing: Switch(
                value: isLightTheme,
                onChanged: (changedTheme) {
                  setState(() {
                    isLightTheme = changedTheme;
                  });
                },
              ),
            ),
            buildMenuItem(
              text: 'Favorites',
              icon: isFvr8Selected ? Icons.favorite : Icons.favorite_outline,
              iconColor: isFvr8Selected ? Colors.red : Colors.white,
              onTap: () {
                widget.onFvr8Selected.call();
                Navigator.pop(context);
              },
            ),
            buildMenuItem(
                text: 'Privacy',
                icon: Icons.privacy_tip_outlined,
                onTap: () async {
                  final result = await Navigator.pushNamed(
                      context, PrivacyPolicyScreen.routeID);
                  if (result == null) Navigator.pop(context);
                }),
            buildMenuItem(
                text: 'About',
                icon: Icons.help_outline,
                onTap: () async {
                  final result =
                      await Navigator.pushNamed(context, AboutUsScreen.routeID);
                  if (result == null) Navigator.pop(context);
                }),
            buildTextListTile(text: 'Rate us'),
            Row(
              children: List.generate(
                5,
                (index) => IconButton(
                  onPressed: () {
                    setState(() {
                      rating = index + 1;
                    });
                  },
                  icon: Icon(
                    index < rating ? Icons.star : Icons.star_outline,
                    color: index < rating ? Colors.amber : Colors.white,
                  ),
                ),
              ),
            ),
            buildTextListTile(text: '$rating stars'),
            Center(
              child: RoundedButton(
                color: kLightPink,
                buttonText: 'Clear rating',
                onPressed: () {
                  setState(() {
                    rating = 0;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Visibility(
              visible: rating == 5,
              child: const Text(
                'Thank You for giving us 5 stars:)',
                style: kTextFieldTextStyle,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  ListTile buildTextListTile({required String text}) {
    return ListTile(
      title: Text(text, style: kTextFieldTextStyle),
    );
  }

  Widget buildMenuItem({
    required String text,
    IconData? icon,
    Color iconColor = Colors.white,
    VoidCallback? onTap,
  }) {
    return ListTile(
      title: Text(
        text,
        style: kTextFieldTextStyle,
      ),
      leading: Icon(icon, size: 30, color: iconColor),
      onTap: onTap ?? () {},
    );
  }
}
