import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sws_crm_v5/models/dropdown_model.dart';
import 'package:sws_crm_v5/utils/app_colors.dart';
import 'package:sws_crm_v5/view%20models/super_admin_drop_down_page_view_model.dart';
import 'package:sws_crm_v5/widgets/button_widget.dart';
import 'package:sws_crm_v5/widgets/dialog_box_widget.dart';
import 'package:sws_crm_v5/widgets/new_button.dart';
import 'package:sws_crm_v5/widgets/stream_builder_widget.dart';
import 'package:sws_crm_v5/widgets/text_field_widget.dart';

class SuperAdminDropdownsPage extends StatefulWidget {
  const SuperAdminDropdownsPage({super.key});

  @override
  State<SuperAdminDropdownsPage> createState() =>
      _SuperAdminDropdownsPageState();
}

class _SuperAdminDropdownsPageState extends State<SuperAdminDropdownsPage> {
  final _formKey = GlobalKey<FormState>();
  final _dropdownNameController = TextEditingController();
  final _dropdownTypeController = TextEditingController();
  final List<String> _dropdownTypeList = [];
  int selectedDropdownIndex = 0;

  String? selectedType;
  List<String> currentDropdowns = [];

  void _onTypeSelected(String type, List<String> dropdowns) {
    setState(() {
      selectedType = type;
      currentDropdowns = dropdowns;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final viewModel = Provider.of<SuperAdminDropDownPageViewModel>(
        context,
        listen: false,
      );
      viewModel.fetchAllDropdownsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SuperAdminDropDownPageViewModel>(
      context,
      listen: false,
    );
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double screenHeight = constraints.maxHeight;
          final double screenWidth = constraints.maxWidth;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dropdowns',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                  Row(
                    children: [
                      NewButton(
                        title: 'Add dropdown',
                        icon: Icons.add,
                        ontap: () {
                          DialogBoxWidget.show(
                            parentContext: context,
                            title: 'Add New Dropdown',
                            isBackOnSave: false,
                            dialogBoxHeight: 500,

                            content: StatefulBuilder(
                              builder: (context, setState) {
                                return Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextFieldWidget(
                                        title: 'Dropdown',
                                        controller: _dropdownNameController,

                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Dropdown name is required';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Type',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryGreen,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      // Type Input + Add Button
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              controller:
                                                  _dropdownTypeController,
                                              validator: (value) {
                                                if (_dropdownTypeList.isEmpty) {
                                                  return 'Give at least one dropdown type';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                // labelText: 'Add Type',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                suffixIcon: PopupMenuButton<
                                                  String
                                                >(
                                                  icon: Icon(
                                                    Icons.arrow_drop_down,
                                                  ),
                                                  constraints: BoxConstraints(
                                                    maxHeight: 300,
                                                  ),
                                                  tooltip:
                                                      'Select from existing types',
                                                  onSelected: (
                                                    String selected,
                                                  ) {
                                                    if (!_dropdownTypeList
                                                        .contains(selected)) {
                                                      setState(() {
                                                        _dropdownTypeList.add(
                                                          selected,
                                                        );
                                                      });
                                                    }
                                                  },
                                                  itemBuilder: (
                                                    BuildContext context,
                                                  ) {
                                                    return viewModel.dropdownsList.map((
                                                      type,
                                                    ) {
                                                      return PopupMenuItem<
                                                        String
                                                      >(
                                                        child: StatefulBuilder(
                                                          builder: (
                                                            context,
                                                            localSetState,
                                                          ) {
                                                            final isChecked =
                                                                _dropdownTypeList
                                                                    .contains(
                                                                      type,
                                                                    );
                                                            return InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  if (isChecked) {
                                                                    _dropdownTypeList
                                                                        .remove(
                                                                          type,
                                                                        );
                                                                  } else {
                                                                    _dropdownTypeList
                                                                        .add(
                                                                          type,
                                                                        );
                                                                  }
                                                                });
                                                                localSetState(
                                                                  () {},
                                                                );
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  Checkbox(
                                                                    value:
                                                                        isChecked,
                                                                    onChanged: (
                                                                      _,
                                                                    ) {
                                                                      setState(() {
                                                                        if (isChecked) {
                                                                          _dropdownTypeList.remove(
                                                                            type,
                                                                          );
                                                                        } else {
                                                                          _dropdownTypeList.add(
                                                                            type,
                                                                          );
                                                                        }
                                                                      });
                                                                      localSetState(
                                                                        () {},
                                                                      );
                                                                    },
                                                                  ),
                                                                  Text(type),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    }).toList();
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          ButtonWidget(
                                            title: 'Add',
                                            horizontalPadding: 20,
                                            verticalPadding: 10,

                                            onTap: () {
                                              final type =
                                                  _dropdownTypeController.text
                                                      .trim();
                                              if (type.isNotEmpty &&
                                                  !_dropdownTypeList.contains(
                                                    type,
                                                  )) {
                                                setState(() {
                                                  _dropdownTypeList.add(type);
                                                  if (!viewModel.dropdownsList
                                                      .contains(type)) {
                                                    viewModel.dropdownsList.add(
                                                      type,
                                                    );
                                                  }
                                                  _dropdownTypeController
                                                      .clear();
                                                });
                                              }
                                            },
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 12),

                                      // Show List as Chips
                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 4,
                                        children:
                                            _dropdownTypeList.map((type) {
                                              return Chip(
                                                label: Text(type),
                                                deleteIcon: const Icon(
                                                  Icons.close,
                                                ),
                                                onDeleted: () {
                                                  setState(() {
                                                    _dropdownTypeList.remove(
                                                      type,
                                                    );
                                                  });
                                                },
                                              );
                                            }).toList(),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            onSave: (dialogBoxContext) async {
                              final viewModel =
                                  Provider.of<SuperAdminDropDownPageViewModel>(
                                    context,
                                    listen: false,
                                  );
                              if (_formKey.currentState!.validate()) {
                                await viewModel.addNewDropdown(
                                  parentContext: context,
                                  dialogBoxContext: dialogBoxContext,
                                  dropdownName: _dropdownNameController.text,
                                  dropdownType: _dropdownTypeList,
                                );
                                _dropdownNameController.clear();
                                _dropdownTypeController.clear();
                                _dropdownTypeList.clear();
                              }
                            },
                          );
                        },
                      ),

                      // ButtonWidget(
                      //   title: 'Add User',
                      //   isIconShown: true,
                      //   onTap: () {},
                      //   horizontalPadding: 20,
                      //   verticalPadding: 10,
                      // ),
                      SizedBox(width: 20),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  /// LEFT SIDE: Dropdown Types
                  Container(
                    // color: AppColors.lightGreen2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15),

                        // const Padding(
                        //   padding: EdgeInsets.all(16.0),
                        //   child: Text(
                        //     'Dropdowns',
                        //     style: TextStyle(
                        //       fontSize: 15,
                        //       fontWeight: FontWeight.bold,
                        //       color: AppColors.primaryGreen,
                        //     ),
                        //   ),
                        // ),
                        SizedBox(width: screenWidth * 0.2, child: Divider()),
                        SizedBox(
                          height: screenHeight * 0.8,
                          width: screenWidth * 0.2,
                          child: StreamBuilderWidget<List<DropdownModel>>(
                            stream: viewModel.fetchDropdownsList(
                              parentContext: context,
                            ),

                            builder: (context, dropdowns) {
                              return ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                itemCount: dropdowns.length,
                                itemBuilder: (context, index) {
                                  final dropdown = dropdowns[index];
                                  if (dropdowns.isNotEmpty &&
                                      selectedType == null) {
                                    Future.microtask(() {
                                      _onTypeSelected(
                                        dropdowns.first.type,
                                        dropdowns.first.dropdowns,
                                      );
                                    });
                                  }

                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    child: ListTile(
                                      tileColor:
                                          selectedType == dropdown.type
                                              ? AppColors.primaryGreen
                                                  .withValues(alpha: .2)
                                              : Colors.white,
                                      title: Text(dropdown.type),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      onTap:
                                          () => _onTypeSelected(
                                            dropdown.type,
                                            dropdown.dropdowns,
                                          ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.8,
                    child: VerticalDivider(
                      width: 20,
                      color: AppColors.greenBorder,
                    ),
                  ),

                  /// RIGHT SIDE: Dropdowns Under Selected Type
                  Container(
                    height: screenHeight * 0.8,
                    width: screenWidth * 0.7,
                    padding: const EdgeInsets.all(20),
                    color: Colors.white,
                    child:
                    // selectedType == null
                    //     ? const Center(
                    //       child: Text(
                    //         'Select a dropdown type to view dropdowns',
                    //         style: TextStyle(fontSize: 16),
                    //       ),
                    //     )
                    //     :
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$selectedType',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryGreen,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.7, child: Divider()),
                        const SizedBox(height: 10),
                        currentDropdowns.isEmpty
                            ? const Text("No dropdowns found.")
                            : Expanded(
                              child: ListView.separated(
                                itemCount: currentDropdowns.length,
                                separatorBuilder: (context, index) {
                                  return Divider();
                                },
                                itemBuilder: (context, index) {
                                  return Text(
                                    currentDropdowns[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                            ),

                        // Wrap(
                        //   spacing: 10,
                        //   runSpacing: 10,
                        //   children:
                        //       currentDropdowns
                        //           .map(
                        //             (item) => Chip(
                        //               label: Text(item),
                        //               backgroundColor:
                        //                   AppColors.lightGreen2,
                        //             ),
                        //           )
                        //           .toList(),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
