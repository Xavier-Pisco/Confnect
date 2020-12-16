import 'package:confnect/controller/Controller.dart';
import 'package:confnect/controller/ValidatorFactory.dart';
import 'package:confnect/model/Post.dart';
import 'package:confnect/view/Page.dart';
import 'package:confnect/view/pages/MeetupPage.dart';
import 'package:confnect/view/widgets/SquareButton.dart';
import 'package:confnect/view/widgets/forms/DateTimeForm.dart';
import 'package:confnect/view/widgets/forms/FormFieldContainer.dart';
import 'package:confnect/view/widgets/forms/FormTextField.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CreateMeetupPage extends StatefulPage {
  Post _post;
  Controller _controller;
  final Function _refreshPostPage;
  CreateMeetupPage(this._controller, this._post, this._refreshPostPage)
      : super(_controller, key: Key("CreateMeetupPage"));

  @override
  _CreateMeetupPageState createState() => _CreateMeetupPageState();
}

class _CreateMeetupPageState extends State<CreateMeetupPage> {
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _timeKey = GlobalKey<FormState>();

  void createMeetup(
      String location, DateTime date, TimeOfDay time, String description) {
    widget._controller.getDatabase().createMeetup(
        widget._post,
        location,
        date,
        time,
        description,
        widget._controller
            .getDatabase()
            .getUser(widget._controller.getLoggedInUserName()));
  }

  @override
  Widget build(BuildContext context) {
    DateTime meetDate = new DateTime.now();
    TimeOfDay meetTime = new TimeOfDay.now();
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Meetup"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                FormFieldContainer(
                  FormTextField(
                    "Location",
                    _locationController,
                    validator: ValidatorFactory.getValidator('Location',
                        fieldRequired: true, upperLimit: 50),
                  ),
                  margin: EdgeInsets.all(10),
                  key: Key("LocationMeetupForm"),
                ),
                FormFieldContainer(
                  DateTimeForm(
                    key: _timeKey,
                    labelText: "Start Time",
                    selectedDate: new DateTime.now(),
                    selectedTime: new TimeOfDay.now(),
                    selectDate: (date) => {meetDate = date},
                    selectTime: (time) => {meetTime = time},
                  ),
                  margin: EdgeInsets.all(10),
                ),
                FormFieldContainer(
                  FormTextField(
                    "Description",
                    _descriptionController,
                    validator: ValidatorFactory.getValidator('Description',
                        fieldRequired: true, upperLimit: 300),
                    maxLines: 5,
                  ),
                  margin: EdgeInsets.all(10),
                  key: Key("DescriptionMeetupForm"),
                ),
              ],
            ),
            FormFieldContainer(
              SquareButton('Submit', () {
                String location = _locationController.text;
                String description = _descriptionController.text;
                if (_formKey.currentState.validate()) {
                  createMeetup(location, meetDate, meetTime, description);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MeetupPage(
                            widget._controller, widget._post.getMeetup())),
                  );
                  widget._refreshPostPage();
                }
              }),
              key: Key("SubmitCreateMeetup"),
            ),
          ],
        ),
      ),
    );
  }
}
