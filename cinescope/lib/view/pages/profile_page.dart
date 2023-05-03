import 'package:cinescope/model/providers/profile_provider.dart';
import 'package:cinescope/view/general_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

class ProfilePage extends GeneralPage {
  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState extends GeneralPageState<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  List<Widget> getBody(BuildContext context) {
    return [
      Consumer<ProfileProvider>(
        builder: (context, value, _) {
          final profile = value.getProfile();
          _nameController.text = profile.name;
          _bioController.text = profile.bio;
          Widget avatar = profile.imageData != null
              ? CircleAvatar(
                  radius: 100,
                  backgroundImage: MemoryImage(
                    profile.imageData!,
                  ))
              : const CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage(
                    "assets/profile-placeholder.png",
                  ));
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              avatar,
              const SizedBox(height: 16),
              TextField(
                  maxLines: 1,
                  controller: _nameController,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                  decoration:
                      const InputDecoration(hintText: "Insert your title....")),
              const SizedBox(height: 8),
              TextField(
                maxLines: null,
                controller: _bioController,
                style: const TextStyle(fontSize: 16),
                decoration:
                    const InputDecoration(hintText: "Insert your bio...."),
              ),
              const SizedBox(height: 20),
              TextButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0XFF2C666E))),
                  onPressed: () async {
                    final picker = ImagePicker();
                    final file =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (file == null) return;
                    profile.imageData = await file.readAsBytes();
                    value.rerender();
                  },
                  child: const Text("Add image")),
              const SizedBox(height: 40),
              TextButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0XFF2C666E))),
                  onPressed: () async {
                    profile.bio = _bioController.text;
                    profile.name = _nameController.text;
                    value.saveProfile(profile);
                  },
                  child: const Text("Edit profile")),
            ],
          );
        },
      )
    ];
  }

  @override
  Widget getTitle(BuildContext context) {
    return const Text(
      "Your Profile",
      textAlign: TextAlign.left,
      textScaleFactor: 2.2,
    );
  }
}
