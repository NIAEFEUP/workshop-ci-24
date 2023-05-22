import 'package:cinescope/model/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:cinescope/view/general_page.dart';

class ProfilePage extends GeneralPage {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends GeneralPageState<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProfileData();
    });
  }

  Future<void> _loadProfileData() async {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    final profile = profileProvider.getProfile();
    _nameController.text = profile.name;
    _bioController.text = profile.bio;
  }

  @override
  Widget getTitle(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Text("Your Profile",
            textAlign: TextAlign.left, textScaleFactor: 2.2));
  }

  @override
  List<Widget> getBody(BuildContext context) {
    return [
      const SizedBox(height: 16),
      GestureDetector(
        onTap: _isEditing ? _selectImage : null,
        child: Consumer<ProfileProvider>(
          builder: (context, value, _) {
            final profile = value.getProfile();
            Widget avatar = profile.imageData != null
                ? CircleAvatar(
                    radius: 115,
                    backgroundImage: MemoryImage(profile.imageData!),
                  )
                : const CircleAvatar(
                    radius: 115,
                    backgroundImage: AssetImage(
                      "assets/profile-placeholder.png",
                    ),
                  );
            return avatar;
          },
        ),
      ),
      const SizedBox(height: 25),
      Consumer<ProfileProvider>(
        builder: (context, value, _) {
          final profile = value.getProfile();
          return _isEditing
              ? TextField(
                  maxLines: 1,
                  controller: _nameController,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Name",
                  ),
                )
              : Text(
                  profile.name.isNotEmpty ? profile.name : "What is your name?",
                  style: const TextStyle(
                      fontSize: 27, fontWeight: FontWeight.bold),
                );
        },
      ),
      const SizedBox(height: 8),
      Consumer<ProfileProvider>(
        builder: (context, value, _) {
          final profile = value.getProfile();
          return _isEditing
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
                    profile.bio.isNotEmpty
                        ? profile.bio
                        : "What do you want other people to know about you?",
                    style: const TextStyle(fontSize: 17),
                  ),
                );
        },
      ),
      Consumer<ProfileProvider>(
        builder: (context, value, _) {
          final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
          return _isEditing
              ? Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0XFFEC7873),
                          ),
                        ),
                        onPressed: () => _cancelEditing(profileProvider),
                        child: const Text("Cancel"),
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
                            const Color(0XFF2C666E),
                          ),
                        ),
                        onPressed: () => _saveChanges(profileProvider),
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
                    backgroundColor: MaterialStateProperty.all(
                      const Color(0XFF2C666E),
                    ),
                  ),
                  onPressed: _startEditing,
                  child: const Text("Edit"),
                );
        },
      ),
    ];
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;

    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    final profile = profileProvider.getProfile();
    final imageData = await pickedImage.readAsBytes();
    profile.imageData = imageData;
    profileProvider.rerender();
  }

  void _startEditing() {
    setState(() {
      _isEditing = true;
    });
  }

  void _cancelEditing(ProfileProvider profileProvider) {
    final profile = profileProvider.getProfile();
    setState(() {
      _isEditing = false;
      _nameController.text = profile.name;
      _bioController.text = profile.bio;
    });
  }

  void _saveChanges(ProfileProvider profileProvider) {
    final profile = profileProvider.getProfile();
    if (_nameController.text.isEmpty || _bioController.text.isEmpty) {
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        message: "Please fill all the fields",
        duration: const Duration(seconds: 3),
        backgroundColor: const Color(0xFFD7CCCF),
        messageColor: Colors.black,
      ).show(context);
      return;
    }

    setState(() {
      profile.bio = _bioController.text;
      profile.name = _nameController.text;
      profileProvider.saveProfile(profile);
      _isEditing = false;
    });
  }
}
