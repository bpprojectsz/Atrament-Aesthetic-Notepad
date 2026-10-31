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
  String get noteLockTurnedOffMessage => '由于此设备未设置屏幕锁定或生物识别，笔记锁定已关闭。';

  @override
  String get biometricEnableReason => '请验证身份以开启笔记锁定';

  @override
  String get biometricDisableReason => '请验证身份以关闭笔记锁定';

  @override
  String get biometricShareReason => '解锁后即可分享或导出此笔记';

  @override
  String get biometricAuthFailedMessage => '无法验证你的身份。';

  @override
  String get biometricSetupNeededMessage => '请先在设备设置中设置屏幕锁定或指纹。';

  @override
  String get privacyChoicesTitle => '隐私选择';

  @override
  String get purchaseFailedMessage => '无法完成购买，请重试。';

  @override
  String get restoreSuccessMessage => '已恢复你的购买。';

  @override
  String get restoreNothingFoundMessage => '未找到此账户的历史购买记录。';

  @override
  String get restoreFailedMessage => '无法恢复购买。请检查网络连接后重试。';

  @override
  String get reminderScheduleFailedMessage => '无法设置提醒，请重试。';

  @override
  String get storageIssueNotebooksLoad => '部分笔记本无法加载，正在显示可用内容。';

  @override
  String get storageIssueNotebookSave => '此笔记本可能未保存，请重试。';

  @override
  String get storageIssueNotebookChange => '此更改可能未保存，请重试。';

  @override
  String get storageIssueNotebookDelete => '无法删除此笔记本，请重试。';

  @override
  String get storageIssueNotebookOrder => '新的排序可能未保存，请重试。';

  @override
  String get storageIssueNotesLoad => '部分笔记无法加载，正在显示可用内容。';

  @override
  String get storageIssueSearch => '搜索结果目前可能不完整。';

  @override
  String get storageIssueNoteSave => '此笔记可能未保存，请检查设备存储空间。';

  @override
  String get storageIssueNoteDelete => '无法删除此笔记，请重试。';

  @override
  String get purchaseUnavailableMessage => '此购买目前不可用，请稍后再试。';

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
      'Atrament 免费使用，附带一个小型横幅广告。移除广告为一次性购买，不会解锁其他内容——所有功能已经属于你。';

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
  String get chipAll => '全部';

  @override
  String get chipNotebooks => '笔记本';

  @override
  String get chipRecent => '最近';

  @override
  String get emptyAllNotesTitle => '尚无笔记';

  @override
  String get emptyAllNotesBody => '点击 + 按钮写下你的第一条笔记。';

  @override
  String get emptyRecentNotesTitle => '暂无最近记录';

  @override
  String get emptyRecentNotesBody => '你编辑的笔记会显示在这里。';

  @override
  String get noteActionRename => '重命名';

  @override
  String get noteActionMoveToNotebook => '移动到笔记本';

  @override
  String get noteActionEdit => '编辑';

  @override
  String get noteActionExport => '导出';

  @override
  String get noteActionShare => '分享';

  @override
  String get moveToNotebookTitle => '移动到笔记本';

  @override
  String get moveToNotebookEmptyBody => '还没有其他笔记本。创建一个来整理这条笔记。';

  @override
  String get moveToNotebookCreateRow => '创建新笔记本';

  @override
  String get notebookActionRename => '重命名';

  @override
  String get notebookActionChangeCover => '更换封面';

  @override
  String get notebookRenameDialogTitle => '重命名笔记本';

  @override
  String get notebookCoverPickerTitle => '选择封面颜色';

  @override
  String deleteNotebookWithCountBody(int count) {
    return '这将删除该笔记本及其 $count 条笔记。此操作无法撤销。';
  }

  @override
  String get legalAndSupportSectionTitle => '法律与支持';

  @override
  String get privacyPolicyRow => '隐私政策';

  @override
  String get termsOfServiceRow => '服务条款';

  @override
  String get supportRow => '支持';

  @override
  String get openLinkFailedMessage => '无法打开链接。请重试。';

  @override
  String get openSourceLicensesRow => '开源许可';
}

/// The translations for Chinese, using the Han script (`zh_Hans`).
class AppLocalizationsZhHans extends AppLocalizationsZh {
  AppLocalizationsZhHans() : super('zh_Hans');
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get appName => 'Atrament';

  @override
  String get retry => '重試';

  @override
  String get errorGeneric => '發生錯誤';

  @override
  String get cancel => '取消';

  @override
  String get save => '儲存';

  @override
  String get delete => '刪除';

  @override
  String get undo => '復原';

  @override
  String get redo => '重做';

  @override
  String get untitledNote => '無標題';

  @override
  String get deleteConfirmBody => '此操作無法復原。';

  @override
  String get deleteNoteTitle => '要刪除這則筆記嗎？';

  @override
  String deleteNotebookTitle(String name) {
    return '要刪除「$name」嗎？';
  }

  @override
  String get saveFailedMessage => '儲存失敗，請再試一次。';

  @override
  String get exportFailedMessage => '無法匯出這則筆記，請再試一次。';

