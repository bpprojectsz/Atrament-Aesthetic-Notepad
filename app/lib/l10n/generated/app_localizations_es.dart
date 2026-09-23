// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Atrament';

  @override
  String get retry => 'Reintentar';

  @override
  String get errorGeneric => 'Algo salió mal';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get delete => 'Eliminar';

  @override
  String get undo => 'Deshacer';

  @override
  String get redo => 'Rehacer';

  @override
  String get untitledNote => 'Sin título';

  @override
  String get deleteConfirmBody => 'Esto no se puede deshacer.';

  @override
  String get deleteNoteTitle => '¿Eliminar esta nota?';

  @override
  String deleteNotebookTitle(String name) {
    return '¿Eliminar \"$name\"?';
  }

  @override
  String get saveFailedMessage => 'No se pudo guardar. Inténtalo de nuevo.';

  @override
  String get exportFailedMessage =>
      'No se pudo exportar esta nota. Inténtalo de nuevo.';

  @override
  String get shareFailedMessage =>
      'No se pudo abrir el panel para compartir. Inténtalo de nuevo.';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get searchHint => 'Buscar notas';

  @override
  String get emptyNotebooksTitle => 'Aún no hay cuadernos';

  @override
  String get emptyNotebooksBody =>
      'Crea tu primer cuaderno para empezar a escribir.';

  @override
  String get emptySearchTitle => 'Sin resultados';

  @override
  String get emptySearchBody => 'Prueba con otro término de búsqueda.';

  @override
  String get emptyNotebookTitle => 'Aún no hay notas';

  @override
  String get emptyNotebookBody =>
      'Toca el botón + para escribir tu primera nota.';

  @override
  String get newNotebookTitle => 'Nuevo cuaderno';

  @override
  String get notebookNameHint => 'Nombre del cuaderno';

  @override
  String get newNoteTitle => 'Nueva nota';

  @override
  String get sortOptionsTitle => 'Ordenar';

  @override
  String get sortByModified => 'Última edición';

  @override
  String get sortByCreated => 'Fecha de creación';

  @override
  String get sortByTitle => 'Título';

  @override
  String get formatBold => 'Negrita';

  @override
  String get formatItalic => 'Cursiva';

  @override
  String get formatUnderline => 'Subrayado';

  @override
  String get formatHeading => 'Encabezado';

  @override
  String get formatBulletList => 'Lista con viñetas';

  @override
  String get formatChecklist => 'Lista de tareas';

  @override
  String get formatQuote => 'Cita';

  @override
  String get formatCodeBlock => 'Bloque de código';

  @override
  String get penFountainPen => 'Pluma estilográfica';

  @override
  String get penGelPen => 'Bolígrafo de gel';

  @override
  String get penPencil => 'Lápiz';

  @override
  String get penHighlighter => 'Resaltador';

  @override
  String get penEraser => 'Borrador';

  @override
  String get penStrokeWidth => 'Grosor del trazo';

  @override
  String get toggleHandwritingMode => 'Alternar entre escribir y dibujar';

  @override
  String get biometricLockReason => 'Desbloquea para ver esta nota';

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
  String get paperStyleLined => 'Rayado';

  @override
  String get paperStyleDotGrid => 'Cuadrícula de puntos';

  @override
  String get paperStyleGrid => 'Cuadrícula';

  @override
  String get paperStyleBlank => 'En blanco';

  @override
  String get paperStyleCream => 'Crema';

  @override
  String get paperStyleParchment => 'Pergamino';

  @override
  String get paperStyleVellum => 'Vitela';

  @override
  String get fontSectionTitle => 'Fuente de la nota';

  @override
  String get fontSystem => 'Sistema';

  @override
  String get fontSerif => 'Serif';

  @override
  String get themeSectionTitle => 'Apariencia';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeParchment => 'Pergamino';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get verseSectionTitle => 'Visualización del versículo diario';

  @override
  String get verseModeWatermark => 'Marca de agua';

  @override
  String get verseModeHeader => 'Encabezado';

  @override
  String get verseModeFooter => 'Pie de página';

  @override
  String get verseModeOff => 'Desactivado';

  @override
  String get notificationsSectionTitle => 'Notificaciones';

  @override
  String get dailyReminderToggle => 'Recordatorio diario de versículo';

  @override
  String get reminderTimeLabel => 'Hora del recordatorio';

  @override
  String get notificationPermissionDenied =>
      'Las notificaciones están desactivadas en la configuración del sistema.';

  @override
  String get dailyReminderBody => 'Tu versículo diario está listo.';

  @override
  String get privacySectionTitle => 'Privacidad';

  @override
  String get biometricLockToggle =>
      'Bloquear notas con Face ID / huella digital';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get removeAdsTitle => 'Quitar anuncios';

  @override
  String get restorePurchasesButton => 'Restaurar compras';

  @override
  String get proLabel => 'Pro';

  @override
  String get languageSectionTitle => 'Idioma';

  @override
  String get languageFollowsSystem =>
      'Sigue el idioma configurado en tu dispositivo';

  @override
  String get premiumScreenTitle => 'Quitar anuncios';

  @override
  String get premiumHeadline => 'Escribe sin distracciones';

  @override
  String get premiumBody =>
      'Atrament es gratis con un pequeño banner publicitario. Eliminarlo es una compra única que no desbloquea nada más — todas las funciones ya son tuyas.';

  @override
  String get premiumRestoreButton => 'Restaurar compras';

  @override
  String get premiumAlreadyProMessage => 'Ya tienes Quitar anuncios. ¡Gracias!';

  @override
  String get supportSectionTitle => 'Soporte';

  @override
  String get shareDebugLogButton => 'Compartir registro de depuración';

  @override
  String get shareDebugLogSubtitle =>
      'Envía un informe técnico si algo no funciona';

  @override
  String get noDebugLogMessage => 'Aún no hay incidencias que reportar.';

  @override
  String get clearDebugLogButton => 'Borrar registro de depuración';

  @override
  String get clearDebugLogTitle => '¿Borrar el registro de depuración?';

  @override
  String get clearDebugLogBody =>
      'Esto elimina el informe técnico guardado en tu dispositivo.';

  @override
  String get debugLogClearedMessage => 'Registro de depuración borrado.';

  @override
  String get premiumUnlockLabel => 'Eliminar anuncios para siempre';

  @override
  String get premiumUnlockPriceFallback => '\$14.99';
}
