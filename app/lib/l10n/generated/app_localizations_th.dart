// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'ลองอีกครั้ง';

  @override
  String get errorGeneric => 'เกิดข้อผิดพลาดบางอย่าง';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get save => 'บันทึก';

  @override
  String get delete => 'ลบ';

  @override
  String get undo => 'เลิกทำ';

  @override
  String get redo => 'ทำซ้ำ';

  @override
  String get untitledNote => 'ไม่มีชื่อเรื่อง';

  @override
  String get deleteConfirmBody => 'ไม่สามารถย้อนกลับการดำเนินการนี้ได้';

  @override
  String get deleteNoteTitle => 'ลบบันทึกนี้ไหม';

  @override
  String deleteNotebookTitle(String name) {
    return 'ลบ “$name” ไหม';
  }

  @override
  String get saveFailedMessage => 'บันทึกไม่สำเร็จ โปรดลองอีกครั้ง';

  @override
  String get exportFailedMessage => 'ส่งออกบันทึกนี้ไม่สำเร็จ โปรดลองอีกครั้ง';

  @override
  String get shareFailedMessage => 'เปิดเมนูแชร์ไม่สำเร็จ โปรดลองอีกครั้ง';

  @override
  String get settingsTitle => 'การตั้งค่า';

  @override
  String get searchHint => 'ค้นหาบันทึก';

  @override
  String get emptyNotebooksTitle => 'ยังไม่มีสมุดบันทึก';

  @override
  String get emptyNotebooksBody => 'สร้างสมุดบันทึกเล่มแรกเพื่อเริ่มเขียน';

  @override
  String get emptySearchTitle => 'ไม่พบผลลัพธ์';

  @override
  String get emptySearchBody => 'ลองใช้คำค้นหาอื่น';

  @override
  String get emptyNotebookTitle => 'ยังไม่มีบันทึก';

  @override
  String get emptyNotebookBody => 'แตะ + เพื่อเขียนบันทึกแรกของคุณ';

  @override
  String get newNotebookTitle => 'สมุดบันทึกใหม่';

  @override
  String get notebookNameHint => 'ชื่อสมุดบันทึก';

  @override
  String get newNoteTitle => 'บันทึกใหม่';

  @override
  String get sortOptionsTitle => 'เรียงลำดับ';

  @override
  String get sortByModified => 'แก้ไขล่าสุด';

  @override
  String get sortByCreated => 'วันที่สร้าง';

  @override
  String get sortByTitle => 'ชื่อเรื่อง';

  @override
  String get formatBold => 'ตัวหนา';

  @override
  String get formatItalic => 'ตัวเอียง';

  @override
  String get formatUnderline => 'ขีดเส้นใต้';

  @override
  String get formatHeading => 'หัวเรื่อง';

  @override
  String get formatBulletList => 'รายการแบบหัวข้อย่อย';

  @override
  String get formatChecklist => 'รายการตรวจสอบ';

  @override
  String get formatQuote => 'คำพูดอ้างอิง';

  @override
  String get formatCodeBlock => 'บล็อกโค้ด';

  @override
  String get penFountainPen => 'ปากกาหมึกซึม';

  @override
  String get penGelPen => 'ปากกาเจล';

  @override
  String get penPencil => 'ดินสอ';

  @override
  String get penHighlighter => 'ปากกาไฮไลต์';

  @override
  String get penEraser => 'ยางลบ';

  @override
  String get penStrokeWidth => 'ความหนาของเส้น';

  @override
  String get toggleHandwritingMode => 'สลับระหว่างการพิมพ์และการวาด';

  @override
  String get biometricLockReason => 'ปลดล็อกเพื่อดูบันทึก';

  @override
  String get noteLockedMessage => 'บันทึกนี้ถูกล็อก';

  @override
  String get unlockButton => 'ปลดล็อก';

  @override
  String get noteLockTurnedOffMessage =>
      'ปิดการล็อกบันทึกแล้ว เนื่องจากอุปกรณ์นี้ไม่ได้ตั้งค่าการล็อกหน้าจอหรือชีวมิติ';

  @override
  String get biometricEnableReason => 'ยืนยันตัวตนเพื่อเปิดการล็อกบันทึก';

  @override
  String get biometricDisableReason => 'ยืนยันตัวตนเพื่อปิดการล็อกบันทึก';

  @override
  String get biometricShareReason => 'ปลดล็อกเพื่อแชร์หรือส่งออกบันทึกนี้';

  @override
  String get biometricAuthFailedMessage => 'ไม่สามารถยืนยันตัวตนของคุณได้';

  @override
  String get biometricSetupNeededMessage =>
      'โปรดตั้งค่าการล็อกหน้าจอหรือลายนิ้วมือในการตั้งค่าอุปกรณ์ก่อน';

  @override
  String get privacyChoicesTitle => 'ตัวเลือกความเป็นส่วนตัว';

  @override
  String get purchaseFailedMessage => 'ซื้อไม่สำเร็จ โปรดลองอีกครั้ง';

  @override
  String get restoreSuccessMessage => 'กู้คืนการซื้อของคุณแล้ว';

  @override
  String get restoreNothingFoundMessage => 'ไม่พบการซื้อก่อนหน้าสำหรับบัญชีนี้';

  @override
  String get restoreFailedMessage =>
      'กู้คืนการซื้อไม่สำเร็จ โปรดตรวจสอบการเชื่อมต่อแล้วลองอีกครั้ง';

  @override
  String get reminderScheduleFailedMessage =>
      'ตั้งเวลาการแจ้งเตือนไม่สำเร็จ โปรดลองอีกครั้ง';

  @override
  String get storageIssueNotebooksLoad =>
      'โหลดสมุดบันทึกบางเล่มไม่สำเร็จ กำลังแสดงเท่าที่มี';

  @override
  String get storageIssueNotebookSave =>
      'สมุดบันทึกนี้อาจยังไม่ถูกบันทึก โปรดลองอีกครั้ง';

  @override
  String get storageIssueNotebookChange =>
      'การเปลี่ยนแปลงนี้อาจยังไม่ถูกบันทึก โปรดลองอีกครั้ง';

  @override
  String get storageIssueNotebookDelete =>
      'ลบสมุดบันทึกไม่สำเร็จ โปรดลองอีกครั้ง';

  @override
  String get storageIssueNotebookOrder =>
      'ลำดับใหม่อาจยังไม่ถูกบันทึก โปรดลองอีกครั้ง';

  @override
  String get storageIssueNotesLoad =>
      'โหลดบันทึกบางรายการไม่สำเร็จ กำลังแสดงเท่าที่มี';

  @override
  String get storageIssueSearch => 'ผลการค้นหาอาจไม่ครบถ้วนในขณะนี้';

  @override
  String get storageIssueNoteSave =>
      'บันทึกนี้อาจยังไม่ถูกบันทึก โปรดตรวจสอบพื้นที่เก็บข้อมูลของอุปกรณ์';

  @override
  String get storageIssueNoteDelete => 'ลบบันทึกไม่สำเร็จ โปรดลองอีกครั้ง';

  @override
  String get purchaseUnavailableMessage =>
      'ไม่สามารถซื้อรายการนี้ได้ในขณะนี้ โปรดลองอีกครั้งภายหลัง';

  @override
  String get exportTitle => 'ส่งออก';

  @override
  String get exportAsTxt => 'ส่งออกเป็นข้อความ';

  @override
  String get exportAsPdf => 'ส่งออกเป็น PDF';

  @override
  String get paperStyleSectionTitle => 'รูปแบบกระดาษ';

  @override
  String get paperStyleLined => 'มีเส้นบรรทัด';

  @override
  String get paperStyleDotGrid => 'จุดไข่ปลา';

  @override
  String get paperStyleGrid => 'ตาราง';

  @override
  String get paperStyleBlank => 'ว่างเปล่า';

  @override
  String get paperStyleCream => 'สีครีม';

  @override
  String get paperStyleParchment => 'กระดาษหนังแกะ';

  @override
  String get paperStyleVellum => 'กระดาษหนังลูกวัว';

  @override
  String get fontSectionTitle => 'แบบอักษรของบันทึก';

  @override
  String get fontSystem => 'ระบบ';

  @override
  String get fontSerif => 'มีเชิง';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'รูปลักษณ์';

  @override
  String get themeLight => 'สว่าง';

  @override
  String get themeDark => 'มืด';

  @override
  String get themeParchment => 'กระดาษหนังแกะ';

  @override
  String get themeSystem => 'ระบบ';

  @override
  String get verseSectionTitle => 'การแสดงพระคัมภีร์ประจำวัน';

  @override
  String get verseModeWatermark => 'ลายน้ำ';

  @override
  String get verseModeHeader => 'ส่วนหัว';

  @override
  String get verseModeFooter => 'ส่วนท้าย';

  @override
  String get verseModeOff => 'ปิด';

  @override
  String get notificationsSectionTitle => 'การแจ้งเตือน';

  @override
  String get dailyReminderToggle => 'การแจ้งเตือนพระคัมภีร์ประจำวัน';

  @override
  String get reminderTimeLabel => 'เวลาแจ้งเตือน';

  @override
  String get notificationPermissionDenied =>
      'การแจ้งเตือนถูกปิดอยู่ในการตั้งค่าระบบ';

  @override
  String get dailyReminderBody => 'พระคัมภีร์ประจำวันของคุณพร้อมแล้ว';

  @override
  String get privacySectionTitle => 'ความเป็นส่วนตัว';

  @override
  String get biometricLockToggle => 'ล็อกบันทึกด้วย Face ID / ลายนิ้วมือ';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get removeAdsTitle => 'นำโฆษณาออก';

  @override
  String get restorePurchasesButton => 'กู้คืนการซื้อ';

  @override
  String get proLabel => 'Pro';

  @override
  String get engagementSectionTitle => 'เพิ่มเติม';

  @override
  String get rateAppTitle => 'ให้คะแนน Atrament';

  @override
  String get rateAppSubtitle => 'ชอบแอปนี้ไหม เขียนรีวิวให้เราหน่อย';

  @override
  String get shareAppTitle => 'แชร์ Atrament';

  @override
  String get shareAppSubtitle => 'บอกเพื่อน';

  @override
  String get shareAppMessage =>
      'ลองใช้ Atrament สมุดบันทึกไร้สิ่งรบกวนพร้อมพื้นผิวกระดาษ';

  @override
  String get languageSectionTitle => 'ภาษา';

  @override
  String get languageFollowsSystem => 'ตามการตั้งค่าภาษาของอุปกรณ์';

  @override
  String get languageSystem => 'ค่าเริ่มต้นของระบบ';

  @override
  String get languagePickerTitle => 'เลือกภาษา';

  @override
  String get premiumScreenTitle => 'นำโฆษณาออก';

  @override
  String get premiumHeadline => 'เขียนโดยไม่มีสิ่งรบกวน';

  @override
  String get premiumBody =>
      'Atrament ใช้ฟรีและแสดงแบนเนอร์โฆษณาเล็ก ๆ เพียงอันเดียว การนำโฆษณาออกเป็นการซื้อครั้งเดียวที่ไม่ปลดล็อกสิ่งอื่น ฟีเจอร์ทั้งหมดเป็นของคุณอยู่แล้ว';

  @override
  String get premiumRestoreButton => 'กู้คืนการซื้อ';

  @override
  String get premiumAlreadyProMessage => 'คุณมี นำโฆษณาออก แล้ว ขอบคุณ';

  @override
  String get supportSectionTitle => 'การสนับสนุน';

  @override
  String get shareDebugLogButton => 'แชร์บันทึกการแก้ไขข้อบกพร่อง';

  @override
  String get shareDebugLogSubtitle => 'ส่งรายงานทางเทคนิคหากมีบางอย่างไม่ทำงาน';

  @override
  String get noDebugLogMessage => 'ยังไม่มีอะไรให้รายงาน';

  @override
  String get clearDebugLogButton => 'ล้างบันทึกการแก้ไขข้อบกพร่อง';

  @override
  String get clearDebugLogTitle => 'ล้างบันทึกการแก้ไขข้อบกพร่องไหม';

  @override
  String get clearDebugLogBody =>
      'รายงานทางเทคนิคที่บันทึกไว้จะถูกลบออกจากอุปกรณ์ของคุณ';

  @override
  String get debugLogClearedMessage => 'ล้างบันทึกการแก้ไขข้อบกพร่องแล้ว';

  @override
  String get premiumUnlockLabel => 'นำโฆษณาออกตลอดไป';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'ทั้งหมด';

  @override
  String get chipNotebooks => 'สมุดบันทึก';

  @override
  String get chipRecent => 'ล่าสุด';

  @override
  String get emptyAllNotesTitle => 'ยังไม่มีบันทึก';

  @override
  String get emptyAllNotesBody => 'แตะ + เพื่อเขียนบันทึกแรกของคุณ';

  @override
  String get emptyRecentNotesTitle => 'ไม่มีรายการล่าสุด';

  @override
  String get emptyRecentNotesBody => 'บันทึกที่คุณแก้ไขจะแสดงที่นี่';

  @override
  String get noteActionRename => 'เปลี่ยนชื่อ';

  @override
  String get noteActionMoveToNotebook => 'ย้ายไปยังสมุดบันทึก';

  @override
  String get noteActionEdit => 'แก้ไข';

  @override
  String get noteActionExport => 'ส่งออก';

  @override
  String get noteActionShare => 'แชร์';

  @override
  String get moveToNotebookTitle => 'ย้ายไปยังสมุดบันทึก';

  @override
  String get moveToNotebookEmptyBody =>
      'ยังไม่มีสมุดบันทึกอื่น สร้างสักเล่มเพื่อจัดระเบียบบันทึกนี้';

  @override
  String get moveToNotebookCreateRow => 'สร้างสมุดบันทึกใหม่';

  @override
  String get notebookActionRename => 'เปลี่ยนชื่อ';

  @override
  String get notebookActionChangeCover => 'เปลี่ยนปก';

  @override
  String get notebookRenameDialogTitle => 'เปลี่ยนชื่อสมุดบันทึก';

  @override
  String get notebookCoverPickerTitle => 'เลือกสีปก';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'สมุดบันทึกจะถูกลบพร้อมบันทึกทั้งหมดในเล่ม (รวม: $count) ไม่สามารถย้อนกลับการดำเนินการนี้ได้';
  }

  @override
  String get legalAndSupportSectionTitle => 'กฎหมายและการสนับสนุน';

  @override
  String get privacyPolicyRow => 'นโยบายความเป็นส่วนตัว';

  @override
  String get termsOfServiceRow => 'ข้อกำหนดการให้บริการ';

  @override
  String get supportRow => 'การสนับสนุน';

  @override
  String get openLinkFailedMessage => 'เปิดลิงก์ไม่สำเร็จ โปรดลองอีกครั้ง';

  @override
  String get openSourceLicensesRow => 'ใบอนุญาตโอเพนซอร์ส';
}
