import 'package:customer/View/Widgets/color.dart';
import 'package:customer/View/Widgets/elevat_button.dart';
import 'package:customer/View/textstyle/apptextstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/Ride/RideController.dart';
import '../../../Controller/reebooking/reebookingcontroller.dart';

/// Driver Notes Dialog — image jaisi layout, project theme ke sath
/// Max 200 words allowed in the text field
void showDriverNotesDialog(BuildContext context, {String? initialNote}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.6),
    builder: (_) => DriverNotesDialog(initialNote: initialNote),
  );
}

class DriverNotesDialog extends StatefulWidget {
  final String? initialNote;
  const DriverNotesDialog({super.key, this.initialNote});

  @override
  State<DriverNotesDialog> createState() => _DriverNotesDialogState();
}

class _DriverNotesDialogState extends State<DriverNotesDialog>
    with SingleTickerProviderStateMixin {

  // final rideController = Get.isRegistered<RideController>()
  //     ? Get.find<RideController>()
  //     : Get.put(RideController());
  final reebookingController = Get.isRegistered<BookingController>()
      ? Get.find<BookingController>()
      : Get.put(BookingController());

  // late final TextEditingController noteController;
  late AnimationController _animController;
  late Animation<double> _scaleAnim;

  int _wordCount = 0;
  static const int _maxWords = 500;

  /// Quick Add chip options (image ma jo options hain)
  final List<String> _quickAddOptions = [
    'Please call on arrival',
    'Extra luggage',
    'Meet me at the entrance',
    'Travelling with a child',
  ];

  void _onNoteChanged() {
    if (mounted) {
      setState(() {
        _wordCount = _countWords(reebookingController.noteController.text);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialNote != null && widget.initialNote!.isNotEmpty) {
      reebookingController.noteController.text = widget.initialNote!;
    } else if (reebookingController.driverNote.isNotEmpty) {
      reebookingController.noteController.text = reebookingController.driverNote;
    }
    _wordCount = _countWords(reebookingController.noteController.text);

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _scaleAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutBack,
    );
    _animController.forward();

    reebookingController.noteController.addListener(_onNoteChanged);
  }

  @override
  void dispose() {
    reebookingController.noteController.removeListener(_onNoteChanged);
    _animController.dispose();
    super.dispose();
  }

  int _countWords(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return 0;
    return trimmed.split(RegExp(r'\s+')).length;
  }

  /// Quick add chip tap — add karo agar word limit allow kare
  void _onQuickAdd(String option) {
    final current =  reebookingController.noteController.text.trim();
    final newText = current.isEmpty ? option : '$current. $option';
    final newWordCount = _countWords(newText);

    if (newWordCount <= _maxWords) {
      reebookingController.noteController.text = newText;
      reebookingController.noteController.selection = TextSelection.fromPosition(
        TextPosition(offset:  reebookingController.noteController.text.length),
      );
    }
  }

  void _onSave() {
    reebookingController.drivernoteText(context);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnim,
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
        child: Container(
          decoration: BoxDecoration(
          //   gradient: const LinearGradient(
          //     colors: [
          //       Color.fromARGB(255, 30, 1, 44),
          //       Color.fromARGB(255, 60, 10, 80),
          //     ],
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //   ),
            color:CustomColor.Container_Colors ,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.15),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.45),
                blurRadius: 30,
                spreadRadius: 2,
              ),
            ],
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ──────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'RIDE DETAILS',
                            style: AppTextStyles.small(
                              color: const Color.fromARGB(255, 180, 120, 220),
                              weight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Driver Notes',
                            style: AppTextStyles.heading(
                              size: 22,
                              weight: FontWeight.bold,
                              color: CustomColor.Text_Color,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Add anything your driver should know before pickup.',
                            style: AppTextStyles.small(
                              color: Colors.white60,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Close button
                    GestureDetector(
                      onTap: () {
                        reebookingController.noteController.clear();
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white70,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // ── Trip Instructions Box ────────────────────
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.15),
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title row with word counter
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 106, 24, 130)
                                  .withOpacity(0.35),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.description_outlined,
                              color: Color.fromARGB(255, 180, 120, 220),
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Trip instructions',
                            style: AppTextStyles.medium(
                              size: 15,
                              weight: FontWeight.w600,
                              color: CustomColor.Text_Color,
                            ),
                          ),
                          const Spacer(),
                          // Word counter badge
                          Text(
                            '$_wordCount/$_maxWords',
                            style: AppTextStyles.small(
                              color: _wordCount >= _maxWords
                                  ? Colors.redAccent
                                  : Colors.white54,
                              size: 12,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Divider
                      Divider(
                        color: Colors.white.withOpacity(0.1),
                        thickness: 1,
                        height: 1,
                      ),
                      const SizedBox(height: 12),

                      /// Text field
                      // TextField(
                      //   controller:  rideController.noteController,
                      //   maxLines: 5,
                      //   minLines: 4,
                      //   style: AppTextStyles.regular(
                      //     size: 14,
                      //     color: Colors.white,
                      //   ),
                      //
                      //   decoration: InputDecoration(
                      //
                      //     // hintText:
                      //         // 'Please arrive 5 minutes before the time as passenger is disabled you have to help him. Extra luggage. Travelling with a child. Meet me at the entrance...',
                      //     hintStyle: AppTextStyles.regular(
                      //       size: 13,
                      //       color: Colors.white30,
                      //     ),
                      //     border: InputBorder.none,
                      //     isDense: true,
                      //     contentPadding: EdgeInsets.zero,
                      //
                      //   ),
                      //
                      //   cursorColor:
                      //       const Color.fromARGB(255, 180, 120, 220),
                      //   onChanged: (val) {
                      //     // Word limit enforce
                      //     if (_countWords(val) > _maxWords) {
                      //       final words = val
                      //           .trim()
                      //           .split(RegExp(r'\s+'))
                      //           .take(_maxWords)
                      //           .join(' ');
                      //       rideController.noteController.value = TextEditingValue(
                      //         text: words,
                      //         selection: TextSelection.collapsed(
                      //             offset: words.length),
                      //       );
                      //     }
                      //
                      //   },
                      // ),
                      TextField(
                        controller: reebookingController.noteController,
                        maxLines: 5,
                        minLines: 4,
                        style: AppTextStyles.regular(
                          size: 14,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintStyle: AppTextStyles.regular(
                            size: 13,
                            color: Colors.white30,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,

                          // // Cross button
                          // suffixIcon: rideController.noteController.text.isNotEmpty
                          //     ? IconButton(
                          //   icon: const Icon(
                          //     Icons.close,
                          //     color: Colors.white70,
                          //     size: 20,
                          //   ),
                          //   onPressed: () {
                          //     rideController.noteController.clear();
                          //     setState(() {});
                          //   },
                          // )
                          //     : null,
                        ),
                        cursorColor: const Color.fromARGB(255, 180, 120, 220),
                        onChanged: (val) {
                          setState(() {}); // Cross button show/hide

                          if (_countWords(val) > _maxWords) {
                            final words = val
                                .trim()
                                .split(RegExp(r'\s+'))
                                .take(_maxWords)
                                .join(' ');

                            reebookingController.noteController.value = TextEditingValue(
                              text: words,
                              selection: TextSelection.collapsed(
                                offset: words.length,
                              ),
                            );
                          }
                        },
                      ),

                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'QUICK ADD',
                      style: AppTextStyles.small(
                        color: Colors.white54,
                        weight: FontWeight.w600,
                        size: 11,
                      ),
                    ),
                    Spacer(),
                    TextButton(onPressed: () {
                      reebookingController.noteController.clear();
                      // setState(() {});
                    }, child: Text("Clear Field",style: AppTextStyles.small( color: Colors.white54,weight: FontWeight.w600,),)),
                  ],
                ),

                /// ── Quick Add Section ────────────────────────
                // Text(
                //   'QUICK ADD',
                //   style: AppTextStyles.small(
                //     color: Colors.white54,
                //     weight: FontWeight.w600,
                //     size: 11,
                //   ),
                // ),
                // const SizedBox(height: 10),

                Wrap(
                  spacing: 2,
                  runSpacing: 5,
                  children: _quickAddOptions.map((option) {
                    return _QuickAddChip(
                      label: option,
                      onTap: () => _onQuickAdd(option),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 24),

                // ── Save Button ──────────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: MyElevatedButton(
                    text: '',
                    textWidget: Text(
                      'Save Note',
                      style: AppTextStyles.medium(
                        size: 16,
                        weight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: _onSave,
                    borderRadius: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Quick Add Chip widget — image ma green "+" chips jaisi
class _QuickAddChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _QuickAddChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            // color: const Color.fromARGB(255, 106, 24, 130).withOpacity(0.6),
            color: CustomColor.Icon_Color.withOpacity(0.6),
            width: 1.2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.add,
              size: 14,
              color: CustomColor.Icon_Color,
              // color: Color.fromARGB(255, 180, 120, 220),
            ),
            const SizedBox(width: 3),
            Text(
              label,
              style: AppTextStyles.small(
                size: 10,
                // color: Colors.white,
                weight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
