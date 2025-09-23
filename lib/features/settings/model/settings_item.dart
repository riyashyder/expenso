class SettingsItem {
  final String title;
  final String? subtitle;
  final String? trailing;
  final bool isSwitch;
  bool switchValue;
  final Function? onTap;

  SettingsItem({
    required this.title,
    this.subtitle,
    this.trailing,
    this.isSwitch = false,
    this.switchValue = false,
    this.onTap,
  });
}
