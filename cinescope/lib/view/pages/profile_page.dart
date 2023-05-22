import 'package:cinescope/model/providers/profile_provider.dart';
import 'package:cinescope/view/general_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cinescope/view/pages/login_page.dart';

class ProfilePage extends GeneralPage {
  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState extends GeneralPageState<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  bool _isEditing = false;

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
                  radius: 115,
                  backgroundImage: MemoryImage(
                    profile.imageData!,
                  ))
              : const CircleAvatar(
                  radius: 115,
                  backgroundImage: AssetImage(
                    "assets/profile-placeholder.png",
                  ));

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              _isEditing
                  ? GestureDetector(
                      onTap: () async {
                        final picker = ImagePicker();
                        final file =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (file == null) return;
                        profile.imageData = await file.readAsBytes();
                        value.rerender();
                      },
                      child: avatar,
                    )
                  : avatar,
              const SizedBox(height: 16),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: _isEditing
                      ? TextField(
                          maxLines: 1,
                          controller: _nameController,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), labelText: "Name"))
                      : Text(
                          profile.name.isEmpty
                              ? "What is your name?"
                              : profile.name,
                          style: const TextStyle(
                              fontSize: 27, fontWeight: FontWeight.bold),
                        )),
              const SizedBox(height: 8),
              _isEditing
                  ? SizedBox(
                      height: 220,
                      child: TextField(
                        maxLines: null,
                        controller: _bioController,
                        style: const TextStyle(fontSize: 16),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Bio",
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 250,
                      child: Text(
                        profile.bio.isEmpty
                            ? "What do you want other people to know about you?"
                            : profile.bio,
                        style: const TextStyle(fontSize: 17),
                      )),
              _isEditing
                  ? Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(color: Colors.white),
                              ),
                            )),
                            onPressed: () {
                              setState(() {
                                _isEditing = false;
                                _nameController.text = profile.name;
                                _bioController.text = profile.bio;
                              });
                            },
                            child: const Text(
                              "Discard Changes",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 242, 242, 242)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0XFF2C666E)),
                            ),
                            onPressed: () {
                              setState(() {
                                if (_nameController.text.isEmpty ||
                                    _bioController.text.isEmpty) {
                                  Flushbar(
                                    flushbarPosition: FlushbarPosition.TOP,
                                    message: "Please fill all the fields",
                                    duration: const Duration(seconds: 3),
                                    backgroundColor: const Color(0xFFD7CCCF),
                                    messageColor: Colors.black,
                                  ).show(context);
                                  return;
                                }
                                profile.bio = _bioController.text;
                                profile.name = _nameController.text;
                                value.saveProfile(profile);
                                _isEditing = false;
                              });
                            },
                            child: const Text("Save Changes"),
                          ),
                        ),
                      ],
                    )
                  : TextButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0XFF2C666E)),
                      ),
                      onPressed: () {
                        setState(() {
                          _isEditing = true;
                        });
                      },
                      child: const Text("Edit"),
                    )
            ],
          );
        },
      )
    ];
  }

  @override
  Widget getTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Row(
        children: [
          const Text(
            "Your Profile",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
