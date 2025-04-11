// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:ios_f_n_fantastictimetodecide_3286/cubit/my_question_cubit/my_question_cubit.dart';

class CreateQuestionScreen extends StatefulWidget {
  const CreateQuestionScreen({super.key});

  @override
  State<CreateQuestionScreen> createState() => _CreateQuestionScreenState();
}

class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
  final _questionController = TextEditingController();
  final _option1Controller = TextEditingController();
  final _option2Controller = TextEditingController();

  bool get _isFilled =>
      _questionController.text.trim().isNotEmpty &&
      _option1Controller.text.trim().isNotEmpty &&
      _option2Controller.text.trim().isNotEmpty;

  void _checkForm() => setState(() {});

  @override
  void initState() {
    super.initState();
    _questionController.addListener(_checkForm);
    _option1Controller.addListener(_checkForm);
    _option2Controller.addListener(_checkForm);
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
      title: Text('Hold the Spotlight!', style: TextStyle(color: Colors.white)),
      content: Text(
        'You\'ve started crafting a delightful dilemma, but it’s not saved yet. Are you sure you want to walk away from this masterpiece?',
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text('Leave', style: TextStyle(color: Colors.white, fontSize: 18.0)),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text('Stay', style: TextStyle(color: Color(0xFFF1B016), fontSize: 18.0)),
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
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              _buildField("Question", 'Question', _questionController),
              SizedBox(height: 20),
              _buildField("Option", "Option 1", _option1Controller),
              SizedBox(height: 10),
              _buildField("", "Option 2", _option2Controller),
              Spacer(),
              GestureDetector(
                onTap:
                    _isFilled
                        ? () {
                          final newQuestion = CustomQuestion(
                            question: _questionController.text.trim(),
                            option1: _option1Controller.text.trim(),
                            option2: _option2Controller.text.trim(),
                          );
                          Navigator.pop(context, newQuestion);
                        }
                        : null,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: _isFilled ? null : Colors.grey,
                    gradient:
                        _isFilled
                            ? LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFFF1B016),
                                Color(0xFFFFE898),
                                Color(0xFFDE7519),
                                Color(0xFFDE7519),
                              ],
                            )
                            : null,
                  ),

                  padding: EdgeInsets.symmetric(vertical: 16),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    'Save Question',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
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
}
