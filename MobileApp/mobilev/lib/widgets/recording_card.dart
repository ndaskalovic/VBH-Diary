// Dart & Flutter imports
import 'package:flutter/material.dart';

// Package imports
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';

// Module imports
import 'package:mobilev/config/constants.dart';
import 'package:mobilev/screens/view_recording.dart';
import 'package:mobilev/widgets/status_card.dart';
import 'package:mobilev/widgets/recording_card_score.dart';

class RecordingCard extends StatefulWidget {
  final String dateRecorded;
  final String type;
  final int duration;
  final bool isShared;
  final AnalysisStatus analysisStatus;
  final Map<String, int> scores;

  RecordingCard({
    required this.dateRecorded,
    required this.type,
    required this.duration,
    required this.isShared,
    required this.analysisStatus,
    required this.scores,
  });

  @override
  _RecordingCardState createState() => _RecordingCardState();
}

class _RecordingCardState extends State<RecordingCard> {
  List<Widget> constructScores() {
    List<Widget> list = [];
    widget.scores.forEach((key, value) {
      list.add(
        RecordingCardScore(scoreName: key, scoreValue: value),
      );
      list.add(
        SizedBox(height: 10.0),
      );
    });
    return list;
  }

  static String expansionTitle = 'View scores';

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kCardColour,
      elevation: 6.0,
      margin: EdgeInsets.fromLTRB(4.0, 20.0, 4.0, 0.0),
      child: Container(
        padding: EdgeInsets.fromLTRB(
            15.0, 15.0, 15.0, widget.scores.isNotEmpty ? 0.0 : 15.0),
        child: Column(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                var directory = await getApplicationDocumentsDirectory();
                String audioPath = '${directory.path}/test.m4a';
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ViewRecordingScreen(
                      scores: widget.scores,
                      analysisStatus: widget.analysisStatus,
                      audioPath: audioPath,
                    );
                  }),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.dateRecorded,
                    style: TextStyle(
                      color: kPrimaryColour,
                      fontSize: 22.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Roboto',
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: widget.type,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        TextSpan(
                          text: '  |  ${widget.duration}s',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                var directory = await getApplicationDocumentsDirectory();
                String audioPath = '${directory.path}/test.m4a';
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ViewRecordingScreen(
                      scores: widget.scores,
                      analysisStatus: widget.analysisStatus,
                      audioPath: audioPath,
                    );
                  }),
                );
              },
              child: SizedBox(height: 15.0),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                var directory = await getApplicationDocumentsDirectory();
                String audioPath = '${directory.path}/test.m4a';
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ViewRecordingScreen(
                      scores: widget.scores,
                      analysisStatus: widget.analysisStatus,
                      audioPath: audioPath,
                    );
                  }),
                );
              },
              child: Row(
                children: [
                  widget.isShared
                      ? StatusCard(
                          colour: Colors.green,
                          label: 'Shared',
                          icon: Icon(
                            Icons.check_box_outlined,
                            color: Colors.white,
                          ),
                          iconFirst: false,
                        )
                      : StatusCard(
                          colour: kSecondaryTextColour,
                          label: 'Not shared',
                          icon: Icon(
                            Icons.disabled_by_default_outlined,
                            color: Colors.white,
                          ),
                          iconFirst: false,
                        ),
                  SizedBox(width: 10.0),
                  if (widget.analysisStatus == AnalysisStatus.unavailable)
                    StatusCard(
                      colour: kSecondaryTextColour,
                      label: 'Analysis unavailable',
                      icon: Icon(
                        Icons.disabled_by_default_outlined,
                        color: Colors.white,
                      ),
                      iconFirst: false,
                    ),
                  if (widget.analysisStatus == AnalysisStatus.pending)
                    StatusCard(
                      colour: Colors.orange,
                      label: 'Analysis pending',
                      icon: SpinKitWave(
                        type: SpinKitWaveType.center,
                        color: Colors.white,
                        size: 19.7,
                        itemCount: 7,
                        // lineWidth: 3.0,
                      ),
                      iconFirst: false,
                    ),
                  if (widget.analysisStatus == AnalysisStatus.received)
                    StatusCard(
                      colour: Colors.green,
                      label: 'Analysis received',
                      icon: Icon(
                        Icons.check_box_outlined,
                        color: Colors.white,
                      ),
                      iconFirst: false,
                    ),
                  if (widget.analysisStatus == AnalysisStatus.failed)
                    StatusCard(
                      colour: Colors.red,
                      label: 'Analysis failed',
                      icon: Icon(
                        Icons.error_outline,
                        color: Colors.white,
                      ),
                      iconFirst: false,
                    ),
                ],
              ),
            ),
            SizedBox(width: 10.0),
            if (widget.scores.isNotEmpty)
              ExpansionTile(
                textColor: Colors.black,
                iconColor: Colors.black,
                tilePadding: EdgeInsets.fromLTRB(10.0, 0.0, 160.0, 0.0),
                childrenPadding: EdgeInsets.only(left: 20.0),
                title: Text(expansionTitle),
                onExpansionChanged: (isExpanded) {
                  setState(() {
                    isExpanded
                        ? expansionTitle = 'Hide scores'
                        : expansionTitle = 'View scores';
                  });
                },
                children: constructScores(),
              ),
          ],
        ),
      ),
    );
  }
}
