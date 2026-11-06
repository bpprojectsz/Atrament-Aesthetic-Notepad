// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'Tekrar dene';

  @override
  String get errorGeneric => 'Bir şeyler ters gitti';

  @override
  String get cancel => 'İptal';

  @override
  String get save => 'Kaydet';

  @override
  String get delete => 'Sil';

  @override
  String get undo => 'Geri al';

  @override
  String get redo => 'Yinele';

  @override
  String get untitledNote => 'Başlıksız';

  @override
  String get deleteConfirmBody => 'Bu işlem geri alınamaz.';

  @override
  String get deleteNoteTitle => 'Bu not silinsin mi?';

  @override
  String deleteNotebookTitle(String name) {
    return '“$name” silinsin mi?';
  }

  @override
  String get saveFailedMessage => 'Kaydedilemedi. Lütfen tekrar deneyin.';

  @override
  String get exportFailedMessage =>
      'Not dışa aktarılamadı. Lütfen tekrar deneyin.';

  @override
  String get shareFailedMessage =>
      'Paylaşım menüsü açılamadı. Lütfen tekrar deneyin.';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get searchHint => 'Notlarda ara';

  @override
  String get emptyNotebooksTitle => 'Henüz defter yok';

  @override
  String get emptyNotebooksBody =>
      'Yazmaya başlamak için ilk defterinizi oluşturun.';

  @override
  String get emptySearchTitle => 'Sonuç yok';

  @override
  String get emptySearchBody => 'Başka bir arama terimi deneyin.';

  @override
  String get emptyNotebookTitle => 'Henüz not yok';

  @override
  String get emptyNotebookBody =>
      'İlk notunuzu yazmak için + simgesine dokunun.';

  @override
  String get newNotebookTitle => 'Yeni defter';

  @override
  String get notebookNameHint => 'Defter adı';

  @override
  String get newNoteTitle => 'Yeni not';

  @override
  String get sortOptionsTitle => 'Sırala';

  @override
  String get sortByModified => 'Son düzenleme';

  @override
  String get sortByCreated => 'Oluşturma tarihi';

  @override
  String get sortByTitle => 'Başlık';

  @override
  String get formatBold => 'Kalın';

  @override
  String get formatItalic => 'İtalik';

  @override
  String get formatUnderline => 'Altı çizili';

  @override
  String get formatHeading => 'Başlık';

  @override
  String get formatBulletList => 'Madde işaretli liste';

  @override
  String get formatChecklist => 'Yapılacaklar listesi';

  @override
  String get formatQuote => 'Alıntı';

  @override
  String get formatCodeBlock => 'Kod bloğu';

  @override
  String get penFountainPen => 'Dolma kalem';

  @override
  String get penGelPen => 'Jel kalem';

  @override
  String get penPencil => 'Kurşun kalem';

  @override
  String get penHighlighter => 'Fosforlu kalem';

  @override
  String get penEraser => 'Silgi';

  @override
  String get penStrokeWidth => 'Çizgi kalınlığı';

  @override
  String get toggleHandwritingMode => 'Yazma ve çizim arasında geçiş yap';

  @override
  String get biometricLockReason => 'Notu görüntülemek için kilidi açın';

  @override
  String get noteLockedMessage => 'Bu not kilitli';

  @override
  String get unlockButton => 'Kilidi aç';

  @override
  String get noteLockTurnedOffMessage =>
      'Bu cihazda ekran kilidi veya biyometri ayarlanmadığı için not kilidi kapatıldı.';

  @override
  String get biometricEnableReason =>
      'Not kilidini etkinleştirmek için kimliğinizi doğrulayın';

  @override
  String get biometricDisableReason =>
      'Not kilidini devre dışı bırakmak için kimliğinizi doğrulayın';

  @override
  String get biometricShareReason =>
      'Notu paylaşmak veya dışa aktarmak için kilidi açın';

  @override
  String get biometricAuthFailedMessage => 'Kimliğiniz doğrulanamadı.';

  @override
  String get biometricSetupNeededMessage =>
      'Önce cihaz ayarlarından bir ekran kilidi veya parmak izi ayarlayın.';

  @override
  String get privacyChoicesTitle => 'Gizlilik seçenekleri';

  @override
  String get purchaseFailedMessage =>
      'Satın alma tamamlanamadı. Lütfen tekrar deneyin.';

  @override
  String get restoreSuccessMessage => 'Satın alımınız geri yüklendi.';

  @override
  String get restoreNothingFoundMessage =>
      'Bu hesap için önceki bir satın alma bulunamadı.';

  @override
  String get restoreFailedMessage =>
      'Satın alımlar geri yüklenemedi. Bağlantınızı kontrol edip tekrar deneyin.';

  @override
  String get reminderScheduleFailedMessage =>
      'Hatırlatıcı planlanamadı. Lütfen tekrar deneyin.';

  @override
  String get storageIssueNotebooksLoad =>
      'Bazı defterler yüklenemedi. Mevcut olanlar gösteriliyor.';

  @override
  String get storageIssueNotebookSave =>
      'Bu defter kaydedilmemiş olabilir. Lütfen tekrar deneyin.';

  @override
  String get storageIssueNotebookChange =>
      'Bu değişiklik kaydedilmemiş olabilir. Lütfen tekrar deneyin.';

  @override
  String get storageIssueNotebookDelete =>
      'Defter silinemedi. Lütfen tekrar deneyin.';

  @override
  String get storageIssueNotebookOrder =>
      'Yeni sıralama kaydedilmemiş olabilir. Lütfen tekrar deneyin.';

  @override
  String get storageIssueNotesLoad =>
      'Bazı notlar yüklenemedi. Mevcut olanlar gösteriliyor.';

  @override
  String get storageIssueSearch => 'Arama sonuçları şu anda eksik olabilir.';

  @override
  String get storageIssueNoteSave =>
      'Bu not kaydedilmemiş olabilir. Cihazınızın depolama alanını kontrol edin.';

  @override
  String get storageIssueNoteDelete => 'Not silinemedi. Lütfen tekrar deneyin.';

  @override
  String get purchaseUnavailableMessage =>
      'Bu satın alma şu anda kullanılamıyor. Lütfen daha sonra tekrar deneyin.';

  @override
  String get exportTitle => 'Dışa aktar';

  @override
  String get exportAsTxt => 'Metin olarak dışa aktar';

  @override
  String get exportAsPdf => 'PDF olarak dışa aktar';

  @override
  String get paperStyleSectionTitle => 'Kâğıt stili';

  @override
  String get paperStyleLined => 'Çizgili';

  @override
  String get paperStyleDotGrid => 'Noktalı';

  @override
  String get paperStyleGrid => 'Kareli';

  @override
  String get paperStyleBlank => 'Boş';

  @override
  String get paperStyleCream => 'Krem';

  @override
  String get paperStyleParchment => 'Parşömen';

  @override
  String get paperStyleVellum => 'Aydınger';

  @override
  String get fontSectionTitle => 'Not yazı tipi';

  @override
  String get fontSystem => 'Sistem';

  @override
  String get fontSerif => 'Serifli';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'Görünüm';

  @override
  String get themeLight => 'Açık';

  @override
  String get themeDark => 'Koyu';

  @override
  String get themeParchment => 'Parşömen';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get verseSectionTitle => 'Günün Kutsal Kitap ayeti görünümü';

  @override
  String get verseModeWatermark => 'Filigran';

  @override
  String get verseModeHeader => 'Üst bilgi';

  @override
  String get verseModeFooter => 'Alt bilgi';

  @override
  String get verseModeOff => 'Kapalı';

  @override
  String get notificationsSectionTitle => 'Bildirimler';

  @override
  String get dailyReminderToggle => 'Günlük Kutsal Kitap ayeti hatırlatıcısı';

  @override
  String get reminderTimeLabel => 'Hatırlatma saati';

  @override
  String get notificationPermissionDenied =>
      'Bildirimler sistem ayarlarında kapalı.';

  @override
  String get dailyReminderBody => 'Günün Kutsal Kitap ayeti hazır.';

  @override
  String get privacySectionTitle => 'Gizlilik';

  @override
  String get biometricLockToggle => 'Notları Face ID / parmak iziyle kilitle';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get removeAdsTitle => 'Reklamları kaldır';

  @override
  String get restorePurchasesButton => 'Satın alımları geri yükle';

  @override
  String get proLabel => 'Pro';

  @override
  String get engagementSectionTitle => 'Daha fazla';

  @override
  String get rateAppTitle => 'Atrament’i değerlendir';

  @override
  String get rateAppSubtitle => 'Uygulamayı beğendiniz mi? Bir yorum bırakın';

  @override
  String get shareAppTitle => 'Atrament’i paylaş';

  @override
  String get shareAppSubtitle => 'Bir arkadaşınıza anlatın';

  @override
  String get shareAppMessage =>
      'Atrament’i deneyin: kâğıt dokulu, dikkat dağıtmayan bir not defteri.';

  @override
  String get languageSectionTitle => 'Dil';

  @override
  String get languageFollowsSystem => 'Cihazın dil ayarını izler';

  @override
  String get languageSystem => 'Sistem varsayılanı';

  @override
  String get languagePickerTitle => 'Dil seçin';

  @override
  String get premiumScreenTitle => 'Reklamları kaldır';

  @override
  String get premiumHeadline => 'Dikkatiniz dağılmadan yazın';

  @override
  String get premiumBody =>
      'Atrament ücretsizdir ve tek bir küçük reklam bannerı gösterir. Reklamları kaldırmak, başka hiçbir şeyin kilidini açmayan tek seferlik bir satın alımdır: tüm özellikler zaten sizin.';

  @override
  String get premiumRestoreButton => 'Satın alımları geri yükle';

  @override
  String get premiumAlreadyProMessage =>
      'Zaten “Reklamları kaldır” seçeneğine sahipsiniz. Teşekkürler!';

  @override
  String get supportSectionTitle => 'Destek';

  @override
  String get shareDebugLogButton => 'Hata ayıklama günlüğünü paylaş';

  @override
  String get shareDebugLogSubtitle =>
      'Bir şey çalışmıyorsa teknik rapor gönderin';

  @override
  String get noDebugLogMessage => 'Henüz bildirilecek bir şey yok.';

  @override
  String get clearDebugLogButton => 'Hata ayıklama günlüğünü temizle';

  @override
  String get clearDebugLogTitle => 'Hata ayıklama günlüğü temizlensin mi?';

  @override
  String get clearDebugLogBody =>
      'Kaydedilmiş teknik rapor cihazınızdan kaldırılacak.';

  @override
  String get debugLogClearedMessage => 'Hata ayıklama günlüğü temizlendi.';

  @override
  String get premiumUnlockLabel => 'Reklamları sonsuza dek kaldır';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'Tümü';

  @override
  String get chipNotebooks => 'Defterler';

  @override
  String get chipRecent => 'Son kullanılanlar';

  @override
  String get emptyAllNotesTitle => 'Henüz not yok';

  @override
  String get emptyAllNotesBody =>
      'İlk notunuzu yazmak için + simgesine dokunun.';

  @override
  String get emptyRecentNotesTitle => 'Son düzenlenen not yok';

  @override
  String get emptyRecentNotesBody => 'Düzenlediğiniz notlar burada görünür.';

  @override
  String get noteActionRename => 'Yeniden adlandır';

  @override
  String get noteActionMoveToNotebook => 'Deftere taşı';

  @override
  String get noteActionEdit => 'Düzenle';

  @override
  String get noteActionExport => 'Dışa aktar';

  @override
  String get noteActionShare => 'Paylaş';

  @override
  String get moveToNotebookTitle => 'Deftere taşı';

  @override
  String get moveToNotebookEmptyBody =>
      'Henüz başka defter yok. Bu notu düzenlemek için bir defter oluşturun.';

  @override
  String get moveToNotebookCreateRow => 'Yeni defter oluştur';

  @override
  String get notebookActionRename => 'Yeniden adlandır';

  @override
  String get notebookActionChangeCover => 'Kapağı değiştir';

  @override
  String get notebookRenameDialogTitle => 'Defteri yeniden adlandır';

  @override
  String get notebookCoverPickerTitle => 'Kapak rengi seçin';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'Defter, içindeki tüm notlarla birlikte silinecek (toplam: $count). Bu işlem geri alınamaz.';
  }

  @override
  String get legalAndSupportSectionTitle => 'Yasal bilgiler ve destek';

  @override
  String get privacyPolicyRow => 'Gizlilik Politikası';

  @override
  String get termsOfServiceRow => 'Hizmet Şartları';

  @override
  String get supportRow => 'Destek';

  @override
  String get openLinkFailedMessage =>
      'Bağlantı açılamadı. Lütfen tekrar deneyin.';

  @override
  String get openSourceLicensesRow => 'Açık kaynak lisansları';
}
