import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.isWaiting, super.key});

  final bool isWaiting;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Progress Pal'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            const ShadSlider(
              initialValue: 33,
              max: 100,
            ),
            const ShadSeparator.horizontal(
              thickness: 4,
              margin: EdgeInsets.symmetric(horizontal: 20),
              radius: BorderRadius.all(Radius.circular(4)),
            ),
            ShadSwitchFormField(
              id: 'terms',
              initialValue: false,
              inputLabel: const Text('I accept the terms and conditions'),
              onChanged: (v) {},
              inputSublabel: const Text(
                'You agree to our Terms and Conditions',
              ),
              validator: (v) {
                if (!v) {
                  return 'You must accept the terms and conditions';
                }
                return null;
              },
            ),
            const ShadSeparator.horizontal(
              thickness: 4,
              margin: EdgeInsets.symmetric(horizontal: 20),
              radius: BorderRadius.all(Radius.circular(4)),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: const ShadTimePicker(
                trailing: Padding(
                  padding: EdgeInsets.only(left: 8, top: 14),
                  child: Icon(LucideIcons.clock4),
                ),
              ),
            ),

            ShadCalendar(
              selected: today,
              fromMonth: DateTime(today.year - 1),
              toMonth: DateTime(today.year, 12),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: const ShadDatePicker(),
            ),
            ShadTabs<String>(
              value: 'account',
              tabBarConstraints: const BoxConstraints(maxWidth: 400),
              contentConstraints: const BoxConstraints(maxWidth: 400),
              tabs: [
                ShadTab(
                  value: 'account',
                  content: ShadCard(
                    title: const Text('Account'),
                    description: const Text(
                      "Make changes to your account here. Click save when you're done.",
                    ),
                    footer: const ShadButton(child: Text('Save changes')),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 16),
                        ShadInputFormField(
                          label: const Text('Name'),
                          initialValue: 'Ale',
                        ),
                        const SizedBox(height: 8),
                        ShadInputFormField(
                          label: const Text('Username'),
                          initialValue: 'nank1ro',
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  child: const Text('Account'),
                ),
                ShadTab(
                  value: 'password',
                  content: ShadCard(
                    title: const Text('Password'),
                    description: const Text(
                      "Change your password here. After saving, you'll be logged out.",
                    ),
                    footer: const ShadButton(child: Text('Save password')),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        ShadInputFormField(
                          label: const Text('Current password'),
                          obscureText: true,
                        ),
                        const SizedBox(height: 8),
                        ShadInputFormField(
                          label: const Text('New password'),
                          obscureText: true,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  child: const Text('Password'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
