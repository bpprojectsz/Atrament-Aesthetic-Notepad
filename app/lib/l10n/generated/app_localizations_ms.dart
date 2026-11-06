// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'Cuba lagi';

  @override
  String get errorGeneric => 'Sesuatu tidak kena';

  @override
  String get cancel => 'Batal';

  @override
  String get save => 'Simpan';

  @override
  String get delete => 'Padam';

  @override
  String get undo => 'Buat asal';

  @override
  String get redo => 'Buat semula';

  @override
  String get untitledNote => 'Tanpa tajuk';

  @override
  String get deleteConfirmBody => 'Tindakan ini tidak boleh dibuat asal.';

  @override
  String get deleteNoteTitle => 'Padam nota ini?';

  @override
  String deleteNotebookTitle(String name) {
    return 'Padam “$name”?';
  }

  @override
  String get saveFailedMessage => 'Gagal menyimpan. Sila cuba lagi.';

  @override
  String get exportFailedMessage =>
      'Gagal mengeksport nota ini. Sila cuba lagi.';

  @override
  String get shareFailedMessage => 'Gagal membuka menu kongsi. Sila cuba lagi.';

  @override
  String get settingsTitle => 'Tetapan';

  @override
  String get searchHint => 'Cari nota';

  @override
  String get emptyNotebooksTitle => 'Belum ada buku nota';

  @override
  String get emptyNotebooksBody =>
      'Cipta buku nota pertama anda untuk mula menulis.';

  @override
  String get emptySearchTitle => 'Tiada hasil';

  @override
  String get emptySearchBody => 'Cuba kata carian lain.';

  @override
  String get emptyNotebookTitle => 'Belum ada nota';

  @override
  String get emptyNotebookBody => 'Ketik + untuk menulis nota pertama anda.';

  @override
  String get newNotebookTitle => 'Buku nota baharu';

  @override
  String get notebookNameHint => 'Nama buku nota';

  @override
  String get newNoteTitle => 'Nota baharu';

  @override
  String get sortOptionsTitle => 'Isih';

  @override
  String get sortByModified => 'Kali terakhir disunting';

  @override
  String get sortByCreated => 'Tarikh dicipta';

  @override
  String get sortByTitle => 'Tajuk';

  @override
  String get formatBold => 'Tebal';

  @override
  String get formatItalic => 'Condong';

  @override
  String get formatUnderline => 'Garis bawah';

  @override
  String get formatHeading => 'Tajuk bahagian';

  @override
  String get formatBulletList => 'Senarai berpeluru';

  @override
  String get formatChecklist => 'Senarai semak';

  @override
  String get formatQuote => 'Petikan';

  @override
  String get formatCodeBlock => 'Blok kod';

  @override
  String get penFountainPen => 'Pen dakwat';

  @override
  String get penGelPen => 'Pen gel';

  @override
  String get penPencil => 'Pensel';

  @override
  String get penHighlighter => 'Penyerlah';

  @override
  String get penEraser => 'Pemadam';

  @override
  String get penStrokeWidth => 'Ketebalan garis';

  @override
  String get toggleHandwritingMode => 'Tukar antara menaip dan melukis';

  @override
  String get biometricLockReason => 'Buka kunci untuk melihat nota';

  @override
  String get noteLockedMessage => 'Nota ini dikunci';

  @override
  String get unlockButton => 'Buka kunci';

  @override
  String get noteLockTurnedOffMessage =>
      'Kunci nota dimatikan kerana peranti ini tidak mempunyai kunci skrin atau biometrik yang ditetapkan.';

  @override
  String get biometricEnableReason =>
      'Sahkan identiti anda untuk menghidupkan kunci nota';

  @override
  String get biometricDisableReason =>
      'Sahkan identiti anda untuk mematikan kunci nota';

  @override
  String get biometricShareReason =>
      'Buka kunci untuk berkongsi atau mengeksport nota ini';

  @override
  String get biometricAuthFailedMessage =>
      'Identiti anda tidak dapat disahkan.';

  @override
  String get biometricSetupNeededMessage =>
      'Tetapkan kunci skrin atau cap jari dahulu dalam tetapan peranti.';

  @override
  String get privacyChoicesTitle => 'Pilihan privasi';

  @override
  String get purchaseFailedMessage =>
      'Pembelian tidak dapat diselesaikan. Sila cuba lagi.';

  @override
  String get restoreSuccessMessage => 'Pembelian anda telah dipulihkan.';

  @override
  String get restoreNothingFoundMessage =>
      'Tiada pembelian terdahulu ditemui untuk akaun ini.';

  @override
  String get restoreFailedMessage =>
      'Pembelian tidak dapat dipulihkan. Semak sambungan anda dan cuba lagi.';

  @override
  String get reminderScheduleFailedMessage =>
      'Peringatan tidak dapat dijadualkan. Sila cuba lagi.';

  @override
  String get storageIssueNotebooksLoad =>
      'Sesetengah buku nota tidak dapat dimuatkan. Memaparkan yang tersedia.';

  @override
  String get storageIssueNotebookSave =>
      'Buku nota ini mungkin belum disimpan. Sila cuba lagi.';

  @override
  String get storageIssueNotebookChange =>
      'Perubahan ini mungkin belum disimpan. Sila cuba lagi.';

  @override
  String get storageIssueNotebookDelete =>
      'Buku nota tidak dapat dipadam. Sila cuba lagi.';

  @override
  String get storageIssueNotebookOrder =>
      'Susunan baharu mungkin belum disimpan. Sila cuba lagi.';

  @override
  String get storageIssueNotesLoad =>
      'Sesetengah nota tidak dapat dimuatkan. Memaparkan yang tersedia.';

  @override
  String get storageIssueSearch =>
      'Hasil carian mungkin tidak lengkap buat masa ini.';

  @override
  String get storageIssueNoteSave =>
      'Nota ini mungkin belum disimpan. Semak storan peranti anda.';

  @override
  String get storageIssueNoteDelete =>
      'Nota tidak dapat dipadam. Sila cuba lagi.';

  @override
  String get purchaseUnavailableMessage =>
      'Pembelian ini tidak tersedia buat masa ini. Sila cuba lagi nanti.';

  @override
  String get exportTitle => 'Eksport';

  @override
  String get exportAsTxt => 'Eksport sebagai teks';

  @override
  String get exportAsPdf => 'Eksport sebagai PDF';

  @override
  String get paperStyleSectionTitle => 'Gaya kertas';

  @override
  String get paperStyleLined => 'Bergaris';

  @override
  String get paperStyleDotGrid => 'Bertitik';

  @override
  String get paperStyleGrid => 'Berpetak';

  @override
  String get paperStyleBlank => 'Kosong';

  @override
  String get paperStyleCream => 'Krim';

  @override
  String get paperStyleParchment => 'Perkamen';

  @override
  String get paperStyleVellum => 'Vellum';

  @override
  String get fontSectionTitle => 'Fon nota';

  @override
  String get fontSystem => 'Sistem';

  @override
  String get fontSerif => 'Serif';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'Penampilan';

  @override
  String get themeLight => 'Cerah';

  @override
  String get themeDark => 'Gelap';

  @override
  String get themeParchment => 'Perkamen';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get verseSectionTitle => 'Paparan ayat Alkitab harian';

  @override
  String get verseModeWatermark => 'Tera air';

  @override
  String get verseModeHeader => 'Tajuk bahagian';

  @override
  String get verseModeFooter => 'Pengaki';

  @override
  String get verseModeOff => 'Mati';

  @override
  String get notificationsSectionTitle => 'Pemberitahuan';

  @override
  String get dailyReminderToggle => 'Peringatan ayat Alkitab harian';

  @override
  String get reminderTimeLabel => 'Masa peringatan';

  @override
  String get notificationPermissionDenied =>
      'Pemberitahuan dimatikan dalam tetapan sistem.';

  @override
  String get dailyReminderBody => 'Ayat Alkitab harian anda sudah sedia.';

  @override
  String get privacySectionTitle => 'Privasi';

  @override
  String get biometricLockToggle => 'Kunci nota dengan Face ID / cap jari';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get removeAdsTitle => 'Alih keluar iklan';

  @override
  String get restorePurchasesButton => 'Pulihkan pembelian';

  @override
  String get proLabel => 'Pro';

  @override
  String get engagementSectionTitle => 'Lagi';

  @override
  String get rateAppTitle => 'Nilaikan Atrament';

  @override
  String get rateAppSubtitle => 'Suka aplikasi ini? Tinggalkan ulasan';

  @override
  String get shareAppTitle => 'Kongsi Atrament';

  @override
  String get shareAppSubtitle => 'Beritahu seorang rakan';

  @override
  String get shareAppMessage =>
      'Cuba Atrament, buku nota tanpa gangguan dengan tekstur kertas.';

  @override
  String get languageSectionTitle => 'Bahasa';

  @override
  String get languageFollowsSystem => 'Mengikut tetapan bahasa peranti';

  @override
  String get languageSystem => 'Lalai sistem';

  @override
  String get languagePickerTitle => 'Pilih bahasa';

  @override
  String get premiumScreenTitle => 'Alih keluar iklan';

  @override
  String get premiumHeadline => 'Menulis tanpa gangguan';

  @override
  String get premiumBody =>
      'Atrament percuma dan hanya memaparkan satu sepanduk iklan kecil. Mengalih keluar iklan ialah pembelian sekali sahaja yang tidak membuka apa-apa lagi: semua ciri sudah menjadi milik anda.';

  @override
  String get premiumRestoreButton => 'Pulihkan pembelian';

  @override
  String get premiumAlreadyProMessage =>
      'Anda sudah mempunyai “Alih keluar iklan”. Terima kasih!';

  @override
  String get supportSectionTitle => 'Sokongan';

  @override
  String get shareDebugLogButton => 'Kongsi log nyahpepijat';

  @override
  String get shareDebugLogSubtitle =>
      'Hantar laporan teknikal jika ada sesuatu yang tidak berfungsi';

  @override
  String get noDebugLogMessage => 'Belum ada apa-apa untuk dilaporkan.';

  @override
  String get clearDebugLogButton => 'Kosongkan log nyahpepijat';

  @override
  String get clearDebugLogTitle => 'Kosongkan log nyahpepijat?';

  @override
  String get clearDebugLogBody =>
      'Laporan teknikal yang disimpan akan dialih keluar daripada peranti anda.';

  @override
  String get debugLogClearedMessage => 'Log nyahpepijat telah dikosongkan.';

  @override
  String get premiumUnlockLabel => 'Alih keluar iklan selama-lamanya';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'Semua';

  @override
  String get chipNotebooks => 'Buku nota';

  @override
  String get chipRecent => 'Terkini';

  @override
  String get emptyAllNotesTitle => 'Belum ada nota';

  @override
  String get emptyAllNotesBody => 'Ketik + untuk menulis nota pertama anda.';

  @override
  String get emptyRecentNotesTitle => 'Tiada yang terkini';

  @override
  String get emptyRecentNotesBody =>
      'Nota yang anda sunting akan muncul di sini.';

  @override
  String get noteActionRename => 'Namakan semula';

  @override
  String get noteActionMoveToNotebook => 'Alih ke buku nota';

  @override
  String get noteActionEdit => 'Sunting';

  @override
  String get noteActionExport => 'Eksport';

  @override
  String get noteActionShare => 'Kongsi';

  @override
  String get moveToNotebookTitle => 'Alih ke buku nota';

  @override
  String get moveToNotebookEmptyBody =>
      'Belum ada buku nota lain. Cipta satu untuk mengatur nota ini.';

  @override
  String get moveToNotebookCreateRow => 'Cipta buku nota baharu';

  @override
  String get notebookActionRename => 'Namakan semula';

  @override
  String get notebookActionChangeCover => 'Tukar kulit';

  @override
  String get notebookRenameDialogTitle => 'Namakan semula buku nota';

  @override
  String get notebookCoverPickerTitle => 'Pilih warna kulit';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'Buku nota akan dipadam bersama semua nota di dalamnya (jumlah: $count). Tindakan ini tidak boleh dibuat asal.';
  }

  @override
  String get legalAndSupportSectionTitle => 'Perundangan dan sokongan';

  @override
  String get privacyPolicyRow => 'Dasar Privasi';

  @override
  String get termsOfServiceRow => 'Syarat Perkhidmatan';

  @override
  String get supportRow => 'Sokongan';

  @override
  String get openLinkFailedMessage =>
      'Pautan tidak dapat dibuka. Sila cuba lagi.';

  @override
  String get openSourceLicensesRow => 'Lesen sumber terbuka';
}
