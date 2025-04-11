// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_f_n_fantastictimetodecide_3286/cubit/my_question_cubit/my_question_cubit.dart';
import 'package:ios_f_n_fantastictimetodecide_3286/cubit/wheel_cubit/wheel_cubit.dart';
import 'package:ios_f_n_fantastictimetodecide_3286/pages/wheel_spin_screen.dart';

class CreateWheelScreen extends StatefulWidget {
  const CreateWheelScreen({super.key});

  @override
  State<CreateWheelScreen> createState() => _CreateWheelScreenState();
}

class _CreateWheelScreenState extends State<CreateWheelScreen> {
  final _nameOfWheelController = TextEditingController();
  final List<TextEditingController> _optionControllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  bool _isFilled() {
    return _nameOfWheelController.text.trim().isNotEmpty &&
        _optionControllers.length >= 2 &&
        _optionControllers[0].text.trim().isNotEmpty &&
        _optionControllers[1].text.trim().isNotEmpty;
  }

  void _checkForm() => setState(() {});

  @override
  void initState() {
    super.initState();
    _nameOfWheelController.addListener(_checkForm);
    for (var controller in _optionControllers) {
      controller.addListener(_checkForm);
    }
  }

  Future<bool> _onWillPop() async {
    final shouldLeave = await showDialog<bool>(
      context: context,
      builder: (_) => _exitConfirmationDialog(),
    );
    return shouldLeave ?? false;
  }

  AlertDialog _exitConfirmationDialog() {
    return AlertDialog(
      backgroundColor: Color(0xFF8D1527),
      title: Text('Abandon Your Wheel?', style: TextStyle(color: Colors.white)),
      content: Text(
        'You`ve built a magnificent wheel of wonder — are you sure you want to leave it behind without saving? The circus cries for every lost spin...',
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(
            'Leave',
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(
            'Stay',
            style: TextStyle(color: Color(0xFFF1B016), fontSize: 18.0),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              BackButton(
                color: Colors.white.withOpacity(0.5),
                onPressed: () async {
                  final shouldPop = await _onWillPop();
                  if (shouldPop) {
                    Navigator.pop(context);
                  }
                },
              ),
              Text(
                'Back',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                _buildField("Name of Wheel", 'Name', _nameOfWheelController),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Options",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Row(
                      children: [
                        if (_optionControllers.length > 2)
                          IconButton(
                            onPressed: () {
                              setState(() {
                                final removed = _optionControllers.removeLast();
                                removed.dispose();
                              });
                            },
                            icon: Icon(
                              Icons.remove_circle,
                              size: 30,
                              color: Color(0xFFF1B016),
                            ),
                          ),
                        if (_optionControllers.length < 6)
                          IconButton(
                            onPressed: () {
                              setState(() {
                                final newController = TextEditingController();
                                newController.addListener(_checkForm);
                                _optionControllers.add(newController);
                              });
                            },
                            icon: Icon(
                              Icons.add_circle,
                              size: 30,
                              color: Color(0xFFF1B016),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                ..._optionControllers.map(
                  (c) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: _buildField("", "Option", c),
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap:
                      _isFilled()
                          ? () {
                            final options =
                                _optionControllers
                                    .map((c) => c.text.trim())
                                    .where((e) => e.isNotEmpty)
                                    .toList();

                            final wheel = DecisionWheel(
                              name: _nameOfWheelController.text.trim(),
                              question: 'test', // якщо буде — додай окреме поле
                              options: options,
                            );

                            context.read<WheelCubit>().addWheel(wheel);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => WheelSpinScreen(wheel: wheel),
                              ),
                            );
                          }
                          : null,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: _isFilled() ? null : Colors.grey,
                      gradient:
                          _isFilled()
                              ? const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFFF1B016),
                                  Color(0xFFFFE898),
                                  Color(0xFFDE7519),
                                ],
                              )
                              : null,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Text(
                      'Start Wheel',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    String hint,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontStyle: FontStyle.italic,
            ),
          ),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF761520),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: TextField(
            controller: controller,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black12,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameOfWheelController.dispose();
    for (final c in _optionControllers) {
      c.dispose();
    }
    super.dispose();
  }
}
