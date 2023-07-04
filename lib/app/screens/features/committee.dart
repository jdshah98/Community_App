import 'package:community_app/app/constants/images.dart';
import 'package:community_app/app/model/committee_member.dart';
import 'package:community_app/app/repository/common.dart';
import 'package:flutter/material.dart';

class Committee extends StatelessWidget {
  const Committee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Committee Info",
          style: TextStyle(letterSpacing: 0.1),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: CommonRepository.getAllCommitteeMembers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            debugPrint(snapshot.data.toString());
            List<CommitteeMember>? members = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                children: members!
                    .map(
                      (member) => Card(
                        elevation: 5,
                        margin: const EdgeInsets.all(16),
                        surfaceTintColor: Colors.grey.shade300,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: Image(
                                  image: AssetImage(avatar),
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(member.designation),
                                  Text(member.name),
                                  Text(member.mobileNo),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
