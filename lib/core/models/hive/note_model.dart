import 'package:hive/hive.dart';

part 'note_model.g.dart';


@HiveType(typeId: 0)
enum NoteLanguage {
  @HiveField(0)
  dart,
  
  @HiveField(1)
  javascript,
  
  @HiveField(2)
  python,
  
  @HiveField(3)
  java,
  
  @HiveField(4)
  cpp,
  
  @HiveField(5)
  swift,
  
  @HiveField(6)
  kotlin,
  
  @HiveField(7)
  php,
  
  @HiveField(8)
  ruby,
  
  @HiveField(9)
  go,
  
  @HiveField(10)
  rust,
  
  @HiveField(11)
  sql,
  
  @HiveField(12)
  html,
  
  @HiveField(13)
  css,
  
  @HiveField(14)
  plainText,
}



@HiveType(typeId: 1)
class NoteModel extends HiveObject {
  

  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String content;

  @HiveField(3)
  int type;

  @HiveField(4)
  int categoryId;

  @HiveField(5)
  List<String> tags;

  @HiveField(6)
  bool isPinned;

  @HiveField(7)
  bool isArchived;

  @HiveField(8)
  DateTime createdAt;

  @HiveField(9)
  DateTime updatedAt;

  @HiveField(10)
  NoteLanguage language;

  

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    required this.categoryId,
    this.tags = const [],
    this.isPinned = false,
    this.isArchived = false,
    required this.createdAt,
    required this.updatedAt,
    required this.language,
  });

  
  NoteType get noteType => NoteType.values[type];

}


enum NoteType { note, bug, task, idea, snippet, personal }