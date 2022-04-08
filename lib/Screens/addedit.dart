import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:oriki/Firestore/db_service.dart';
import 'package:oriki/Model/dob_model.dart';
import 'package:oriki/Services/notification_services.dart';
import 'package:oriki/Widgets/custom_form_field.dart';

class AddEdit extends StatefulWidget {
  static const routeName = '/AddEdit';
  const AddEdit({Key? key}) : super(key: key);

  @override
  State<AddEdit> createState() => _AddEditState();
}

class _AddEditState extends State<AddEdit> {
  DateTime? date;
  final Repository _repository = Repository();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DobModel? _dobModel;
  String? uid;
  String? formattedTimeOfDay;
  final _notificationService = NotificationService();

  @override
  didChangeDependencies() {
    _dobModel = ModalRoute.of(context)!.settings.arguments as DobModel;
    if (_dobModel!.email.isNotEmpty) {
      name.text = _dobModel!.name;
      email.text = _dobModel!.email;
      date = _dobModel!.date.toDate();
      number.text = _dobModel!.number.toString();
      uid = _dobModel!.uid;
    } else {
      uid = DateTime.now().toString();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          'Oriki Staff',
          style: Theme.of(context).primaryTextTheme.headline6,
        )),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Form(
                key: _formKey,
                child: Column(children: [
                  CustomTextField(
                    placeHolder: 'First Name & Last Name',
                    controller: name,
                    validationMessage: 'Please enter a name',
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    placeHolder: 'Phone Number',
                    controller: number,
                    validationMessage: 'Please enter a number',
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    placeHolder: 'email Address',
                    controller: email,
                    validationMessage: 'Please enter a email',
                  ),
                  const SizedBox(height: 20),
                  Container(
                      padding: const EdgeInsets.only(left: 8),
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        //color: Colors.blue,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FormBuilderDateTimePicker(
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                        name: 'name',
                        fieldHintText: 'Select Date of Birth',
                        fieldLabelText: 'Date of Birth',
                        initialValue: date,
                        inputType: InputType.date,
                        decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.calendar_today, size: 20),
                            /* suffixIcon: Icon(
                          Icons.calendar_today,
                          size: 20.sp,
                        ), */
                            border: InputBorder.none),
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        onChanged: (value) {
                          date = value;
                        },
                        format: DateFormat('MMMM dd, yyyy'),
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required(context)]),
                      )),
                  const SizedBox(height: 40),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final dobs = DobModel(
                              uid: uid!,
                              name: name.text,
                              email: email.text,
                              number: int.parse(number.text),
                              date: Timestamp.fromDate(date!));
                          final localizations =
                              MaterialLocalizations.of(context);
                          formattedTimeOfDay =
                              localizations.formatFullDate(date!);
                          final passedDate = date;
                          _notificationService.trialNoti(
                              passedDate.toString(), name.text);
                          _repository
                              .createUser(dobs)
                              .whenComplete(() => Navigator.of(context).pop());
                        }
                      },
                      child: const Text('Save'))
                ]))));
  }
}
