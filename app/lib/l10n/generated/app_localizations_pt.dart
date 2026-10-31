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
  String get noteLockTurnedOffMessage =>
      'O bloqueio de notas foi desativado porque este dispositivo não tem bloqueio de tela nem biometria configurados.';

  @override
  String get biometricEnableReason =>
      'Confirme que é você para ativar o bloqueio de notas';

  @override
  String get biometricDisableReason =>
      'Confirme que é você para desativar o bloqueio de notas';

  @override
  String get biometricShareReason =>
      'Desbloqueie para compartilhar ou exportar esta nota';

  @override
  String get biometricAuthFailedMessage =>
      'Não foi possível verificar sua identidade.';

  @override
  String get biometricSetupNeededMessage =>
      'Primeiro configure um bloqueio de tela ou uma impressão digital nas configurações do dispositivo.';

  @override
  String get privacyChoicesTitle => 'Opções de privacidade';

  @override
  String get purchaseFailedMessage =>
      'Não foi possível concluir a compra. Tente novamente.';

  @override
  String get restoreSuccessMessage => 'Sua compra foi restaurada.';

  @override
  String get restoreNothingFoundMessage =>
      'Nenhuma compra anterior foi encontrada para esta conta.';

  @override
  String get restoreFailedMessage =>
      'Não foi possível restaurar as compras. Verifique sua conexão e tente novamente.';

  @override
  String get reminderScheduleFailedMessage =>
      'Não foi possível agendar o lembrete. Tente novamente.';

  @override
  String get storageIssueNotebooksLoad =>
      'Alguns cadernos não puderam ser carregados. Mostrando o que está disponível.';

  @override
  String get storageIssueNotebookSave =>
      'Este caderno pode não ter sido salvo. Tente novamente.';

  @override
  String get storageIssueNotebookChange =>
      'Esta alteração pode não ter sido salva. Tente novamente.';

  @override
  String get storageIssueNotebookDelete =>
      'Não foi possível excluir o caderno. Tente novamente.';

  @override
  String get storageIssueNotebookOrder =>
      'A nova ordem pode não ter sido salva. Tente novamente.';

  @override
  String get storageIssueNotesLoad =>
      'Algumas notas não puderam ser carregadas. Mostrando o que está disponível.';

  @override
  String get storageIssueSearch =>
      'Os resultados da pesquisa podem estar incompletos no momento.';

  @override
  String get storageIssueNoteSave =>
      'Esta nota pode não ter sido salva. Verifique o armazenamento do dispositivo.';

  @override
  String get storageIssueNoteDelete =>
      'Não foi possível excluir a nota. Tente novamente.';

  @override
  String get purchaseUnavailableMessage =>
      'Esta compra não está disponível no momento. Tente novamente mais tarde.';

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
  String get chipAll => 'Tudo';

  @override
  String get chipNotebooks => 'Cadernos';

  @override
  String get chipRecent => 'Recentes';

  @override
  String get emptyAllNotesTitle => 'Ainda não há notas';

  @override
  String get emptyAllNotesBody => 'Toque em + para escrever sua primeira nota.';

  @override
  String get emptyRecentNotesTitle => 'Nada recente';

  @override
  String get emptyRecentNotesBody =>
      'As notas que você editar aparecerão aqui.';

  @override
  String get noteActionRename => 'Renomear';

  @override
  String get noteActionMoveToNotebook => 'Mover para caderno';

  @override
  String get noteActionEdit => 'Editar';

  @override
  String get noteActionExport => 'Exportar';

  @override
  String get noteActionShare => 'Compartilhar';

  @override
  String get moveToNotebookTitle => 'Mover para caderno';

  @override
  String get moveToNotebookEmptyBody =>
      'Ainda não há outros cadernos. Crie um para organizar esta nota.';

  @override
  String get moveToNotebookCreateRow => 'Criar novo caderno';

  @override
  String get notebookActionRename => 'Renomear';

  @override
  String get notebookActionChangeCover => 'Alterar capa';

  @override
  String get notebookRenameDialogTitle => 'Renomear caderno';

  @override
  String get notebookCoverPickerTitle => 'Escolher uma cor de capa';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'Isso excluirá o caderno e suas $count notas. Esta ação não pode ser desfeita.';
  }

  @override
  String get legalAndSupportSectionTitle => 'Jurídico e suporte';

  @override
  String get privacyPolicyRow => 'Política de Privacidade';

  @override
  String get termsOfServiceRow => 'Termos de Serviço';

  @override
  String get supportRow => 'Suporte';

  @override
  String get openLinkFailedMessage =>
      'Não foi possível abrir o link. Tente novamente.';

  @override
  String get openSourceLicensesRow => 'Licenças de código aberto';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');
}

/// The translations for Portuguese, as used in Portugal (`pt_PT`).
class AppLocalizationsPtPt extends AppLocalizationsPt {
  AppLocalizationsPtPt() : super('pt_PT');

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get errorGeneric => 'Ocorreu um erro';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get delete => 'Eliminar';

