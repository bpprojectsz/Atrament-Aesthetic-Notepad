// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get errorGeneric => 'Algo deu errado';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Salvar';

  @override
  String get delete => 'Excluir';

  @override
  String get undo => 'Desfazer';

  @override
  String get redo => 'Refazer';

  @override
  String get untitledNote => 'Sem título';

  @override
  String get deleteConfirmBody => 'Isso não pode ser desfeito.';

  @override
  String get deleteNoteTitle => 'Excluir esta nota?';

  @override
  String deleteNotebookTitle(String name) {
    return 'Excluir \"$name\"?';
  }

  @override
  String get saveFailedMessage => 'Não foi possível salvar. Tente novamente.';

  @override
  String get exportFailedMessage =>
      'Não foi possível exportar esta nota. Tente novamente.';

  @override
  String get shareFailedMessage =>
      'Não foi possível abrir o menu de compartilhamento. Tente novamente.';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get searchHint => 'Pesquisar notas';

  @override
  String get emptyNotebooksTitle => 'Ainda não há cadernos';

  @override
  String get emptyNotebooksBody =>
      'Crie seu primeiro caderno para começar a escrever.';

  @override
  String get emptySearchTitle => 'Nenhum resultado';

  @override
  String get emptySearchBody => 'Tente outro termo de pesquisa.';

  @override
  String get emptyNotebookTitle => 'Ainda não há notas';

  @override
  String get emptyNotebookBody => 'Toque em + para escrever sua primeira nota.';

  @override
  String get newNotebookTitle => 'Novo caderno';

  @override
  String get notebookNameHint => 'Nome do caderno';

  @override
  String get newNoteTitle => 'Nova nota';

  @override
  String get sortOptionsTitle => 'Ordenar';

  @override
  String get sortByModified => 'Última edição';

  @override
  String get sortByCreated => 'Data de criação';

  @override
  String get sortByTitle => 'Título';

  @override
  String get formatBold => 'Negrito';

  @override
  String get formatItalic => 'Itálico';

  @override
  String get formatUnderline => 'Sublinhado';

  @override
  String get formatHeading => 'Título';

  @override
  String get formatBulletList => 'Lista com marcadores';

  @override
  String get formatChecklist => 'Lista de tarefas';

  @override
  String get formatQuote => 'Citação';

  @override
  String get formatCodeBlock => 'Bloco de código';

  @override
  String get penFountainPen => 'Caneta-tinteiro';

  @override
  String get penGelPen => 'Caneta gel';

  @override
  String get penPencil => 'Lápis';

  @override
  String get penHighlighter => 'Marca-texto';

  @override
  String get penEraser => 'Borracha';

  @override
  String get penStrokeWidth => 'Espessura do traço';

  @override
  String get toggleHandwritingMode => 'Alternar entre digitar e desenhar';

  @override
  String get biometricLockReason => 'Desbloqueie para ver esta nota';

  @override
  String get noteLockedMessage => 'Esta nota está bloqueada';

  @override
  String get unlockButton => 'Desbloquear';

  @override
  String get exportTitle => 'Exportar';

  @override
  String get exportAsTxt => 'Exportar como texto';

  @override
  String get exportAsPdf => 'Exportar como PDF';

  @override
  String get paperStyleSectionTitle => 'Estilo de papel';

  @override
  String get paperStyleLined => 'Pautado';

  @override
  String get paperStyleDotGrid => 'Grade de pontos';

  @override
  String get paperStyleGrid => 'Quadriculado';

  @override
  String get paperStyleBlank => 'Em branco';

  @override
  String get paperStyleCream => 'Creme';

  @override
  String get paperStyleParchment => 'Pergaminho';

  @override
  String get paperStyleVellum => 'Velino';

  @override
  String get fontSectionTitle => 'Fonte da nota';

  @override
  String get fontSystem => 'Sistema';

  @override
  String get fontSerif => 'Serifa';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'Aparência';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get themeParchment => 'Pergaminho';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get verseSectionTitle => 'Exibição do versículo diário';

  @override
  String get verseModeWatermark => 'Marca d\'água';

  @override
  String get verseModeHeader => 'Cabeçalho';

  @override
  String get verseModeFooter => 'Rodapé';

  @override
  String get verseModeOff => 'Desativado';

  @override
  String get notificationsSectionTitle => 'Notificações';

  @override
  String get dailyReminderToggle => 'Lembrete diário de versículo';

  @override
  String get reminderTimeLabel => 'Horário do lembrete';

  @override
  String get notificationPermissionDenied =>
      'As notificações estão desativadas nas configurações do sistema.';

  @override
  String get dailyReminderBody => 'Seu versículo diário está pronto.';

  @override
  String get privacySectionTitle => 'Privacidade';

  @override
  String get biometricLockToggle =>
      'Bloquear notas com Face ID / impressão digital';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get removeAdsTitle => 'Remover anúncios';

  @override
  String get restorePurchasesButton => 'Restaurar compras';

  @override
  String get proLabel => 'Pro';

  @override
  String get engagementSectionTitle => 'Mais';

  @override
  String get rateAppTitle => 'Avaliar Atrament';

  @override
  String get rateAppSubtitle => 'Gostando do app? Deixe uma avaliação';

  @override
  String get shareAppTitle => 'Compartilhar Atrament';

  @override
  String get shareAppSubtitle => 'Conte a um amigo';

  @override
  String get shareAppMessage =>
      'Experimente Atrament — um bloco de notas sem distração com texturas de papel.';

  @override
  String get languageSectionTitle => 'Idioma';

  @override
  String get languageFollowsSystem =>
      'Segue o idioma configurado no seu dispositivo';

  @override
  String get languageSystem => 'Padrão do sistema';

  @override
  String get languagePickerTitle => 'Escolher idioma';

  @override
  String get premiumScreenTitle => 'Remover anúncios';

  @override
  String get premiumHeadline => 'Escreva sem distrações';

  @override
  String get premiumBody =>
      'O Atrament é gratuito com um pequeno banner de anúncio. Removê-lo é uma compra única que não desbloqueia mais nada — todos os recursos já são seus.';

  @override
  String get premiumRestoreButton => 'Restaurar compras';

  @override
  String get premiumAlreadyProMessage =>
      'Você já tem Remover anúncios. Obrigado!';

  @override
  String get supportSectionTitle => 'Suporte';

  @override
  String get shareDebugLogButton => 'Compartilhar registro de depuração';

  @override
  String get shareDebugLogSubtitle =>
      'Envie um relatório técnico se algo não estiver funcionando';

  @override
  String get noDebugLogMessage => 'Nada para relatar ainda.';

  @override
  String get clearDebugLogButton => 'Limpar registro de depuração';

  @override
  String get clearDebugLogTitle => 'Limpar o registro de depuração?';

  @override
  String get clearDebugLogBody =>
      'Isso remove o relatório técnico salvo no seu dispositivo.';

  @override
  String get debugLogClearedMessage => 'Registro de depuração limpo.';

  @override
  String get premiumUnlockLabel => 'Remover anúncios para sempre';

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

  @override
  String get openSourceLicensesRow => 'Open-source licenses';
}
