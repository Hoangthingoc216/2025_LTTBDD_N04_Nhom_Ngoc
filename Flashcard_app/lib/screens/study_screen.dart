import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flashcard_app/models/flashcard_model.dart';
import 'package:flashcard_app/widgets/flashcard_widget.dart';
import 'package:flutter_tts/flutter_tts.dart';

class StudyScreen extends StatefulWidget {
  final FlashcardTopic topic;
  const StudyScreen({super.key, required this.topic});

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController DieuKhienHieuUng;
  late Animation<double> HieuUngXoay;
  bool MatTruoc = true;
  int index = 0;
  final FlutterTts voice = FlutterTts();

  final TextEditingController NhapCauTraLoi = TextEditingController();
  String phanHoi = '';
  int SoCauDung = 0;
  bool DaHoanThanh = false;
  bool DaKiemTra = false;

  @override
  void initState() {
    super.initState();

    DieuKhienHieuUng = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    HieuUngXoay = Tween<double>(begin: 0, end: pi).animate(DieuKhienHieuUng);
  }

  void latThe() {
    if (MatTruoc) {
      DieuKhienHieuUng.forward();
    } else {
      DieuKhienHieuUng.reverse();
    }
    setState(() {
      MatTruoc = !MatTruoc;
    });
  }

  Future<void> readWord(String word) async {
    await voice.setLanguage("en-US");
    await voice.speak(word);
  }

  void KiemTraCauTraLoi() {
    final CapTu = widget.topic.words[index];
    final TiengAnh = CapTu['en'] ?? '';
    final TiengViet = CapTu['vi'] ?? '';
    final CauTraLoi = NhapCauTraLoi.text.trim().toLowerCase();

    setState(() {
      DaKiemTra = true;
      if (CauTraLoi == TiengAnh.toLowerCase()) {
        phanHoi = " Chính xác!";
        SoCauDung++;
      } else {
        phanHoi = "Sai rồi! Đáp án đúng là: $TiengAnh";
      }
    });
  }

  void TheTiepTheo() {
    setState(() {
      if (index < widget.topic.words.length - 1) {
        index++;
        MatTruoc = true;
        DieuKhienHieuUng.reset();
        phanHoi = '';
        DaKiemTra = false;
        NhapCauTraLoi.clear();
      } else {
        DaHoanThanh = true;
      }
    });
  }

  void TheTruoc() {
    setState(() {
      if (index > 0) {
        index--;
        MatTruoc = true;
        DieuKhienHieuUng.reset();
        phanHoi = '';
        DaKiemTra = false;
        NhapCauTraLoi.clear();
      }
    });
  }

  @override
  void dispose() {
    DieuKhienHieuUng.dispose();
    voice.stop();
    NhapCauTraLoi.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CapTu = widget.topic.words[index];
    final TiengAnh = CapTu['en'] ?? '';
    final TiengViet = CapTu['vi'] ?? '';

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F7),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.pink[300],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.psychology,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 12),

                  Text(
                    'Ôn tập từ vựng',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F1F1F),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              if (!DaHoanThanh)
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, size: 18),
                  label: Text('Quay lại danh sách'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF5B7FFF),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              SizedBox(height: 24),

              if (!DaHoanThanh) ...[
                Center(
                  child: Text(
                    widget.topic.title,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F1F1F),
                    ),
                  ),
                ),
                SizedBox(height: 12),

                Center(
                  child: Text(
                    'Thẻ ${index + 1}/${widget.topic.words.length}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTap: latThe,
                      child: AnimatedBuilder(
                        animation: HieuUngXoay,
                        builder: (context, child) {
                          final angle = HieuUngXoay.value;
                          final isFront = angle < pi / 2;

                          return Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateY(angle),
                            child: Container(
                              width: 400,
                              height: 250,
                              padding: EdgeInsets.all(32),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 20,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.identity()
                                    ..rotateY(isFront ? 0 : pi),
                                  child: Text(
                                    isFront ? TiengViet : TiengAnh,
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1F1F1F),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                Row(
                  children: [
                    IconButton(
                      onPressed: index > 0 ? TheTruoc : null,
                      icon: Icon(Icons.arrow_back),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.grey[800],
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),

                    IconButton(
                      onPressed: () => readWord(TiengAnh),
                      icon: Icon(Icons.volume_up),
                      style: IconButton.styleFrom(
                        backgroundColor: Color(0xFF5B7FFF),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),

                    Expanded(
                      child: TextField(
                        controller: NhapCauTraLoi,
                        enabled: !DaKiemTra,
                        decoration: InputDecoration(
                          hintText: 'Nhập từ tiếng Anh...',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.grey[300]!,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.grey[300]!,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color(0xFF5B7FFF),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),

                    ElevatedButton(
                      onPressed: DaKiemTra ? null : KiemTraCauTraLoi,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4CAF50),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Kiểm tra',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),

                    IconButton(
                      onPressed: TheTiepTheo,
                      icon: Icon(Icons.arrow_forward),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.grey[800],
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),

                if (phanHoi.isNotEmpty)
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: phanHoi.contains("Chính xác")
                            ? Colors.green[50]
                            : Colors.red[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: phanHoi.contains("Chính xác")
                              ? Colors.green
                              : Colors.red,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        phanHoi,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: phanHoi.contains("Chính xác")
                              ? Colors.green[700]
                              : Colors.red[700],
                        ),
                      ),
                    ),
                  ),
              ],

              if (DaHoanThanh) ...[
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check_circle,
                            size: 60,
                            color: Colors.green[600],
                          ),
                        ),
                        SizedBox(height: 20),

                        Text(
                          'Hoàn thành!',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F1F1F),
                          ),
                        ),
                        SizedBox(height: 15),

                        Text(
                          'Bạn đã trả lời đúng $SoCauDung/${widget.topic.words.length} từ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 15),

                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF5B7FFF),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Kết thúc ôn luyện',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
