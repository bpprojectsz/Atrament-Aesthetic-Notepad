// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => '再試行';

  @override
  String get errorGeneric => '問題が発生しました';

  @override
  String get cancel => 'キャンセル';

  @override
  String get save => '保存';

  @override
  String get delete => '削除';

  @override
  String get undo => '元に戻す';

  @override
  String get redo => 'やり直す';

  @override
  String get untitledNote => '無題';

  @override
  String get deleteConfirmBody => 'この操作は取り消せません。';

  @override
  String get deleteNoteTitle => 'このノートを削除しますか？';

  @override
  String deleteNotebookTitle(String name) {
    return '「$name」を削除しますか？';
  }

  @override
  String get saveFailedMessage => '保存できませんでした。もう一度お試しください。';

  @override
  String get exportFailedMessage => 'このノートをエクスポートできませんでした。もう一度お試しください。';

  @override
  String get shareFailedMessage => '共有シートを開けませんでした。もう一度お試しください。';

  @override
  String get settingsTitle => '設定';

  @override
  String get searchHint => 'ノートを検索';

  @override
  String get emptyNotebooksTitle => 'ノートブックはまだありません';

  @override
  String get emptyNotebooksBody => '最初のノートブックを作成して書き始めましょう。';

  @override
  String get emptySearchTitle => '結果がありません';

  @override
  String get emptySearchBody => '別の検索語を試してください。';

  @override
  String get emptyNotebookTitle => 'ノートはまだありません';

  @override
  String get emptyNotebookBody => '+ボタンをタップして最初のノートを書きましょう。';

  @override
  String get newNotebookTitle => '新規ノートブック';

  @override
  String get notebookNameHint => 'ノートブック名';

  @override
  String get newNoteTitle => '新規ノート';

  @override
  String get sortOptionsTitle => '並べ替え';

  @override
  String get sortByModified => '最終編集日';

  @override
  String get sortByCreated => '作成日';

  @override
  String get sortByTitle => 'タイトル';

  @override
  String get formatBold => '太字';

  @override
  String get formatItalic => '斜体';

  @override
  String get formatUnderline => '下線';

  @override
  String get formatHeading => '見出し';

  @override
  String get formatBulletList => '箇条書き';

  @override
  String get formatChecklist => 'チェックリスト';

  @override
  String get formatQuote => '引用';

  @override
  String get formatCodeBlock => 'コードブロック';

  @override
  String get penFountainPen => '万年筆';

  @override
  String get penGelPen => 'ジェルペン';

  @override
  String get penPencil => '鉛筆';

  @override
  String get penHighlighter => 'ハイライター';

  @override
  String get penEraser => '消しゴム';

  @override
  String get penStrokeWidth => '線の太さ';

  @override
  String get toggleHandwritingMode => '入力と手書きを切り替える';

  @override
  String get biometricLockReason => 'このノートを表示するにはロックを解除してください';

  @override
  String get noteLockedMessage => 'このノートはロックされています';

  @override
  String get unlockButton => 'ロック解除';

  @override
  String get exportTitle => 'エクスポート';

  @override
  String get exportAsTxt => 'テキストとしてエクスポート';

  @override
  String get exportAsPdf => 'PDFとしてエクスポート';

  @override
  String get paperStyleSectionTitle => '用紙スタイル';

  @override
  String get paperStyleLined => '罫線';

  @override
  String get paperStyleDotGrid => 'ドット方眼';

  @override
  String get paperStyleGrid => '方眼';

  @override
  String get paperStyleBlank => '無地';

  @override
  String get paperStyleCream => 'クリーム';

  @override
  String get paperStyleParchment => '羊皮紙';

  @override
  String get paperStyleVellum => 'ベラム紙';

  @override
  String get fontSectionTitle => 'ノートのフォント';

  @override
  String get fontSystem => 'システム';

  @override
  String get fontSerif => 'セリフ体';

  @override
  String get themeSectionTitle => '外観';

  @override
  String get themeLight => 'ライト';

  @override
  String get themeDark => 'ダーク';

  @override
  String get themeParchment => 'パーチメント';

  @override
  String get themeSystem => 'システム';

  @override
  String get verseSectionTitle => 'デイリーバース表示';

  @override
  String get verseModeWatermark => '透かし';

  @override
  String get verseModeHeader => 'ヘッダー';

  @override
  String get verseModeFooter => 'フッター';

  @override
  String get verseModeOff => 'オフ';

  @override
  String get notificationsSectionTitle => '通知';

  @override
  String get dailyReminderToggle => 'デイリーバースのリマインダー';

  @override
  String get reminderTimeLabel => 'リマインダー時刻';

  @override
  String get notificationPermissionDenied => 'システム設定で通知がオフになっています。';

  @override
  String get dailyReminderBody => '本日の聖句の準備ができました。';

  @override
  String get privacySectionTitle => 'プライバシー';

  @override
  String get biometricLockToggle => 'Face ID / 指紋でノートをロック';

  @override
  String get premiumSectionTitle => 'プレミアム';

  @override
  String get removeAdsTitle => '広告を削除';

  @override
  String get restorePurchasesButton => '購入を復元';

  @override
  String get proLabel => 'Pro';

  @override
  String get engagementSectionTitle => 'その他';

  @override
  String get rateAppTitle => 'Atrament を評価';

  @override
  String get rateAppSubtitle => 'アプリは気に入りましたか？レビューを残す';

  @override
  String get shareAppTitle => 'Atrament を共有';

  @override
  String get shareAppSubtitle => '友達に伝える';

  @override
  String get shareAppMessage => 'Atrament を試す — 紙の質感を備えた集中できるノートパッド。';

  @override
  String get languageSectionTitle => '言語';

  @override
  String get languageFollowsSystem => 'デバイスの言語設定に従います';

  @override
  String get languageSystem => 'システムのデフォルト';

  @override
  String get languagePickerTitle => '言語を選択';

  @override
  String get premiumScreenTitle => '広告を削除';

  @override
  String get premiumHeadline => '気を散らさずに書く';

  @override
  String get premiumBody =>
      'Atrament は小さなバナー広告付きで無料です。広告の削除は一度きりの購入で、他の機能は何もロックされていません — すべての機能はすでにあなたのものです。';

  @override
  String get premiumRestoreButton => '購入を復元';

  @override
  String get premiumAlreadyProMessage => 'すでに広告削除をご利用中です。ありがとうございます！';

  @override
  String get supportSectionTitle => 'サポート';

  @override
  String get shareDebugLogButton => 'デバッグログを共有';

  @override
  String get shareDebugLogSubtitle => '不具合がある場合は技術レポートを送信してください';

  @override
  String get noDebugLogMessage => '報告する問題はまだありません。';

  @override
  String get clearDebugLogButton => 'デバッグログを消去';

  @override
  String get clearDebugLogTitle => 'デバッグログを消去しますか？';

  @override
  String get clearDebugLogBody => 'デバイスに保存されている技術レポートが削除されます。';

  @override
  String get debugLogClearedMessage => 'デバッグログを消去しました。';

  @override
  String get premiumUnlockLabel => '広告を完全に削除';

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
}
