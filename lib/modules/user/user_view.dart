import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/api/controllers/user_controller.dart';
import 'package:inventoryapp/app/constants/app_color.dart';
import 'package:inventoryapp/app/constants/app_spacing.dart';
import 'package:inventoryapp/app/constants/app_widget_size.dart';
import 'package:inventoryapp/app/widgets/circle_icon_button.dart';
import 'package:inventoryapp/app/widgets/item_card_widget.dart';
import 'package:inventoryapp/app/widgets/text_background.dart';
import 'package:inventoryapp/app/widgets/title_text_widget.dart';
import 'package:inventoryapp/modules/user/widgets/user_form_bottomsheet.dart';

class UserView extends StatelessWidget {
  UserView({super.key});

  final UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          UserFormBottomSheet.open(); // no user passed → create mode
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          _search(),
          _userList(context),
        ],
      ),
    );
  }

  Widget _search(){
    return Padding(
      padding: EdgeInsets.all(AppSpacing.paddingM),
      child: TextField(
        decoration: const InputDecoration(
          hintText: "Search users...",
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (val) {
          controller.searchQuery.value = val;
          controller.loadUsers();
        },
      ),
    );
  }

  Widget _userList(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(AppSpacing.paddingM),
        decoration: const BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleTextWidget(text: "Team Members"),
                GestureDetector(
                  onTap: () {
                    _showSortDialog(context);
                  },
                  child: const Icon(Icons.filter_alt, color: AppColors.primary),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.users.isEmpty) {
                  return const Center(child: Text("No users found"));
                }

                return RefreshIndicator(
                  onRefresh: controller.loadUsers,
                  child: ListView.builder(
                    itemCount: controller.users.length,
                    itemBuilder: (context, index) {
                      final user = controller.users[index];
                      return ItemCardWidget(
                        title: user.name.toString(),
                        subtitleWidget: TextBackground(
                          text: user.role,
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                          borderRadius: 4,
                        ),
                        trailing: Row(
                          children: [
                            CircleIconButton(
                                icon: Icons.edit,
                                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                                size: AppWidgetSize.iconSM,
                                onTap: (){
                                  UserFormBottomSheet.open(user: user);
                                }
                            ),
                            SizedBox(width: AppSpacing.paddingS),
                            CircleIconButton(
                                icon: Icons.delete,
                                backgroundColor: Theme.of(context).colorScheme.error.withOpacity(0.7),
                                size: AppWidgetSize.iconSM,
                                onTap: (){controller.removeUser(user.id);}
                            ),
                          ],
                        ),
                        icon: Icons.person_outline,
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _showSortDialog(BuildContext context) {
    Get.defaultDialog(
      title: "Sort Product",
      titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w700
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ItemCardWidget(
            title: "Role: Admin",
            icon: Icons.arrow_downward,
            showArrow: false,
            onTap: () {
              controller.sortField.value = "role";
              controller.loadUsers();
              Get.back();
            },
          ),
          ItemCardWidget(
            title: "Role: Staff",
            icon: Icons.arrow_upward,
            showArrow: false,
            onTap: () {
              controller.sortField.value = "-role";
              controller.loadUsers();
              Get.back();
            },
          ),
          ItemCardWidget(
            title: "Name: A-Z",
            icon: Icons.arrow_downward,
            showArrow: false,
            onTap: () {
              controller.sortField.value = "name";
              controller.loadUsers();
              Get.back();
            },
          ),
          ItemCardWidget(
            title: "Name: Z-A",
            icon: Icons.arrow_upward,
            showArrow: false,
            onTap: () {
              controller.sortField.value = "-name";
              controller.loadUsers();
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}