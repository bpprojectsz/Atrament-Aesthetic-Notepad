// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => '重试';

  @override
  String get errorGeneric => '出现问题';

  @override
  String get cancel => '取消';

  @override
  String get save => '保存';

  @override
  String get delete => '删除';

  @override
  String get undo => '撤销';

  @override
  String get redo => '重做';

  @override
  String get untitledNote => '无标题';

  @override
  String get deleteConfirmBody => '此操作无法撤销。';

  @override
  String get deleteNoteTitle => '要删除这条笔记吗？';

  @override
  String deleteNotebookTitle(String name) {
    return '要删除“$name”吗？';
  }

  @override
  String get saveFailedMessage => '保存失败，请重试。';

  @override
  String get exportFailedMessage => '导出此笔记失败，请重试。';

  @override
  String get shareFailedMessage => '无法打开分享面板，请重试。';

  @override
  String get settingsTitle => '设置';

  @override
  String get searchHint => '搜索笔记';

  @override
  String get emptyNotebooksTitle => '还没有笔记本';

  @override
  String get emptyNotebooksBody => '创建你的第一个笔记本，开始写作。';

  @override
  String get emptySearchTitle => '没有结果';

  @override
  String get emptySearchBody => '请尝试其他搜索词。';

  @override
  String get emptyNotebookTitle => '还没有笔记';

  @override
  String get emptyNotebookBody => '点击 + 按钮写下第一条笔记。';

  @override
  String get newNotebookTitle => '新建笔记本';

  @override
  String get notebookNameHint => '笔记本名称';

  @override
  String get newNoteTitle => '新建笔记';

  @override
  String get sortOptionsTitle => '排序';

  @override
  String get sortByModified => '最近编辑';

  @override
  String get sortByCreated => '创建日期';

  @override
  String get sortByTitle => '标题';

  @override
  String get formatBold => '加粗';

  @override
  String get formatItalic => '斜体';

  @override
  String get formatUnderline => '下划线';

  @override
  String get formatHeading => '标题';

  @override
  String get formatBulletList => '项目符号列表';

  @override
  String get formatChecklist => '清单';

  @override
  String get formatQuote => '引用';

  @override
  String get formatCodeBlock => '代码块';

  @override
  String get penFountainPen => '钢笔';

  @override
  String get penGelPen => '中性笔';

  @override
  String get penPencil => '铅笔';

  @override
  String get penHighlighter => '荧光笔';

  @override
  String get penEraser => '橡皮擦';

  @override
  String get penStrokeWidth => '笔画粗细';

  @override
  String get toggleHandwritingMode => '在打字和手写之间切换';

  @override
  String get biometricLockReason => '解锁以查看此笔记';

  @override
  String get noteLockedMessage => '此笔记已锁定';

  @override
  String get unlockButton => '解锁';

  @override
  String get exportTitle => '导出';

  @override
  String get exportAsTxt => '导出为文本';

  @override
  String get exportAsPdf => '导出为 PDF';

  @override
  String get paperStyleSectionTitle => '纸张样式';

  @override
  String get paperStyleLined => '横线';

  @override
  String get paperStyleDotGrid => '点阵网格';

  @override
  String get paperStyleGrid => '方格';

  @override
  String get paperStyleBlank => '空白';

  @override
  String get paperStyleCream => '米色';

  @override
  String get paperStyleParchment => '羊皮纸';

  @override
  String get paperStyleVellum => '犊皮纸';

  @override
  String get fontSectionTitle => '笔记字体';

  @override
  String get fontSystem => '系统字体';

  @override
  String get fontSerif => '衬线字体';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => '外观';

  @override
  String get themeLight => '浅色';

  @override
  String get themeDark => '深色';

  @override
  String get themeParchment => '羊皮纸';

  @override
  String get themeSystem => '系统';

  @override
  String get verseSectionTitle => '每日经文显示';

  @override
  String get verseModeWatermark => '水印';

  @override
  String get verseModeHeader => '页眉';

  @override
  String get verseModeFooter => '页脚';

  @override
  String get verseModeOff => '关闭';

  @override
  String get notificationsSectionTitle => '通知';

  @override
  String get dailyReminderToggle => '每日经文提醒';

  @override
  String get reminderTimeLabel => '提醒时间';

  @override
  String get notificationPermissionDenied => '系统设置中通知已关闭。';

  @override
  String get dailyReminderBody => '你的每日经文已准备好。';

  @override
  String get privacySectionTitle => '隐私';

  @override
  String get biometricLockToggle => '使用面容 ID / 指纹锁定笔记';

  @override
  String get premiumSectionTitle => '高级版';

  @override
  String get removeAdsTitle => '移除广告';

  @override
  String get restorePurchasesButton => '恢复购买';

  @override
  String get proLabel => '专业版';

  @override
  String get engagementSectionTitle => '更多';

  @override
  String get rateAppTitle => '评价 Atrament';

  @override
  String get rateAppSubtitle => '喜欢这个应用？留下评价';

  @override
  String get shareAppTitle => '分享 Atrament';

  @override
  String get shareAppSubtitle => '告诉朋友';

  @override
  String get shareAppMessage => '试试 Atrament —— 一款带有纸张纹理的无干扰记事本。';

  @override
  String get languageSectionTitle => '语言';

  @override
  String get languageFollowsSystem => '跟随设备语言设置';

  @override
  String get languageSystem => '系统默认';

  @override
  String get languagePickerTitle => '选择语言';

  @override
  String get premiumScreenTitle => '移除广告';

  @override
  String get premiumHeadline => '专注写作，无干扰';

  @override
  String get premiumBody =>
      'Atrament 免费使用，附带一个小型横幅广告。移除广告为一次性购买，不会解锁其他内容 — 所有功能已经属于您。';

  @override
  String get premiumRestoreButton => '恢复购买';

  @override
  String get premiumAlreadyProMessage => '你已拥有移除广告功能，谢谢！';

  @override
  String get supportSectionTitle => '支持';

  @override
  String get shareDebugLogButton => '分享调试日志';

  @override
  String get shareDebugLogSubtitle => '如果出现问题，请发送技术报告';

  @override
  String get noDebugLogMessage => '暂无需要报告的问题。';

  @override
  String get clearDebugLogButton => '清除调试日志';

  @override
  String get clearDebugLogTitle => '要清除调试日志吗？';

  @override
  String get clearDebugLogBody => '这将删除设备上保存的技术报告。';

  @override
  String get debugLogClearedMessage => '调试日志已清除。';

  @override
  String get premiumUnlockLabel => '永久移除广告';

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

  @override
  String get legalAndSupportSectionTitle => 'Legal & Support';

  @override
  String get privacyPolicyRow => 'Privacy Policy';

  @override
  String get termsOfServiceRow => 'Terms of Service';

  @override
  String get supportRow => 'Support';

  @override
  String get openLinkFailedMessage =>
      'Couldn\'t open the link. Please try again.';
}
