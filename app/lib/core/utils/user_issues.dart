// Problems the app reports to the user, as typed values instead of ready-made
// English sentences. The screen turns each one into text in the user's
// language (see `widgets/user_issue_text.dart`), so providers and services
// never carry display text.

/// A problem reading from or writing to the device's storage.
enum StorageIssue {
  notebooksLoadIncomplete,
  notebookSaveFailed,
  notebookChangeFailed,
  notebookDeleteFailed,
  notebookOrderFailed,
  notesLoadIncomplete,
  searchIncomplete,
  noteSaveFailed,
  noteDeleteFailed,
}

/// Why starting a purchase did not work.
enum PurchaseFailure {
  /// The store has no product to sell right now.
  productUnavailable,

  /// The store would not start the purchase.
  couldNotStart,

  /// Something unexpected went wrong.
  unexpected,
}