  @override
  String get undo => 'Anular';

  @override
  String get redo => 'Refazer';

  @override
  String get untitledNote => 'Sem título';

  @override
  String get deleteConfirmBody => 'Esta ação não pode ser anulada.';

  @override
  String get deleteNoteTitle => 'Eliminar esta nota?';

  @override
  String deleteNotebookTitle(String name) {
    return 'Eliminar \"$name\"?';
  }

  @override
  String get saveFailedMessage => 'Não foi possível guardar. Tente novamente.';

  @override
  String get exportFailedMessage =>
      'Não foi possível exportar esta nota. Tente novamente.';

  @override
  String get shareFailedMessage =>
      'Não foi possível abrir o menu de partilha. Tente novamente.';

  @override
  String get settingsTitle => 'Definições';

  @override
  String get searchHint => 'Pesquisar notas';

  @override
  String get emptyNotebooksTitle => 'Ainda não há cadernos';

  @override
  String get emptyNotebooksBody =>
      'Crie o seu primeiro caderno para começar a escrever.';

  @override
  String get emptySearchTitle => 'Sem resultados';

  @override
  String get emptySearchBody => 'Experimente outro termo de pesquisa.';

  @override
  String get emptyNotebookTitle => 'Ainda não há notas';

  @override
  String get emptyNotebookBody =>
      'Toque em + para escrever a sua primeira nota.';

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
  String get penFountainPen => 'Caneta de tinta permanente';

  @override
  String get penGelPen => 'Caneta de gel';

  @override
  String get penPencil => 'Lápis';

  @override
  String get penHighlighter => 'Marcador';

  @override
  String get penEraser => 'Borracha';

  @override
  String get penStrokeWidth => 'Espessura do traço';

  @override
  String get toggleHandwritingMode => 'Alternar entre escrever e desenhar';

  @override
  String get biometricLockReason => 'Desbloqueie para ver esta nota';

  @override
  String get noteLockedMessage => 'Esta nota está bloqueada';

  @override
  String get unlockButton => 'Desbloquear';

  @override
  String get noteLockTurnedOffMessage =>
      'O bloqueio de notas foi desativado porque este dispositivo não tem bloqueio de ecrã nem biometria configurados.';

  @override
  String get biometricEnableReason =>
      'Confirme a sua identidade para ativar o bloqueio de notas';

  @override
  String get biometricDisableReason =>
      'Confirme a sua identidade para desativar o bloqueio de notas';

  @override
  String get biometricShareReason =>
      'Desbloqueie para partilhar ou exportar esta nota';

  @override
  String get biometricAuthFailedMessage =>
      'Não foi possível verificar a sua identidade.';

  @override
  String get biometricSetupNeededMessage =>
      'Configure primeiro um bloqueio de ecrã ou uma impressão digital nas definições do dispositivo.';

  @override
  String get privacyChoicesTitle => 'Opções de privacidade';

  @override
  String get purchaseFailedMessage =>
      'Não foi possível concluir a compra. Tente novamente.';

  @override
  String get restoreSuccessMessage => 'A sua compra foi restaurada.';

  @override
  String get restoreNothingFoundMessage =>
      'Não foi encontrada nenhuma compra anterior para esta conta.';

  @override
  String get restoreFailedMessage =>
      'Não foi possível restaurar as compras. Verifique a ligação e tente novamente.';

  @override
  String get reminderScheduleFailedMessage =>
      'Não foi possível agendar o lembrete. Tente novamente.';

  @override
  String get storageIssueNotebooksLoad =>
      'Não foi possível carregar alguns cadernos. A mostrar o que está disponível.';

  @override
  String get storageIssueNotebookSave =>
      'É possível que este caderno não tenha sido guardado. Tente novamente.';

  @override
  String get storageIssueNotebookChange =>
      'É possível que esta alteração não tenha sido guardada. Tente novamente.';

  @override
  String get storageIssueNotebookDelete =>
      'Não foi possível eliminar o caderno. Tente novamente.';

  @override
  String get storageIssueNotebookOrder =>
      'É possível que a nova ordem não tenha sido guardada. Tente novamente.';

  @override
  String get storageIssueNotesLoad =>
      'Não foi possível carregar algumas notas. A mostrar o que está disponível.';

  @override
  String get storageIssueSearch =>
      'Os resultados da pesquisa podem estar incompletos neste momento.';

  @override
  String get storageIssueNoteSave =>
      'É possível que esta nota não tenha sido guardada. Verifique o armazenamento do dispositivo.';

  @override
  String get storageIssueNoteDelete =>
      'Não foi possível eliminar a nota. Tente novamente.';

  @override
  String get purchaseUnavailableMessage =>
      'Esta compra não está disponível neste momento. Tente novamente mais tarde.';

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
  String get paperStyleDotGrid => 'Grelha de pontos';

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
  String get fontSectionTitle => 'Tipo de letra das notas';

