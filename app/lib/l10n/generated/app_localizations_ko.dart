// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => '다시 시도';

  @override
  String get errorGeneric => '문제가 발생했습니다';

  @override
  String get cancel => '취소';

  @override
  String get save => '저장';

  @override
  String get delete => '삭제';

  @override
  String get undo => '실행 취소';

  @override
  String get redo => '다시 실행';

  @override
  String get untitledNote => '제목 없음';

  @override
  String get deleteConfirmBody => '이 작업은 취소할 수 없습니다.';

  @override
  String get deleteNoteTitle => '이 노트를 삭제하시겠습니까?';

  @override
  String deleteNotebookTitle(String name) {
    return '\"$name\"을(를) 삭제하시겠습니까?';
  }

  @override
  String get saveFailedMessage => '저장하지 못했습니다. 다시 시도해 주세요.';

  @override
  String get exportFailedMessage => '이 노트를 내보내지 못했습니다. 다시 시도해 주세요.';

  @override
  String get shareFailedMessage => '공유 시트를 열지 못했습니다. 다시 시도해 주세요.';

  @override
  String get settingsTitle => '설정';

  @override
  String get searchHint => '노트 검색';

  @override
  String get emptyNotebooksTitle => '아직 노트북이 없습니다';

  @override
  String get emptyNotebooksBody => '첫 번째 노트북을 만들어 글쓰기를 시작하세요.';

  @override
  String get emptySearchTitle => '결과 없음';

  @override
  String get emptySearchBody => '다른 검색어를 시도해 보세요.';

  @override
  String get emptyNotebookTitle => '아직 노트가 없습니다';

  @override
  String get emptyNotebookBody => '+ 버튼을 눌러 첫 번째 노트를 작성하세요.';

  @override
  String get newNotebookTitle => '새 노트북';

  @override
  String get notebookNameHint => '노트북 이름';

  @override
  String get newNoteTitle => '새 노트';

  @override
  String get sortOptionsTitle => '정렬';

  @override
  String get sortByModified => '최근 수정';

  @override
  String get sortByCreated => '생성일';

  @override
  String get sortByTitle => '제목';

  @override
  String get formatBold => '굵게';

  @override
  String get formatItalic => '기울임꼴';

  @override
  String get formatUnderline => '밑줄';

  @override
  String get formatHeading => '제목';

  @override
  String get formatBulletList => '글머리 기호 목록';

  @override
  String get formatChecklist => '체크리스트';

  @override
  String get formatQuote => '인용구';

  @override
  String get formatCodeBlock => '코드 블록';

  @override
  String get penFountainPen => '만년필';

  @override
  String get penGelPen => '젤펜';

  @override
  String get penPencil => '연필';

  @override
  String get penHighlighter => '형광펜';

  @override
  String get penEraser => '지우개';

  @override
  String get penStrokeWidth => '선 굵기';

  @override
  String get toggleHandwritingMode => '입력과 손글씨 전환';

  @override
  String get biometricLockReason => '이 노트를 보려면 잠금을 해제하세요';

  @override
  String get noteLockedMessage => '이 노트는 잠겨 있습니다';

  @override
  String get unlockButton => '잠금 해제';

  @override
  String get exportTitle => '내보내기';

  @override
  String get exportAsTxt => '텍스트로 내보내기';

  @override
  String get exportAsPdf => 'PDF로 내보내기';

  @override
  String get paperStyleSectionTitle => '용지 스타일';

  @override
  String get paperStyleLined => '줄무늬';

  @override
  String get paperStyleDotGrid => '점 격자';

  @override
  String get paperStyleGrid => '모눈';

  @override
  String get paperStyleBlank => '백지';

  @override
  String get paperStyleCream => '크림';

  @override
  String get paperStyleParchment => '양피지';

  @override
  String get paperStyleVellum => '벨럼';

  @override
  String get fontSectionTitle => '노트 글꼴';

  @override
  String get fontSystem => '시스템';

  @override
  String get fontSerif => '세리프';

  @override
  String get themeSectionTitle => '모양';

  @override
  String get themeLight => '라이트';

  @override
  String get themeDark => '다크';

  @override
  String get themeParchment => '양피지';

  @override
  String get themeSystem => '시스템';

  @override
  String get verseSectionTitle => '오늘의 말씀 표시';

  @override
  String get verseModeWatermark => '워터마크';

  @override
  String get verseModeHeader => '머리글';

  @override
  String get verseModeFooter => '바닥글';

  @override
  String get verseModeOff => '끄기';

  @override
  String get notificationsSectionTitle => '알림';

  @override
  String get dailyReminderToggle => '매일 말씀 알림';

  @override
  String get reminderTimeLabel => '알림 시간';

  @override
  String get notificationPermissionDenied => '시스템 설정에서 알림이 꺼져 있습니다.';

  @override
  String get dailyReminderBody => '오늘의 말씀이 준비되었습니다.';

  @override
  String get privacySectionTitle => '개인정보 보호';

  @override
  String get biometricLockToggle => 'Face ID / 지문으로 노트 잠그기';

  @override
  String get premiumSectionTitle => '프리미엄';

  @override
  String get removeAdsTitle => '광고 제거';

  @override
  String get restorePurchasesButton => '구매 복원';

  @override
  String get proLabel => 'Pro';

  @override
  String get engagementSectionTitle => '더보기';

  @override
  String get rateAppTitle => 'Atrament 평가';

  @override
  String get rateAppSubtitle => '앱이 마음에 드시나요? 리뷰를 남겨주세요';

  @override
  String get shareAppTitle => 'Atrament 공유';

  @override
  String get shareAppSubtitle => '친구에게 알리기';

  @override
  String get shareAppMessage => 'Atrament를 사용해보세요 — 종이 질감의 집중 가능한 노트패드.';

  @override
  String get languageSectionTitle => '언어';

  @override
  String get languageFollowsSystem => '기기의 언어 설정을 따릅니다';

  @override
  String get languageSystem => '시스템 기본값';

  @override
  String get languagePickerTitle => '언어 선택';

  @override
  String get premiumScreenTitle => '광고 제거';

  @override
  String get premiumHeadline => '방해받지 않고 글쓰기';

  @override
  String get premiumBody =>
      'Atrament은 작은 배너 광고와 함께 무료입니다. 광고 제거는 일회성 구매이며 다른 것은 잠금 해제되지 않습니다 — 모든 기능은 이미 당신의 것입니다.';

  @override
  String get premiumRestoreButton => '구매 복원';

  @override
  String get premiumAlreadyProMessage => '이미 광고 제거를 이용 중입니다. 감사합니다!';

  @override
  String get supportSectionTitle => '지원';

  @override
  String get shareDebugLogButton => '디버그 로그 공유';

  @override
  String get shareDebugLogSubtitle => '문제가 있으면 기술 보고서를 보내주세요';

  @override
  String get noDebugLogMessage => '아직 보고할 문제가 없습니다.';

  @override
  String get clearDebugLogButton => '디버그 로그 지우기';

  @override
  String get clearDebugLogTitle => '디버그 로그를 지우시겠습니까?';

  @override
  String get clearDebugLogBody => '기기에 저장된 기술 보고서가 제거됩니다.';

  @override
  String get debugLogClearedMessage => '디버그 로그가 지워졌습니다.';

  @override
  String get premiumUnlockLabel => '광고 영구 제거';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'All';

  @override
  String get chipNotebooks => 'Notebooks';

  @override
  String get chipRecent => 'Recent';

  @override
  String get emptyAllNotesTitle => 'No notes yet';

  @override
  String get emptyAllNotesBody => 'Tap the + button to write your first note.';

  @override
  String get emptyRecentNotesTitle => 'Nothing recent';

  @override
  String get emptyRecentNotesBody => 'Notes you edit will show up here.';

  @override
  String get noteActionRename => 'Rename';

  @override
  String get noteActionMoveToNotebook => 'Move to Notebook';

  @override
  String get noteActionEdit => 'Edit';

  @override
  String get noteActionExport => 'Export';

  @override
  String get noteActionShare => 'Share';

  @override
  String get moveToNotebookTitle => 'Move to Notebook';

  @override
  String get moveToNotebookEmptyBody =>
      'No other notebooks yet. Create one to organise this note.';

  @override
  String get moveToNotebookCreateRow => 'Create new notebook';

  @override
  String get notebookActionRename => 'Rename';

  @override
  String get notebookActionChangeCover => 'Change cover';

  @override
  String get notebookRenameDialogTitle => 'Rename Notebook';

  @override
  String get notebookCoverPickerTitle => 'Choose a cover color';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'This will delete the notebook and its $count notes. This can\'t be undone.';
  }
}
