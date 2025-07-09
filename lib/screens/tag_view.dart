import 'package:flutter/material.dart';
import 'package:mantadsodu/services/sb_service.dart';
import 'package:google_fonts/google_fonts.dart';

class TagView extends StatefulWidget {
  const TagView({Key? key}) : super(key: key);

  @override
  State<TagView> createState() => _TagViewState();
}

class _TagViewState extends State<TagView> {
  List<Map<String, dynamic>> tagData = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchTags();
  }

  Future<void> _fetchTags() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final fetchedTags = await fetchPlcTags();
      setState(() {
        tagData = fetchedTags;
      });
    }
    catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
    finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tag view',
          style: GoogleFonts.workSans(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.purple[100],
        actions: [
          Row(children:
          [  
          TextButton.icon(
            onPressed: _isLoading ? null : _fetchTags,
            icon: const Icon(Icons.refresh, size: 24.0),
            label:
              Text(
                "Refresh",
                style:
                  GoogleFonts.workSans(
                    textStyle:
                      TextStyle(
                        color: Colors.grey[800],
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                      ),
                  ),
              ),
          )
            ,
            SizedBox(width: 16.0,)
          ],)
        ],
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: tagData.length,
                  itemBuilder: (context, index) {
                    final data = tagData[index];
                    return Container(
                      margin: const EdgeInsets.only(top: 32.0, bottom: 0.0, left: 8.0, right: 8.0),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.35),
                              blurRadius: 8,
                              spreadRadius: 0,
                              offset: Offset(
                                0,
                                2,
                              ),
                          ),
                        ],
                      ),
                      child: DefaultTextStyle(
                        style: GoogleFonts.workSans(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: data.entries.map((entry) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${entry.key}\n',
                                      style:
                                        GoogleFonts.workSans(
                                          textStyle: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600
                                        )
                                      )
                                    ),
                                    TextSpan(
                                      text: '${entry.value}',
                                      style:
                                        GoogleFonts.workSans(
                                          textStyle:  TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                      )
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