  @override
  String get shareFailedMessage => '無法開啟分享選單，請再試一次。';

  @override
  String get settingsTitle => '設定';

  @override
  String get searchHint => '搜尋筆記';

  @override
  String get emptyNotebooksTitle => '還沒有筆記本';

  @override
  String get emptyNotebooksBody => '建立你的第一本筆記本，開始書寫。';

  @override
  String get emptySearchTitle => '沒有結果';

  @override
  String get emptySearchBody => '試試其他搜尋字詞。';

  @override
  String get emptyNotebookTitle => '還沒有筆記';

  @override
  String get emptyNotebookBody => '點一下 + 按鈕，寫下第一則筆記。';

  @override
  String get newNotebookTitle => '新增筆記本';

  @override
  String get notebookNameHint => '筆記本名稱';

  @override
  String get newNoteTitle => '新增筆記';

  @override
  String get sortOptionsTitle => '排序';

  @override
  String get sortByModified => '最近編輯';

  @override
  String get sortByCreated => '建立日期';

  @override
  String get sortByTitle => '標題';

  @override
  String get formatBold => '粗體';

  @override
  String get formatItalic => '斜體';

  @override
  String get formatUnderline => '底線';

  @override
  String get formatHeading => '標題';

  @override
  String get formatBulletList => '項目符號清單';

  @override
  String get formatChecklist => '待辦清單';

  @override
  String get formatQuote => '引言';

  @override
  String get formatCodeBlock => '程式碼區塊';

  @override
  String get penFountainPen => '鋼筆';

  @override
  String get penGelPen => '中性筆';

  @override
  String get penPencil => '鉛筆';

  @override
  String get penHighlighter => '螢光筆';

  @override
  String get penEraser => '橡皮擦';

  @override
  String get penStrokeWidth => '筆畫粗細';

  @override
  String get toggleHandwritingMode => '在打字與手寫之間切換';

  @override
  String get biometricLockReason => '解鎖以檢視這則筆記';

  @override
  String get noteLockedMessage => '這則筆記已鎖定';

  @override
  String get unlockButton => '解鎖';

  @override
  String get noteLockTurnedOffMessage => '由於此裝置尚未設定螢幕鎖定或生物辨識，筆記鎖定已關閉。';

  @override
  String get biometricEnableReason => '請驗證身分以開啟筆記鎖定';

  @override
  String get biometricDisableReason => '請驗證身分以關閉筆記鎖定';

  @override
  String get biometricShareReason => '解鎖後即可分享或匯出這則筆記';

  @override
  String get biometricAuthFailedMessage => '無法驗證你的身分。';

  @override
  String get biometricSetupNeededMessage => '請先在裝置設定中設定螢幕鎖定或指紋。';

  @override
  String get privacyChoicesTitle => '隱私權選項';

  @override
  String get purchaseFailedMessage => '無法完成購買，請再試一次。';

  @override
  String get restoreSuccessMessage => '已還原你的購買項目。';

  @override
  String get restoreNothingFoundMessage => '找不到此帳號先前的購買紀錄。';

  @override
  String get restoreFailedMessage => '無法還原購買項目。請檢查網路連線後再試一次。';

  @override
  String get reminderScheduleFailedMessage => '無法設定提醒，請再試一次。';

  @override
  String get storageIssueNotebooksLoad => '部分筆記本無法載入，目前顯示可用的內容。';

  @override
  String get storageIssueNotebookSave => '這本筆記本可能尚未儲存，請再試一次。';

  @override
  String get storageIssueNotebookChange => '這項變更可能尚未儲存，請再試一次。';

  @override
  String get storageIssueNotebookDelete => '無法刪除這本筆記本，請再試一次。';

  @override
  String get storageIssueNotebookOrder => '新的排序可能尚未儲存，請再試一次。';

  @override
  String get storageIssueNotesLoad => '部分筆記無法載入，目前顯示可用的內容。';

  @override
  String get storageIssueSearch => '搜尋結果目前可能不完整。';

  @override
  String get storageIssueNoteSave => '這則筆記可能尚未儲存，請檢查裝置的儲存空間。';

  @override
  String get storageIssueNoteDelete => '無法刪除這則筆記，請再試一次。';

  @override
  String get purchaseUnavailableMessage => '目前無法購買此項目，請稍後再試。';

  @override
  String get exportTitle => '匯出';

  @override
  String get exportAsTxt => '匯出為文字檔';

  @override
  String get exportAsPdf => '匯出為 PDF';

  @override
  String get paperStyleSectionTitle => '紙張樣式';

  @override
  String get paperStyleLined => '橫線';

  @override
  String get paperStyleDotGrid => '點陣格線';

  @override
  String get paperStyleGrid => '方格';

  @override
  String get paperStyleBlank => '空白';

  @override
  String get paperStyleCream => '米色';

  @override
  String get paperStyleParchment => '羊皮紙';

  @override
  String get paperStyleVellum => '犢皮紙';

  @override
  String get fontSectionTitle => '筆記字型';

  @override
  String get fontSystem => '系統字型';

