import '../core/utils/user_issues.dart';
import '../l10n/generated/app_localizations.dart';

/// The user-facing text for a [StorageIssue], in the app's current language.
String storageIssueText(AppLocalizations l10n, StorageIssue issue) {
  switch (issue) {
    case StorageIssue.notebooksLoadIncomplete:
      return l10n.storageIssueNotebooksLoad;
    case StorageIssue.notebookSaveFailed:
      return l10n.storageIssueNotebookSave;
    case StorageIssue.notebookChangeFailed:
      return l10n.storageIssueNotebookChange;
    case StorageIssue.notebookDeleteFailed:
      return l10n.storageIssueNotebookDelete;
    case StorageIssue.notebookOrderFailed:
      return l10n.storageIssueNotebookOrder;
    case StorageIssue.notesLoadIncomplete:
      return l10n.storageIssueNotesLoad;
    case StorageIssue.searchIncomplete:
      return l10n.storageIssueSearch;
    case StorageIssue.noteSaveFailed:
      return l10n.storageIssueNoteSave;
    case StorageIssue.noteDeleteFailed:
      return l10n.storageIssueNoteDelete;
  }
}

/// The user-facing text for a [PurchaseFailure], in the app's current language.
String purchaseFailureText(AppLocalizations l10n, PurchaseFailure failure) {
  switch (failure) {
    case PurchaseFailure.productUnavailable:
      return l10n.purchaseUnavailableMessage;
    case PurchaseFailure.couldNotStart:
    case PurchaseFailure.unexpected:
      return l10n.purchaseFailedMessage;
  }
}
