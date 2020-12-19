import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:ran_flutter_core/ran_flutter_core.dart';
import 'package:ran_flutter_fields/ran_flutter_fields.dart';
import 'package:ran_flutter_site/model/section_model.dart';
import 'package:ran_flutter_site/site_repository.dart';
import 'package:bot_toast/bot_toast.dart';

class SectionsViewModel with ChangeNotifier {
  List<Section> sections = [];
  List<Section> appointSections = [];
  List<Field> fields = [];
  List<Field> appointFields = [];
  Field appointField;

  SectionsViewModel() {
    init();
  }

  init() async {
    try {
      Sections allSections = await SiteRepository.fetchSections();
      this.sections = allSections.items;
      notifyListeners();
    } catch (e, s) {
      print(e.toString());
    }
  }

//  根据板块name数组设置相应的板块
  setAppointSections(List<String> sectionNames) {
    this.appointSections = this
        .sections
        .where((item) => sectionNames.contains(item.name))
        .toList();
    notifyListeners();
  }

  //  根据板块id取相应的板块
  getSection(String id) {
    Section section = this.sections.firstWhere((item) => item.id == id);
    return section;
  }
  //  根据板块name取相应的板块
  getSectionByName(String name) {
    Section section = this.sections.firstWhere((item) => item.name == name);
    return section;
  }

  //  根据板块id取出所有字段放到一个数组中
  setFieldsCurrentSection(String sectionId) {
    Section section = this.sections.firstWhere((item) => item.id == sectionId,
        orElse: () => new Section());
    if (section.id != null) {
      section.entityTypes.forEach((entityType) {
        entityType.fieldTabs.forEach((fieldTab) {
          fieldTab.fields.forEach((field) {
            this.fields.add(field);
          });
        });
      });
      notifyListeners();
    } else {
      print('未找到板块');
    }
  }

  //根据字段name数组设置相应字段数组
  setAppointFields(List<String> fieldNames, {String sectionId}) {
    if (sectionId != null) {
      setFieldsCurrentSection(sectionId);
    }
    this.appointFields =
        this.fields.where((item) => fieldNames.contains(item.name)).toList();
    notifyListeners();
    return this.appointFields;
  }

  //根据字段name取相应字段数组
  Field getAppointField(String fieldName, {String sectionId}) {
    if (sectionId != null) {
      Section section = this.sections.firstWhere((item) => item.id == sectionId,
          orElse: () => new Section());
      if (section.id != null) {
        section.entityTypes.forEach((entityType) {
          entityType.fieldTabs.forEach((fieldTab) {
            fieldTab.fields.forEach((field) {
              this.fields.add(field);
            });
          });
        });
      }
    }
    this.appointField =
        this.fields.firstWhere((item) => fieldName == item.name, orElse: () {
      return new Field();
    });
    return this.appointField;
  }
}