  @override
  String get fontSerif => '襯線字型';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => '外觀';

  @override
  String get themeLight => '淺色';

  @override
  String get themeDark => '深色';

  @override
  String get themeParchment => '羊皮紙';

  @override
  String get themeSystem => '系統';

  @override
  String get verseSectionTitle => '每日經文顯示方式';

  @override
  String get verseModeWatermark => '浮水印';

  @override
  String get verseModeHeader => '頁首';

  @override
  String get verseModeFooter => '頁尾';

  @override
  String get verseModeOff => '關閉';

  @override
  String get notificationsSectionTitle => '通知';

  @override
  String get dailyReminderToggle => '每日經文提醒';

  @override
  String get reminderTimeLabel => '提醒時間';

  @override
  String get notificationPermissionDenied => '系統設定中的通知已關閉。';

  @override
  String get dailyReminderBody => '你的每日經文已備妥。';

  @override
  String get privacySectionTitle => '隱私權';

  @override
  String get biometricLockToggle => '使用 Face ID／指紋鎖定筆記';

  @override
  String get premiumSectionTitle => '進階版';

  @override
  String get removeAdsTitle => '移除廣告';

  @override
  String get restorePurchasesButton => '還原購買項目';

  @override
  String get proLabel => '專業版';

  @override
  String get engagementSectionTitle => '更多';

  @override
  String get rateAppTitle => '為 Atrament 評分';

  @override
  String get rateAppSubtitle => '喜歡這個 App 嗎？歡迎留下評價';

  @override
  String get shareAppTitle => '分享 Atrament';

  @override
  String get shareAppSubtitle => '告訴朋友';

  @override
  String get shareAppMessage => '試試 Atrament——一款帶有紙張質感的無干擾記事本。';

  @override
  String get languageSectionTitle => '語言';

  @override
  String get languageFollowsSystem => '跟隨裝置的語言設定';

  @override
  String get languageSystem => '系統預設';

  @override
  String get languagePickerTitle => '選擇語言';

  @override
  String get premiumScreenTitle => '移除廣告';

  @override
  String get premiumHeadline => '專心書寫，不受打擾';

  @override
  String get premiumBody =>
      'Atrament 可免費使用，僅顯示一個小型橫幅廣告。移除廣告為一次性購買，不會解鎖其他內容——所有功能本來就已屬於你。';

  @override
  String get premiumRestoreButton => '還原購買項目';

  @override
  String get premiumAlreadyProMessage => '你已擁有「移除廣告」功能，謝謝！';

  @override
  String get supportSectionTitle => '支援';

  @override
  String get shareDebugLogButton => '分享偵錯記錄';

  @override
  String get shareDebugLogSubtitle => '若有功能無法正常運作，可傳送技術報告';

  @override
  String get noDebugLogMessage => '目前沒有需要回報的問題。';

  @override
  String get clearDebugLogButton => '清除偵錯記錄';

  @override
  String get clearDebugLogTitle => '要清除偵錯記錄嗎？';

  @override
  String get clearDebugLogBody => '這會從你的裝置移除已儲存的技術報告。';

  @override
  String get debugLogClearedMessage => '已清除偵錯記錄。';

  @override
  String get premiumUnlockLabel => '永久移除廣告';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => '全部';

  @override
  String get chipNotebooks => '筆記本';

  @override
  String get chipRecent => '最近';

  @override
  String get emptyAllNotesTitle => '還沒有筆記';

  @override
  String get emptyAllNotesBody => '點一下 + 按鈕，寫下你的第一則筆記。';

  @override
  String get emptyRecentNotesTitle => '沒有最近的內容';

  @override
  String get emptyRecentNotesBody => '你編輯過的筆記會顯示在這裡。';

  @override
  String get noteActionRename => '重新命名';

  @override
  String get noteActionMoveToNotebook => '移至筆記本';

  @override
  String get noteActionEdit => '編輯';

  @override
  String get noteActionExport => '匯出';

  @override
  String get noteActionShare => '分享';

  @override
  String get moveToNotebookTitle => '移至筆記本';

  @override
  String get moveToNotebookEmptyBody => '還沒有其他筆記本。建立一本來整理這則筆記。';

  @override
  String get moveToNotebookCreateRow => '建立新筆記本';

  @override
  String get notebookActionRename => '重新命名';

  @override
  String get notebookActionChangeCover => '更換封面';

  @override
  String get notebookRenameDialogTitle => '重新命名筆記本';

  @override
  String get notebookCoverPickerTitle => '選擇封面顏色';

  @override
  String deleteNotebookWithCountBody(int count) {
    return '這會刪除此筆記本及其中的 $count 則筆記，且無法復原。';
  }

  @override
  String get legalAndSupportSectionTitle => '法律與支援';

  @override
  String get privacyPolicyRow => '隱私權政策';

  @override
  String get termsOfServiceRow => '服務條款';

  @override
  String get supportRow => '支援';

  @override
  String get openLinkFailedMessage => '無法開啟連結，請再試一次。';

  @override
  String get openSourceLicensesRow => '開放原始碼授權';
}