  @override
  String get fontSystem => 'Sistema';

  @override
  String get fontSerif => 'Com serifa';

  @override
  String get fontInter => 'Inter';

  @override
  String get fontLora => 'Lora';

  @override
  String get themeSectionTitle => 'Aspeto';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get themeParchment => 'Pergaminho';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get verseSectionTitle => 'Apresentação do versículo diário';

  @override
  String get verseModeWatermark => 'Marca de água';

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
  String get reminderTimeLabel => 'Hora do lembrete';

  @override
  String get notificationPermissionDenied =>
      'As notificações estão desativadas nas definições do sistema.';

  @override
  String get dailyReminderBody => 'O seu versículo diário está pronto.';

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
  String get rateAppSubtitle => 'Gosta da aplicação? Deixe uma avaliação';

  @override
  String get shareAppTitle => 'Partilhar Atrament';

  @override
  String get shareAppSubtitle => 'Conte a um amigo';

  @override
  String get shareAppMessage =>
      'Experimente Atrament — um bloco de notas sem distrações, com texturas de papel.';

  @override
  String get languageSectionTitle => 'Idioma';

  @override
  String get languageFollowsSystem =>
      'Segue a definição de idioma do seu dispositivo';

  @override
  String get languageSystem => 'Predefinição do sistema';

  @override
  String get languagePickerTitle => 'Escolher idioma';

  @override
  String get premiumScreenTitle => 'Remover anúncios';

  @override
  String get premiumHeadline => 'Escreva sem distrações';

  @override
  String get premiumBody =>
      'O Atrament é gratuito, com um pequeno banner publicitário. Removê-lo é uma compra única que não desbloqueia mais nada — todas as funcionalidades já são suas.';

  @override
  String get premiumRestoreButton => 'Restaurar compras';

  @override
  String get premiumAlreadyProMessage => 'Já tem Remover anúncios. Obrigado!';

  @override
  String get supportSectionTitle => 'Suporte';

  @override
  String get shareDebugLogButton => 'Partilhar registo de depuração';

  @override
  String get shareDebugLogSubtitle =>
      'Envie um relatório técnico se algo não estiver a funcionar';

  @override
  String get noDebugLogMessage => 'Ainda não há nada para comunicar.';

  @override
  String get clearDebugLogButton => 'Limpar registo de depuração';

  @override
  String get clearDebugLogTitle => 'Limpar o registo de depuração?';

  @override
  String get clearDebugLogBody =>
      'Isto remove o relatório técnico guardado no seu dispositivo.';

  @override
  String get debugLogClearedMessage => 'Registo de depuração limpo.';

  @override
  String get premiumUnlockLabel => 'Remover anúncios para sempre';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';

  @override
  String get chipAll => 'Tudo';

  @override
  String get chipNotebooks => 'Cadernos';

  @override
  String get chipRecent => 'Recentes';

  @override
  String get emptyAllNotesTitle => 'Ainda não há notas';

  @override
  String get emptyAllNotesBody =>
      'Toque em + para escrever a sua primeira nota.';

  @override
  String get emptyRecentNotesTitle => 'Nada recente';

  @override
  String get emptyRecentNotesBody => 'As notas que editar aparecerão aqui.';

  @override
  String get noteActionRename => 'Mudar o nome';

  @override
  String get noteActionMoveToNotebook => 'Mover para caderno';

  @override
  String get noteActionEdit => 'Editar';

  @override
  String get noteActionExport => 'Exportar';

  @override
  String get noteActionShare => 'Partilhar';

  @override
  String get moveToNotebookTitle => 'Mover para caderno';

  @override
  String get moveToNotebookEmptyBody =>
      'Ainda não há outros cadernos. Crie um para organizar esta nota.';

  @override
  String get moveToNotebookCreateRow => 'Criar novo caderno';

  @override
  String get notebookActionRename => 'Mudar o nome';

  @override
  String get notebookActionChangeCover => 'Alterar capa';

  @override
  String get notebookRenameDialogTitle => 'Mudar o nome do caderno';

  @override
  String get notebookCoverPickerTitle => 'Escolher uma cor de capa';

  @override
  String deleteNotebookWithCountBody(int count) {
    return 'Isto eliminará o caderno e as respetivas $count notas. Esta ação não pode ser anulada.';
  }

  @override
  String get legalAndSupportSectionTitle => 'Informação legal e suporte';

  @override
  String get privacyPolicyRow => 'Política de Privacidade';

  @override
  String get termsOfServiceRow => 'Termos de Utilização';

  @override
  String get supportRow => 'Suporte';

  @override
  String get openLinkFailedMessage =>
      'Não foi possível abrir a ligação. Tente novamente.';

  @override
  String get openSourceLicensesRow => 'Licenças de código aberto';
}
