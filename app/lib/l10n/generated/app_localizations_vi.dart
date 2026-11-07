// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'Thử lại';

  @override
  String get errorGeneric => 'Đã xảy ra sự cố';

  @override
  String get cancel => 'Hủy';

  @override
  String get save => 'Lưu';

  @override
  String get delete => 'Xóa';

  @override
  String get undo => 'Hoàn tác';

  @override
  String get redo => 'Làm lại';

  @override
  String get untitledNote => 'Không có tiêu đề';

  @override
  String get deleteConfirmBody => 'Không thể hoàn tác thao tác này.';

  @override
  String get deleteNoteTitle => 'Xóa ghi chú này?';

  @override
  String deleteNotebookTitle(String name) {
    return 'Xóa “$name”?';
  }

  @override
  String get saveFailedMessage => 'Không thể lưu. Vui lòng thử lại.';

  @override
  String get exportFailedMessage =>
      'Không thể xuất ghi chú này. Vui lòng thử lại.';

  @override
  String get shareFailedMessage =>
      'Không thể mở menu chia sẻ. Vui lòng thử lại.';

  @override
  String get settingsTitle => 'Cài đặt';

  @override
  String get searchHint => 'Tìm ghi chú';

  @override
  String get emptyNotebooksTitle => 'Chưa có sổ tay nào';

  @override
  String get emptyNotebooksBody => 'Tạo sổ tay đầu tiên để bắt đầu viết.';

  @override
  String get emptySearchTitle => 'Không có kết quả';

  @override
  String get emptySearchBody => 'Hãy thử từ khóa khác.';

  @override
  String get emptyNotebookTitle => 'Chưa có ghi chú nào';

  @override
  String get emptyNotebookBody => 'Chạm vào + để viết ghi chú đầu tiên.';

  @override
  String get newNotebookTitle => 'Sổ tay mới';

  @override
  String get notebookNameHint => 'Tên sổ tay';

  @override
  String get newNoteTitle => 'Ghi chú mới';

  @override
  String get sortOptionsTitle => 'Sắp xếp';

  @override
  String get sortByModified => 'Chỉnh sửa gần nhất';

  @override
  String get sortByCreated => 'Ngày tạo';

  @override
  String get sortByTitle => 'Tiêu đề';

  @override
  String get formatBold => 'In đậm';

  @override
  String get formatItalic => 'In nghiêng';

  @override
  String get formatUnderline => 'Gạch chân';

  @override
  String get formatHeading => 'Đề mục';

  @override
  String get formatBulletList => 'Danh sách dấu đầu dòng';

  @override
  String get formatChecklist => 'Danh sách việc cần làm';

  @override
  String get formatQuote => 'Trích dẫn';

  @override
  String get formatCodeBlock => 'Khối mã';

  @override
  String get penFountainPen => 'Bút máy';

  @override
  String get penGelPen => 'Bút gel';

  @override
  String get penPencil => 'Bút chì';

  @override
  String get penHighlighter => 'Bút nhớ dòng';

  @override
  String get penEraser => 'Tẩy';

  @override
  String get penStrokeWidth => 'Độ dày nét';

  @override
  String get toggleHandwritingMode => 'Chuyển giữa gõ chữ và vẽ';

  @override
  String get biometricLockReason => 'Mở khóa để xem ghi chú';

  @override
  String get noteLockedMessage => 'Ghi chú này đã bị khóa';

  @override
  String get unlockButton => 'Mở khóa';

  @override
  String get noteLockTurnedOffMessage =>
      'Khóa ghi chú đã được tắt vì thiết bị này chưa thiết lập khóa màn hình hoặc sinh trắc học.';

  @override
  String get biometricEnableReason =>
      'Xác minh danh tính của bạn để bật khóa ghi chú';

  @override
  String get biometricDisableReason =>
      'Xác minh danh tính của bạn để tắt khóa ghi chú';

  @override
  String get biometricShareReason => 'Mở khóa để chia sẻ hoặc xuất ghi chú này';

  @override
  String get biometricAuthFailedMessage =>
      'Không thể xác minh danh tính của bạn.';

  @override
  String get biometricSetupNeededMessage =>
      'Hãy thiết lập khóa màn hình hoặc vân tay trong cài đặt thiết bị trước.';

  @override
  String get privacyChoicesTitle => 'Tùy chọn quyền riêng tư';

  @override
  String get purchaseFailedMessage =>
      'Không thể hoàn tất giao dịch mua. Vui lòng thử lại.';

  @override
  String get restoreSuccessMessage =>
      'Giao dịch mua của bạn đã được khôi phục.';

  @override
  String get restoreNothingFoundMessage =>
      'Không tìm thấy giao dịch mua trước đó cho tài khoản này.';

  @override
  String get restoreFailedMessage =>
      'Không thể khôi phục giao dịch mua. Hãy kiểm tra kết nối và thử lại.';

  @override
  String get reminderScheduleFailedMessage =>
      'Không thể lên lịch nhắc nhở. Vui lòng thử lại.';

  @override
  String get storageIssueNotebooksLoad =>
      'Không thể tải một số sổ tay. Đang hiển thị những gì có sẵn.';

  @override
  String get storageIssueNotebookSave =>
      'Sổ tay này có thể chưa được lưu. Vui lòng thử lại.';

  @override
  String get storageIssueNotebookChange =>
      'Thay đổi này có thể chưa được lưu. Vui lòng thử lại.';

  @override
  String get storageIssueNotebookDelete =>
      'Không thể xóa sổ tay. Vui lòng thử lại.';

  @override
  String get storageIssueNotebookOrder =>
      'Thứ tự mới có thể chưa được lưu. Vui lòng thử lại.';

  @override
  String get storageIssueNotesLoad =>
      'Không thể tải một số ghi chú. Đang hiển thị những gì có sẵn.';

  @override
  String get storageIssueSearch => 'Kết quả tìm kiếm hiện có thể chưa đầy đủ.';

  @override
  String get storageIssueNoteSave =>
      'Ghi chú này có thể chưa được lưu. Hãy kiểm tra bộ nhớ thiết bị.';

  @override
  String get storageIssueNoteDelete =>
      'Không thể xóa ghi chú. Vui lòng thử lại.';

  @override
  String get purchaseUnavailableMessage =>
      'Hiện không thể thực hiện giao dịch mua này. Vui lòng thử lại sau.';

  @override
  String get exportTitle => 'Xuất';

  @override
  String get exportAsTxt => 'Xuất dưới dạng văn bản';

  @override
  String get exportAsPdf => 'Xuất dưới dạng PDF';

  @override
  String get paperStyleSectionTitle => 'Kiểu giấy';

  @override
  String get paperStyleLined => 'Có dòng kẻ';

  @override
  String get paperStyleDotGrid => 'Chấm bi';

  @override
  String get paperStyleGrid => 'Ô vuông';

  @override
  String get paperStyleBlank => 'Trắng';

  @override
  String get paperStyleCream => 'Kem';

  @override
  String get paperStyleParchment => 'Giấy da';

  @override
  String get paperStyleVellum => 'Giấy da bê';

  @override
  String get fontSectionTitle => 'Phông chữ ghi chú';

  @override
  String get fontSystem => 'Hệ thống';

  @override
  String get fontSerif => 'Có chân';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'Giao diện';

  @override
  String get themeLight => 'Sáng';

  @override
  String get themeDark => 'Tối';

  @override
  String get themeParchment => 'Giấy da';

  @override
  String get themeSystem => 'Hệ thống';

  @override
  String get verseSectionTitle => 'Hiển thị câu Kinh Thánh trong ngày';

  @override
  String get verseModeWatermark => 'Hình mờ';

  @override
  String get verseModeHeader => 'Đầu trang';

  @override
  String get verseModeFooter => 'Chân trang';

  @override
  String get verseModeOff => 'Tắt';

  @override
  String get notificationsSectionTitle => 'Thông báo';

  @override
  String get dailyReminderToggle => 'Nhắc nhở câu Kinh Thánh hằng ngày';

  @override
  String get reminderTimeLabel => 'Giờ nhắc nhở';

  @override
  String get notificationPermissionDenied =>
      'Thông báo đã bị tắt trong cài đặt hệ thống.';

  @override
  String get dailyReminderBody =>
      'Câu Kinh Thánh trong ngày của bạn đã sẵn sàng.';

  @override
  String get privacySectionTitle => 'Quyền riêng tư';

  @override
  String get biometricLockToggle => 'Khóa ghi chú bằng Face ID / vân tay';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get removeAdsTitle => 'Xóa quảng cáo';

  @override
  String get restorePurchasesButton => 'Khôi phục giao dịch mua';

  @override
  String get proLabel => 'Pro';

  @override
  String get engagementSectionTitle => 'Thêm';

  @override
  String get rateAppTitle => 'Đánh giá Atrament';

  @override
  String get rateAppSubtitle => 'Thích ứng dụng này? Hãy để lại đánh giá';

  @override
  String get shareAppTitle => 'Chia sẻ Atrament';

  @override
  String get shareAppSubtitle => 'Kể cho một người bạn';

  @override
  String get shareAppMessage =>
      'Hãy thử Atrament, một cuốn sổ ghi chú không xao nhãng với kết cấu giấy.';

  @override
  String get languageSectionTitle => 'Ngôn ngữ';

  @override
  String get languageFollowsSystem => 'Theo cài đặt ngôn ngữ của thiết bị';

  @override
  String get languageSystem => 'Mặc định của hệ thống';

  @override
  String get languagePickerTitle => 'Chọn ngôn ngữ';

  @override
  String get premiumScreenTitle => 'Xóa quảng cáo';

  @override
  String get premiumHeadline => 'Viết không bị xao nhãng';

  @override
  String get premiumBody =>
      'Atrament miễn phí và chỉ hiển thị một biểu ngữ quảng cáo nhỏ. Xóa quảng cáo là giao dịch mua một lần và không mở khóa thêm gì khác: mọi tính năng đều đã thuộc về bạn.';

  @override
  String get premiumRestoreButton => 'Khôi phục giao dịch mua';

  @override
  String get premiumAlreadyProMessage =>
      'Bạn đã có “Xóa quảng cáo”. Cảm ơn bạn!';

  @override
  String get supportSectionTitle => 'Hỗ trợ';

  @override
  String get shareDebugLogButton => 'Chia sẻ nhật ký gỡ lỗi';

  @override
  String get shareDebugLogSubtitle =>
      'Gửi báo cáo kỹ thuật nếu có gì đó không hoạt động';

  @override
  String get noDebugLogMessage => 'Chưa có gì để báo cáo.';

  @override
  String get clearDebugLogButton => 'Xóa nhật ký gỡ lỗi';

  @override
  String get clearDebugLogTitle => 'Xóa nhật ký gỡ lỗi?';

  @override
  String get clearDebugLogBody =>
      'Báo cáo kỹ thuật đã lưu sẽ bị xóa khỏi thiết bị của bạn.';

  @override
  String get debugLogClearedMessage => 'Đã xóa nhật ký gỡ lỗi.';

  @override
  String get premiumUnlockLabel => 'Xóa quảng cáo vĩnh viễn';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'Tất cả';

  @override
  String get chipNotebooks => 'Sổ tay';

  @override
  String get chipRecent => 'Gần đây';

  @override
  String get emptyAllNotesTitle => 'Chưa có ghi chú nào';

  @override
  String get emptyAllNotesBody => 'Chạm vào + để viết ghi chú đầu tiên.';

  @override
  String get emptyRecentNotesTitle => 'Không có gì gần đây';

  @override
  String get emptyRecentNotesBody =>
      'Các ghi chú bạn chỉnh sửa sẽ xuất hiện ở đây.';

  @override
  String get noteActionRename => 'Đổi tên';

  @override
  String get noteActionMoveToNotebook => 'Chuyển vào sổ tay';

  @override
  String get noteActionEdit => 'Chỉnh sửa';

  @override
  String get noteActionExport => 'Xuất';

  @override
  String get noteActionShare => 'Chia sẻ';

  @override
  String get moveToNotebookTitle => 'Chuyển vào sổ tay';

  @override
  String get moveToNotebookEmptyBody =>
      'Chưa có sổ tay nào khác. Hãy tạo một sổ tay để sắp xếp ghi chú này.';

  @override
  String get moveToNotebookCreateRow => 'Tạo sổ tay mới';

  @override
  String get notebookActionRename => 'Đổi tên';

  @override
  String get notebookActionChangeCover => 'Đổi bìa';

  @override
  String get notebookRenameDialogTitle => 'Đổi tên sổ tay';

  @override
  String get notebookCoverPickerTitle => 'Chọn màu bìa';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'Sổ tay sẽ bị xóa cùng tất cả ghi chú trong đó (tổng cộng: $count). Không thể hoàn tác thao tác này.';
  }

  @override
  String get legalAndSupportSectionTitle => 'Pháp lý và hỗ trợ';

  @override
  String get privacyPolicyRow => 'Chính sách quyền riêng tư';

  @override
  String get termsOfServiceRow => 'Điều khoản dịch vụ';

  @override
  String get supportRow => 'Hỗ trợ';

  @override
  String get openLinkFailedMessage =>
      'Không thể mở liên kết. Vui lòng thử lại.';

  @override
  String get openSourceLicensesRow => 'Giấy phép nguồn mở';
}
