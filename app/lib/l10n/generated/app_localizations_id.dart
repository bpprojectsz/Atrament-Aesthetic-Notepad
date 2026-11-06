// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'Coba lagi';

  @override
  String get errorGeneric => 'Terjadi kesalahan';

  @override
  String get cancel => 'Batal';

  @override
  String get save => 'Simpan';

  @override
  String get delete => 'Hapus';

  @override
  String get undo => 'Urungkan';

  @override
  String get redo => 'Ulangi';

  @override
  String get untitledNote => 'Tanpa judul';

  @override
  String get deleteConfirmBody => 'Tindakan ini tidak dapat dibatalkan.';

  @override
  String get deleteNoteTitle => 'Hapus catatan ini?';

  @override
  String deleteNotebookTitle(String name) {
    return 'Hapus “$name”?';
  }

  @override
  String get saveFailedMessage => 'Gagal menyimpan. Silakan coba lagi.';

  @override
  String get exportFailedMessage =>
      'Gagal mengekspor catatan ini. Silakan coba lagi.';

  @override
  String get shareFailedMessage =>
      'Gagal membuka menu bagikan. Silakan coba lagi.';

  @override
  String get settingsTitle => 'Pengaturan';

  @override
  String get searchHint => 'Cari catatan';

  @override
  String get emptyNotebooksTitle => 'Belum ada buku catatan';

  @override
  String get emptyNotebooksBody =>
      'Buat buku catatan pertama Anda untuk mulai menulis.';

  @override
  String get emptySearchTitle => 'Tidak ada hasil';

  @override
  String get emptySearchBody => 'Coba kata pencarian lain.';

  @override
  String get emptyNotebookTitle => 'Belum ada catatan';

  @override
  String get emptyNotebookBody => 'Ketuk + untuk menulis catatan pertama Anda.';

  @override
  String get newNotebookTitle => 'Buku catatan baru';

  @override
  String get notebookNameHint => 'Nama buku catatan';

  @override
  String get newNoteTitle => 'Catatan baru';

  @override
  String get sortOptionsTitle => 'Urutkan';

  @override
  String get sortByModified => 'Terakhir diedit';

  @override
  String get sortByCreated => 'Tanggal dibuat';

  @override
  String get sortByTitle => 'Judul';

  @override
  String get formatBold => 'Tebal';

  @override
  String get formatItalic => 'Miring';

  @override
  String get formatUnderline => 'Garis bawah';

  @override
  String get formatHeading => 'Judul';

  @override
  String get formatBulletList => 'Daftar berpoin';

  @override
  String get formatChecklist => 'Daftar periksa';

  @override
  String get formatQuote => 'Kutipan';

  @override
  String get formatCodeBlock => 'Blok kode';

  @override
  String get penFountainPen => 'Pena tinta';

  @override
  String get penGelPen => 'Pulpen gel';

  @override
  String get penPencil => 'Pensil';

  @override
  String get penHighlighter => 'Stabilo';

  @override
  String get penEraser => 'Penghapus';

  @override
  String get penStrokeWidth => 'Ketebalan garis';

  @override
  String get toggleHandwritingMode => 'Beralih antara mengetik dan menggambar';

  @override
  String get biometricLockReason => 'Buka kunci untuk melihat catatan';

  @override
  String get noteLockedMessage => 'Catatan ini terkunci';

  @override
  String get unlockButton => 'Buka kunci';

  @override
  String get noteLockTurnedOffMessage =>
      'Kunci catatan dinonaktifkan karena perangkat ini belum memiliki kunci layar atau biometrik.';

  @override
  String get biometricEnableReason =>
      'Verifikasi identitas Anda untuk mengaktifkan kunci catatan';

  @override
  String get biometricDisableReason =>
      'Verifikasi identitas Anda untuk menonaktifkan kunci catatan';

  @override
  String get biometricShareReason =>
      'Buka kunci untuk membagikan atau mengekspor catatan ini';

  @override
  String get biometricAuthFailedMessage =>
      'Identitas Anda tidak dapat diverifikasi.';

  @override
  String get biometricSetupNeededMessage =>
      'Atur kunci layar atau sidik jari terlebih dahulu di pengaturan perangkat.';

  @override
  String get privacyChoicesTitle => 'Pilihan privasi';

  @override
  String get purchaseFailedMessage =>
      'Pembelian tidak dapat diselesaikan. Silakan coba lagi.';

  @override
  String get restoreSuccessMessage => 'Pembelian Anda telah dipulihkan.';

  @override
  String get restoreNothingFoundMessage =>
      'Tidak ditemukan pembelian sebelumnya untuk akun ini.';

  @override
  String get restoreFailedMessage =>
      'Pembelian tidak dapat dipulihkan. Periksa koneksi Anda dan coba lagi.';

  @override
  String get reminderScheduleFailedMessage =>
      'Pengingat tidak dapat dijadwalkan. Silakan coba lagi.';

  @override
  String get storageIssueNotebooksLoad =>
      'Beberapa buku catatan tidak dapat dimuat. Menampilkan yang tersedia.';

  @override
  String get storageIssueNotebookSave =>
      'Buku catatan ini mungkin belum tersimpan. Silakan coba lagi.';

  @override
  String get storageIssueNotebookChange =>
      'Perubahan ini mungkin belum tersimpan. Silakan coba lagi.';

  @override
  String get storageIssueNotebookDelete =>
      'Buku catatan tidak dapat dihapus. Silakan coba lagi.';

  @override
  String get storageIssueNotebookOrder =>
      'Urutan baru mungkin belum tersimpan. Silakan coba lagi.';

  @override
  String get storageIssueNotesLoad =>
      'Beberapa catatan tidak dapat dimuat. Menampilkan yang tersedia.';

  @override
  String get storageIssueSearch =>
      'Hasil pencarian mungkin belum lengkap saat ini.';

  @override
  String get storageIssueNoteSave =>
      'Catatan ini mungkin belum tersimpan. Periksa penyimpanan perangkat Anda.';

  @override
  String get storageIssueNoteDelete =>
      'Catatan tidak dapat dihapus. Silakan coba lagi.';

  @override
  String get purchaseUnavailableMessage =>
      'Pembelian ini sedang tidak tersedia. Silakan coba lagi nanti.';

  @override
  String get exportTitle => 'Ekspor';

  @override
  String get exportAsTxt => 'Ekspor sebagai teks';

  @override
  String get exportAsPdf => 'Ekspor sebagai PDF';

  @override
  String get paperStyleSectionTitle => 'Gaya kertas';

  @override
  String get paperStyleLined => 'Bergaris';

  @override
  String get paperStyleDotGrid => 'Titik-titik';

  @override
  String get paperStyleGrid => 'Kotak-kotak';

  @override
  String get paperStyleBlank => 'Kosong';

  @override
  String get paperStyleCream => 'Krem';

  @override
  String get paperStyleParchment => 'Perkamen';

  @override
  String get paperStyleVellum => 'Velum';

  @override
  String get fontSectionTitle => 'Font catatan';

  @override
  String get fontSystem => 'Sistem';

  @override
  String get fontSerif => 'Serif';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'Tampilan';

  @override
  String get themeLight => 'Terang';

  @override
  String get themeDark => 'Gelap';

  @override
  String get themeParchment => 'Perkamen';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get verseSectionTitle => 'Tampilan ayat Alkitab harian';

  @override
  String get verseModeWatermark => 'Tanda air';

  @override
  String get verseModeHeader => 'Header';

  @override
  String get verseModeFooter => 'Footer';

  @override
  String get verseModeOff => 'Mati';

  @override
  String get notificationsSectionTitle => 'Notifikasi';

  @override
  String get dailyReminderToggle => 'Pengingat ayat Alkitab harian';

  @override
  String get reminderTimeLabel => 'Waktu pengingat';

  @override
  String get notificationPermissionDenied =>
      'Notifikasi dinonaktifkan di pengaturan sistem.';

  @override
  String get dailyReminderBody => 'Ayat Alkitab harian Anda sudah siap.';

  @override
  String get privacySectionTitle => 'Privasi';

  @override
  String get biometricLockToggle => 'Kunci catatan dengan Face ID / sidik jari';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get removeAdsTitle => 'Hapus iklan';

  @override
  String get restorePurchasesButton => 'Pulihkan pembelian';

  @override
  String get proLabel => 'Pro';

  @override
  String get engagementSectionTitle => 'Lainnya';

  @override
  String get rateAppTitle => 'Beri nilai Atrament';

  @override
  String get rateAppSubtitle => 'Suka aplikasinya? Tinggalkan ulasan';

  @override
  String get shareAppTitle => 'Bagikan Atrament';

  @override
  String get shareAppSubtitle => 'Ceritakan kepada teman';

  @override
  String get shareAppMessage =>
      'Cobalah Atrament, buku catatan tanpa gangguan dengan tekstur kertas.';

  @override
  String get languageSectionTitle => 'Bahasa';

  @override
  String get languageFollowsSystem => 'Mengikuti pengaturan bahasa perangkat';

  @override
  String get languageSystem => 'Default sistem';

  @override
  String get languagePickerTitle => 'Pilih bahasa';

  @override
  String get premiumScreenTitle => 'Hapus iklan';

  @override
  String get premiumHeadline => 'Menulis tanpa gangguan';

  @override
  String get premiumBody =>
      'Atrament gratis dan hanya menampilkan satu banner iklan kecil. Menghapus iklan adalah pembelian sekali bayar yang tidak membuka hal lain: semua fitur sudah menjadi milik Anda.';

  @override
  String get premiumRestoreButton => 'Pulihkan pembelian';

  @override
  String get premiumAlreadyProMessage =>
      'Anda sudah memiliki “Hapus iklan”. Terima kasih!';

  @override
  String get supportSectionTitle => 'Dukungan';

  @override
  String get shareDebugLogButton => 'Bagikan log debug';

  @override
  String get shareDebugLogSubtitle =>
      'Kirim laporan teknis jika ada yang tidak berfungsi';

  @override
  String get noDebugLogMessage => 'Belum ada yang perlu dilaporkan.';

  @override
  String get clearDebugLogButton => 'Hapus log debug';

  @override
  String get clearDebugLogTitle => 'Hapus log debug?';

  @override
  String get clearDebugLogBody =>
      'Laporan teknis yang tersimpan akan dihapus dari perangkat Anda.';

  @override
  String get debugLogClearedMessage => 'Log debug dihapus.';

  @override
  String get premiumUnlockLabel => 'Hapus iklan selamanya';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'Semua';

  @override
  String get chipNotebooks => 'Buku catatan';

  @override
  String get chipRecent => 'Terbaru';

  @override
  String get emptyAllNotesTitle => 'Belum ada catatan';

  @override
  String get emptyAllNotesBody => 'Ketuk + untuk menulis catatan pertama Anda.';

  @override
  String get emptyRecentNotesTitle => 'Tidak ada yang terbaru';

  @override
  String get emptyRecentNotesBody =>
      'Catatan yang Anda edit akan muncul di sini.';

  @override
  String get noteActionRename => 'Ubah nama';

  @override
  String get noteActionMoveToNotebook => 'Pindahkan ke buku catatan';

  @override
  String get noteActionEdit => 'Edit';

  @override
  String get noteActionExport => 'Ekspor';

  @override
  String get noteActionShare => 'Bagikan';

  @override
  String get moveToNotebookTitle => 'Pindahkan ke buku catatan';

  @override
  String get moveToNotebookEmptyBody =>
      'Belum ada buku catatan lain. Buat satu untuk mengatur catatan ini.';

  @override
  String get moveToNotebookCreateRow => 'Buat buku catatan baru';

  @override
  String get notebookActionRename => 'Ubah nama';

  @override
  String get notebookActionChangeCover => 'Ganti sampul';

  @override
  String get notebookRenameDialogTitle => 'Ubah nama buku catatan';

  @override
  String get notebookCoverPickerTitle => 'Pilih warna sampul';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'Buku catatan akan dihapus beserta semua catatan di dalamnya (total: $count). Tindakan ini tidak dapat dibatalkan.';
  }

  @override
  String get legalAndSupportSectionTitle => 'Hukum dan dukungan';

  @override
  String get privacyPolicyRow => 'Kebijakan Privasi';

  @override
  String get termsOfServiceRow => 'Ketentuan Layanan';

  @override
  String get supportRow => 'Dukungan';

  @override
  String get openLinkFailedMessage =>
      'Tautan tidak dapat dibuka. Silakan coba lagi.';

  @override
  String get openSourceLicensesRow => 'Lisensi sumber terbuka';
}
