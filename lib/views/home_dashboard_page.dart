import 'package:flutter/material.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';

class HomeDashboardPage extends StatefulWidget {
  const HomeDashboardPage({super.key});

  @override
  State<HomeDashboardPage> createState() => _HomeDashboardPageState();
}

class _HomeDashboardPageState extends State<HomeDashboardPage> {
  String? selectedProject;
  @override
  Widget build(BuildContext context) {
    final List<String> dummyFavouritesMenuList = [
      'Dropdowns',
      'Branches',
      'Project 5',
    ];
    final List<String> dummyFavouriteProjectsList = [
      'CRM Redesign',
      'Marketing Site Revamp',
      'Internal Tools',
      'Mobile App UI',
      'Food Delivery System',
      'VsCode',
      'Android Studio',
      'Postman',
    ];

    final List<String> dummyNotificationsList = [
      'New user registered',
      'Password changed successfully',
      'Project deadline extended',
      'Database backup completed',
      'New message from admin',
      'Weekly summary is ready',
      'Role permissions updated',
      'Server maintenance scheduled',
      'New document uploaded',
      'Task "UI Design" marked complete',
      'Login from new device detected',
      'Zip code list updated',
      'New feedback received',
      'Side menu updated',
      'System settings changed',
    ];

    // final List<Map<String, dynamic>> dummyConversations = [];

    // final List<String> dummyMessages = [
    //   "Hi there!",
    //   "Hello, how are you?",
    //   "I'm good, thanks! What about you?",
    //   "Doing great, working on a Flutter app.",
    //   "That's awesome!",
    // ];
    final List<Map<String, dynamic>> dummyConversations = [
      {
        'project': 'CRM Redesign',
        'messages': [
          "Hey team, let's update the dashboard layout.",
          "Noted! Will push a design draft by tomorrow.",
          "Awesome, looking forward to it.",
        ],
      },
      {
        'project': 'Marketing Site Revamp',
        'messages': [
          "Have we finalized the homepage banner text?",
          "Still reviewing the copy suggestions.",
          "Let's finalize by EOD.",
        ],
      },
      {
        'project': 'Internal Tools',
        'messages': [
          "Please log today's API latency reports.",
          "Reports have been uploaded to the dashboard.",
          "Perfect, thanks!",
        ],
      },
      {
        'project': 'Mobile App UI',
        'messages': [
          "Can we use the new icon set for v2?",
          "Yes, adding it to Figma now.",
          "Nice! Let’s aim to complete by this week.",
        ],
      },
      {
        'project': 'Food Delivery System',
        'messages': [
          "Rider tracking not updating in real time.",
          "Investigating the Firebase stream issue.",
          "Deploying a fix now.",
        ],
      },
      {
        'project': 'VsCode',
        'messages': [
          "Extensions syncing is buggy again.",
          "It’s a known issue, waiting on patch 1.83.2.",
          "Okay, tracking for updates.",
        ],
      },
      {
        'project': 'Android Studio',
        'messages': [
          "Memory usage spikes after build.",
          "Try clearing the Gradle cache and rebuilding.",
          "Worked. Thanks!",
        ],
      },
      {
        'project': 'Postman',
        'messages': [
          "Need to organize shared collections.",
          "Agreed. Let’s clean up unused folders too.",
          "Scheduled it for Friday.",
        ],
      },
    ];

    //  selectedProject = 'CRM Redesign';
    final projectConversation = dummyConversations.firstWhere(
      (element) => element['project'] == selectedProject,
      orElse: () => {'project': selectedProject, 'messages': []},
    );
    final messages = projectConversation['messages'];

    return LayoutBuilder(
      builder: (context, constraits) {
        final double screenHeight = constraits.maxHeight;
        final double screenWidth = constraits.maxWidth;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Favourites Menu, Projects and Message Box
            Container(
              height: screenHeight,
              width: screenWidth * 0.45,
              decoration: BoxDecoration(),
              child: Column(
                children: [
                  // Column child row
                  SizedBox(
                    height: screenHeight * 0.45,
                    child: Row(
                      children: [
                        // Favourites Menu
                        Container(
                          height: screenHeight * 0.5,
                          width: screenWidth * 0.20,
                          decoration: BoxDecoration(),
                          child: Column(
                            children: [
                              _buildMenuTitle(
                                icon: Icons.star_outline,
                                title: 'Favourites Menu',
                              ),
                              _buildListItems(
                                itemsList: dummyFavouritesMenuList,
                              ),
                            ],
                          ),
                        ),
                        VerticalDivider(
                          color: AppColors.primaryGreen,
                          thickness: 1,
                          width: 20,
                        ),
                        // Favourite Projects
                        Container(
                          height: screenHeight * 0.5,
                          width: screenWidth * 0.20,
                          decoration: BoxDecoration(),
                          child: Column(
                            children: [
                              _buildMenuTitle(
                                icon: Icons.folder_open,
                                title: 'Favourite Projects',
                              ),
                              _buildListItems(
                                itemsList: dummyFavouriteProjectsList,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: AppColors.primaryGreen, thickness: 1),
                  // Message Box
                  Container(
                    height: screenHeight * 0.45,
                    decoration: BoxDecoration(),
                    child: Column(
                      children: [
                        _buildMenuTitle(
                          icon: Icons.mail_outline,
                          title: 'Message Box',
                        ),
                        SizedBox(
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Projects',
                                  style: TextStyle(
                                    color: AppColors.darkGreenText,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: screenWidth * 0.15,
                                    height: screenHeight * 0.37,
                                    child: Column(
                                      children: [
                                        _buildListItems(
                                          itemsList: dummyFavouriteProjectsList,
                                          showIcon: false,
                                          itemOpacity: .1,
                                          onItemTap: (String projectName) {
                                            setState(() {
                                              selectedProject = projectName;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.37,
                                    child: VerticalDivider(
                                      color: AppColors.primaryGreen,
                                      thickness: 1,
                                      width: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.25,
                                    height: screenHeight * 0.37,
                                    child: Column(
                                      children: [
                                        // Message list
                                        Expanded(
                                          child: ListView.builder(
                                            reverse:
                                                true, // To show latest message at the bottom
                                            padding: const EdgeInsets.all(10),
                                            itemCount: messages.length,
                                            itemBuilder: (context, index) {
                                              final message = messages[index];

                                              // final message =
                                              //     projectConversation[dummyMessages
                                              //             .length -
                                              //         1 -
                                              //         index]; // reverse logic
                                              // final isSender =
                                              //     index % 2 ==
                                              //     0; // Alternate sender

                                              return Align(
                                                alignment:
                                                    // isSender
                                                    //     ? Alignment.centerRight
                                                    //     :
                                                    Alignment.centerLeft,
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                      ),
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 8,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        // isSender
                                                        //     ? Colors.blue[100]
                                                        //     :
                                                        Colors.grey[300],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                  child: Text(message),
                                                ),
                                              );
                                            },
                                          ),
                                        ),

                                        // Input box
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                color: Colors.grey.shade300,
                                              ),
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        "Type a message...",
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.send,
                                                  color:
                                                      AppColors.darkGreenIcon,
                                                ),
                                                onPressed: () {
                                                  // handle send
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            VerticalDivider(
              color: AppColors.primaryGreen,
              thickness: 1,
              width: 20,
            ),
            // Notifications
            Container(
              height: screenHeight,
              width: screenWidth * 0.45,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(),
              child: Column(
                children: [
                  _buildMenuTitle(
                    icon: Icons.notifications_none,
                    title: 'Notifications',
                  ),
                  _buildListItems(
                    itemsList: dummyNotificationsList,
                    icon: Icons.notifications,
                    iconColor: AppColors.grey,
                    tileColor: AppColors.white,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // Menu title
  Widget _buildMenuTitle({required IconData icon, required String title}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.darkGreenIcon),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  color: AppColors.darkGreenText,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Divider(),
        ],
      );

  // List of values
  Widget _buildListItems({
    required List<String> itemsList,
    bool showIcon = true,
    double itemOpacity = 0.2,
    IconData icon = Icons.star,
    Color iconColor = AppColors.yellow,
    Color tileColor = AppColors.background,
    ValueChanged<String>? onItemTap,
  }) => Expanded(
    child: ListView.builder(
      padding: EdgeInsets.only(top: 10),
      itemCount: itemsList.length,

      itemBuilder: (context, index) {
        final item = itemsList[index];
        return Container(
          margin: EdgeInsets.only(bottom: 6),
          decoration: BoxDecoration(
            color: tileColor.withValues(alpha: itemOpacity),
          ),
          child: ListTile(
            onTap: () {
              if (onItemTap != null) {
                onItemTap(item);
              }
            },
            leading:
                showIcon ? Icon(icon, size: 20, color: iconColor) : SizedBox(),
            title: Text(item, style: TextStyle(fontSize: 13)),
          ),
        );
      },
    ),
  );
}
