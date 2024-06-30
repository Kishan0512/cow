import 'dart:math' as math;

import 'package:flutter/material.dart' hide YearPicker;
import 'package:intl/intl.dart';


// ################################# CONSTANTS #################################
const _portraitDialogSize = Size(320.0, 480.0);
const _landscapeDialogSize = Size(496.0, 344.0);
const _dialogSizeAnimationDuration = Duration(milliseconds: 200);
const _datePickerHeaderLandscapeWidth = 192.0;
const _datePickerHeaderPortraitHeight = 120.0;
const _headerPaddingLandscape = 16.0;
typedef SelectableMonthYearPredicate = bool Function(DateTime my);

// ################################# FUNCTIONS #################################
/// Displays month year picker dialog.
/// [initialDate] is the initially selected month.
/// [firstDate] is the lower bound for month selection.
/// [lastDate] is the upper bound for month selection.
Future<DateTime?> showMonthYearPicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
  SelectableMonthYearPredicate? selectableMonthYearPredicate,
  Locale? locale,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  TextDirection? txtDirection,
  TransitionBuilder? builder,
  MonthYearPickerMode initialMonthYearPickerMode = MonthYearPickerMode.month,
}) async {
  initialDate = monthYearOnly(initialDate);
  firstDate = monthYearOnly(firstDate);
  lastDate = monthYearOnly(lastDate);

  assert(
  !initialDate.isBefore(firstDate),
  'initialDate $initialDate must be on or after firstDate $firstDate.',
  );
  assert(
  !initialDate.isAfter(lastDate),
  'initialDate $initialDate must be on or before lastDate $lastDate.',
  );

  assert(
  !lastDate.isBefore(firstDate),
  'lastDate $lastDate must be on or after firstDate $firstDate.',
  );
  assert(debugCheckHasMaterialLocalizations(context));
  assert(debugCheckHasDirectionality(context));

  Widget dialog = MonthYearPickerDialog(
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    initialMonthYearPickerMode: initialMonthYearPickerMode,
    selectableMonthYearPredicate: selectableMonthYearPredicate,
  );
  //
  // if (txtDirection != null) {
  //   dialog = Directionality(
  //     textDirection: txtDirection,
  //     child: dialog,
  //   );
  // }

  if (locale != null) {
    dialog = Localizations.override(
      context: context,
      locale: locale,
      child: dialog,
    );
  }

  return await showDialog<DateTime>(
    context: context,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    builder: (context) => builder == null ? dialog : builder(context, dialog),
  );
}

// ################################ ENUMERATIONS ###############################
enum MonthYearPickerMode {
  month,
  year,
}

// ################################## CLASSES ##################################
class MonthYearPickerDialog extends StatefulWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const MonthYearPickerDialog({
    Key? key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.initialMonthYearPickerMode,
    this.selectableMonthYearPredicate,
  }) : super(key: key);

  // ---------------------------------- FIELDS ---------------------------------
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final MonthYearPickerMode initialMonthYearPickerMode;
  final SelectableMonthYearPredicate? selectableMonthYearPredicate;

  // --------------------------------- METHODS ---------------------------------
  @override
  State<MonthYearPickerDialog> createState() => _MonthYearPickerDialogState();
}

class _MonthYearPickerDialogState extends State<MonthYearPickerDialog> {
  // ---------------------------------- FIELDS ---------------------------------
  final _yearPickerState = GlobalKey<YearPickerState>();
  final _monthPickerState = GlobalKey<MonthPickerState>();
  var _isShowingYear = false;
  var _canGoPrevious = false;
  var _canGoNext = false;
  late DateTime _selectedDate = widget.initialDate;

  // -------------------------------- PROPERTIES -------------------------------
  Size get _dialogSize {
    final orientation = MediaQuery.of(context).orientation;
    final offset =
    Theme.of(context).materialTapTargetSize == MaterialTapTargetSize.padded
        ? const Offset(0.0, 24.0)
        : Offset.zero;
    switch (orientation) {
      case Orientation.portrait:
        return _portraitDialogSize + offset;
      case Orientation.landscape:
        return _landscapeDialogSize + offset;
    }
  }

  // --------------------------------- METHODS ---------------------------------
  @override
  void initState() {
    super.initState();
    _isShowingYear =
        widget.initialMonthYearPickerMode == MonthYearPickerMode.year;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(_updatePaginators);
    });
  }

  @override
  Widget build(BuildContext context) {
    final materialLocalizations = MaterialLocalizations.of(context);
    final media = MediaQuery.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final orientation = media.orientation;
    final textTheme = theme.textTheme;
    // Constrain the textScaleFactor to the largest supported value to prevent
    // layout issues.
    final textScaleFactor = math.min(media.textScaleFactor, 1.3);
    final direction = Directionality.of(context);

    final dateText = materialLocalizations.formatMonthYear(_selectedDate);
    final onPrimarySurface = colorScheme.brightness == Brightness.light
        ? colorScheme.onPrimary
        : colorScheme.onSurface;
    final dateStyle = orientation == Orientation.landscape
        ? textTheme.headline5?.copyWith(color: onPrimarySurface)
        : textTheme.headline4?.copyWith(color: onPrimarySurface);

    final Widget actions = Container(
      alignment: AlignmentDirectional.centerEnd,
      constraints: const BoxConstraints(minHeight: 52.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: OverflowBar(
        spacing: 8.0,
        children: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Can"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, _selectedDate),
            child: Text("OK"),
          ),
        ],
      ),
    );

    final semanticText = materialLocalizations.formatMonthYear(_selectedDate);
    final header = _Header(
      titleText: dateText,
      titleSemanticsLabel: semanticText,
      titleStyle: dateStyle,
      orientation: orientation,
    );

    final switcher = Stack(
      children: [
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsetsDirectional.fromSTEB(
              32.0,
              24.0,
              8.0,
              24.0,
            ),
            primary: Theme.of(context).textTheme.caption?.color,
          ),
          child: Row(
            children: [
              Text(materialLocalizations.formatYear(_selectedDate)),
              AnimatedRotation(
                duration: _dialogSizeAnimationDuration,
                turns: _isShowingYear ? 0.5 : 0.0,
                child: const Icon(Icons.arrow_drop_down),
              ),
            ],
          ),
          onPressed: () {
            setState(() {
              _isShowingYear = !_isShowingYear;
              _updatePaginators();
            });
          },
        ),
        PositionedDirectional(
          end: 0.0,
          top: 0.0,
          bottom: 0.0,
          child: Row(
            children: [
              IconButton(
                splashRadius: 18,
                icon: Icon(
                  direction == TextDirection.RTL
                      ? Icons.keyboard_arrow_right
                      : Icons.keyboard_arrow_left,
                ),
                onPressed: _canGoPrevious ? _goToPreviousPage : null,
              ),
              IconButton(   splashRadius: 18,
                icon: Icon(
                  direction == TextDirection.RTL
                      ? Icons.keyboard_arrow_left
                      : Icons.keyboard_arrow_right,
                ),
                onPressed: _canGoNext ? _goToNextPage : null,
              )
            ],
          ),
        ),
        const SizedBox(width: 12.0),
      ],
    );

    final picker = LayoutBuilder(
      builder: (context, constraints) {
        final pickerMaxWidth =
            _landscapeDialogSize.width - _datePickerHeaderLandscapeWidth;
        final width = constraints.maxHeight < pickerMaxWidth
            ? constraints.maxHeight / 3.0 * 4.0
            : null;

        return Stack(
          children: [
            AnimatedPositioned(
              duration: _dialogSizeAnimationDuration,
              curve: Curves.easeOut,
              left: 0.0,
              right: (pickerMaxWidth - (width ?? pickerMaxWidth)),
              top: _isShowingYear ? 0.0 : -constraints.maxHeight,
              bottom: _isShowingYear ? 0.0 : constraints.maxHeight,
              child: SizedBox(
                height: constraints.maxHeight,
                child: YearPicker(
                  key: _yearPickerState,
                  initialDate: _selectedDate,
                  firstDate: widget.firstDate,
                  lastDate: widget.lastDate,
                  onPageChanged: _updateSelectedDate,
                  onYearSelected: _updateYear,
                  selectedDate: _selectedDate,
                  selectableMonthYearPredicate:
                  widget.selectableMonthYearPredicate,
                ),
              ),
            ),
            AnimatedPositioned(
              duration: _dialogSizeAnimationDuration,
              curve: Curves.easeOut,
              left: 0.0,
              right: (pickerMaxWidth - (width ?? pickerMaxWidth)),
              top: _isShowingYear ? constraints.maxHeight : 0.0,
              bottom: _isShowingYear ? -constraints.maxHeight : 0.0,
              child: SizedBox(
                height: constraints.maxHeight,
                child: MonthPicker(
                  key: _monthPickerState,
                  initialDate: _selectedDate,
                  firstDate: widget.firstDate,
                  lastDate: widget.lastDate,
                  onPageChanged: _updateSelectedDate,
                  onMonthSelected: _updateMonth,
                  selectedDate: _selectedDate,
                  selectableMonthYearPredicate:
                  widget.selectableMonthYearPredicate,
                ),
              ),
            )
          ],
        );
      },
    );

    final dialogSize = _dialogSize * textScaleFactor;
    return Directionality(
      textDirection: direction,
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 24.0,
        ),
        clipBehavior: Clip.antiAlias,
        child: AnimatedContainer(
          width: dialogSize.width,
          height: dialogSize.height,
          duration: _dialogSizeAnimationDuration,
          curve: Curves.easeIn,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: textScaleFactor,
            ),
            child: Builder(
              builder: (context) {
                switch (orientation) {
                  case Orientation.portrait:
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        header,
                        switcher,
                        Expanded(child: picker),
                        actions,
                      ],
                    );
                  case Orientation.landscape:
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        header,
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              switcher,
                              Expanded(child: picker),
                              actions,
                            ],
                          ),
                        ),
                      ],
                    );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  void _updateYear(DateTime date) {
    setState(() {
      _selectedDate = DateTime(date.year, _selectedDate.month);
      _isShowingYear = false;
      _monthPickerState.currentState!.goToYear(year: _selectedDate.year);
    });
  }

  void _updateMonth(DateTime date) {
    setState(() {
      _selectedDate = DateTime(date.year, date.month);
    });
  }

  void _updateSelectedDate(DateTime date) {
    setState(() {
      _selectedDate = DateTime(date.year, date.month);
      _updatePaginators();
    });
  }

  void _updatePaginators() {
    if (_isShowingYear) {
      _canGoNext = _yearPickerState.currentState!.canGoUp;
      _canGoPrevious = _yearPickerState.currentState!.canGoDown;
    } else {
      _canGoNext = _monthPickerState.currentState!.canGoUp;
      _canGoPrevious = _monthPickerState.currentState!.canGoDown;
    }
  }

  void _goToPreviousPage() {
    if (_isShowingYear) {
      _yearPickerState.currentState!.goDown();
    } else {
      _monthPickerState.currentState!.goDown();
    }
  }

  void _goToNextPage() {
    if (_isShowingYear) {
      _yearPickerState.currentState!.goUp();
    } else {
      _monthPickerState.currentState!.goUp();
    }
  }
}

class _Header extends StatelessWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const _Header({
    Key? key,
    required this.titleText,
    this.titleSemanticsLabel,
    required this.titleStyle,
    required this.orientation,
  }) : super(key: key);

  // ---------------------------------- FIELDS ---------------------------------
  final String titleText;
  final String? titleSemanticsLabel;
  final TextStyle? titleStyle;
  final Orientation orientation;

  // --------------------------------- METHODS ---------------------------------
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // The header should use the primary color in light themes and surface color
    // in dark.
    final isDark = colorScheme.brightness == Brightness.dark;
    final primarySurfaceColor =
    isDark ? colorScheme.surface : colorScheme.primary;
    final onPrimarySurfaceColor =
    isDark ? colorScheme.onSurface : colorScheme.onPrimary;

    final helpStyle = textTheme.overline?.copyWith(
      color: onPrimarySurfaceColor,
    );

    final help = Text(
      titleText,
      style: helpStyle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );

    final title = Text(
      titleText,
      semanticsLabel: titleSemanticsLabel ?? titleText,
      style: titleStyle,
      maxLines: orientation == Orientation.portrait ? 1 : 2,
      overflow: TextOverflow.ellipsis,
    );

    switch (orientation) {
      case Orientation.portrait:
        return SizedBox(
          height: _datePickerHeaderPortraitHeight,
          child: Material(
            color: primarySurfaceColor,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 24.0,
                end: 12.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  help,
                  const Flexible(child: SizedBox(height: 38.0)),
                  title,
                ],
              ),
            ),
          ),
        );
      case Orientation.landscape:
        return SizedBox(
          width: _datePickerHeaderLandscapeWidth,
          child: Material(
            color: primarySurfaceColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: _headerPaddingLandscape,
                  ),
                  child: help,
                ),
                const SizedBox(height: 56.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: _headerPaddingLandscape,
                    ),
                    child: title,
                  ),
                ),
              ],
            ),
          ),
        );
    }
  }
}


DateTime monthYearOnly(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month);
}

class MonthPicker extends StatefulWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const MonthPicker({
    required this.firstDate,
    required this.lastDate,
    required this.initialDate,
    required this.selectedDate,
    required this.onMonthSelected,
    required this.onPageChanged,
    this.selectableMonthYearPredicate,
    Key? key,
  }) : super(key: key);

  // ---------------------------------- FIELDS ---------------------------------
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime initialDate;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onMonthSelected;
  final ValueChanged<DateTime> onPageChanged;
  final SelectableMonthYearPredicate? selectableMonthYearPredicate;

  // --------------------------------- METHODS ---------------------------------
  @override
  State<MonthPicker> createState() => MonthPickerState();
}

class MonthPickerState extends State<MonthPicker> {
  // ---------------------------------- FIELDS ---------------------------------
  late final PageController _pageController;
  var _currentPage = 0;

  // -------------------------------- PROPERTIES -------------------------------
  bool get canGoDown => _currentPage > 0;

  bool get canGoUp => _currentPage < (_pageCount - 1);

  int get _pageCount => widget.lastDate.year - widget.firstDate.year + 1;

  // --------------------------------- METHODS ---------------------------------
  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialDate.year - widget.firstDate.year;
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      physics: const AlwaysScrollableScrollPhysics(),
      onPageChanged: _onPageChanged,
      itemCount: _pageCount,
      itemBuilder: _buildItem,
    );
  }

  void goToYear({required int year}) {
    _currentPage = year - widget.firstDate.year;
    _pageController.jumpToPage(_currentPage);
  }

  void goDown() {
    _currentPage = _pageController.page!.toInt() - 1;
    _pageController.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void goUp() {
    _currentPage = _pageController.page!.toInt() + 1;
    _pageController.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildItem(final BuildContext context, final int page) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8.0),
      crossAxisCount: 4,
      children: [
        for (var i = 0; i < 12; i++)
          _MonthButton(
            page: page,
            index: i,
            firstDate: widget.firstDate,
            lastDate: widget.lastDate,
            selectedDate: widget.selectedDate,
            onMonthSelected: widget.onMonthSelected,
            selectableMonthYearPredicate: widget.selectableMonthYearPredicate,
          ),
      ],
    );
  }

  void _onPageChanged(final int page) {
    _currentPage = page;
    var newDate = DateTime(
      widget.firstDate.year + page,
      widget.selectedDate.month,
    );
    while (newDate.isAfter(widget.lastDate)) {
      newDate = newDate.subtract(const Duration(days: 1));
    }
    widget.onPageChanged(newDate);
  }
}

class YearPicker extends StatefulWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const YearPicker({
    required this.firstDate,
    required this.lastDate,
    required this.initialDate,
    required this.selectedDate,
    required this.onYearSelected,
    required this.onPageChanged,
    this.selectableMonthYearPredicate,
    Key? key,
  }) : super(key: key);

  // ---------------------------------- FIELDS ---------------------------------
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime initialDate;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onYearSelected;
  final ValueChanged<DateTime> onPageChanged;
  final SelectableMonthYearPredicate? selectableMonthYearPredicate;

  // --------------------------------- METHODS ---------------------------------
  @override
  State<YearPicker> createState() => YearPickerState();
}

class YearPickerState extends State<YearPicker> {
  // ---------------------------------- FIELDS ---------------------------------
  late final PageController _pageController;
  var _currentPage = 0;

  // -------------------------------- PROPERTIES -------------------------------
  bool get canGoDown => _currentPage > 0;

  bool get canGoUp => _currentPage < (_pageCount - 1);

  int get _pageCount =>
      ((widget.lastDate.year - widget.firstDate.year + 1) / 12).ceil();

  // --------------------------------- METHODS ---------------------------------
  @override
  void initState() {
    super.initState();
    _currentPage =
        ((widget.initialDate.year - widget.firstDate.year) / 12).floor();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      onPageChanged: _onPageChanged,
      itemCount: _pageCount,
      itemBuilder: _buildItem,
    );
  }

  void goDown() {
    _currentPage = _pageController.page!.toInt() - 1;
    _pageController.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void goUp() {
    _currentPage = _pageController.page!.toInt() + 1;
    _pageController.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildItem(final BuildContext context, final int page) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8.0),
      crossAxisCount: 4,
      children: [
        for (var i = 0; i < 12; i++)
          _YearButton(
            page: page,
            index: i,
            firstDate: widget.firstDate,
            lastDate: widget.lastDate,
            selectedDate: widget.selectedDate,
            onYearSelected: widget.onYearSelected,
            selectableMonthYearPredicate: widget.selectableMonthYearPredicate,
          ),
      ],
    );
  }

  void _onPageChanged(final int page) {
    _currentPage = page;
    widget.onPageChanged(DateTime(widget.firstDate.year + (page * 12)));
  }
}
class _MonthButton extends StatelessWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const _MonthButton({
    required this.page,
    required this.index,
    required this.firstDate,
    required this.lastDate,
    required this.selectedDate,
    required this.onMonthSelected,
    this.selectableMonthYearPredicate,
    Key? key,
  }) : super(key: key);

  // ---------------------------------- FIELDS ---------------------------------
  final int page;
  final int index;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onMonthSelected;
  final SelectableMonthYearPredicate? selectableMonthYearPredicate;

  // --------------------------------- METHODS ---------------------------------
  @override
  Widget build(BuildContext context) {
    final year = firstDate.year + page;
    final date = DateTime(year, index + 1);
    final locale = Localizations.localeOf(context).toString();

    final isEnabled = selectableMonthYearPredicate == null
        ? firstDate.compareTo(date) <= 0 && lastDate.compareTo(date) >= 0
        : selectableMonthYearPredicate!(date);
    final isSelected =
        date.month == selectedDate.month && date.year == selectedDate.year;

    final now = DateTime.now();
    final isThisMonth = date.month == now.month && date.year == now.year;

    return _Button(
      label: DateFormat.MMM(locale).format(date),
      isEnabled: isEnabled,
      isHighlighted: isThisMonth,
      isSelected: isSelected,
      onPressed: () => onMonthSelected(DateTime(date.year, date.month)),
    );
  }
}

class _YearButton extends StatelessWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const _YearButton({
    required this.page,
    required this.index,
    required this.firstDate,
    required this.lastDate,
    required this.selectedDate,
    required this.onYearSelected,
    this.selectableMonthYearPredicate,
    Key? key,
  }) : super(key: key);

  // ---------------------------------- FIELDS ---------------------------------
  final int page;
  final int index;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onYearSelected;
  final SelectableMonthYearPredicate? selectableMonthYearPredicate;

  // --------------------------------- METHODS ---------------------------------
  @override
  Widget build(BuildContext context) {
    final year = firstDate.year + (page * 12) + index;
    final date = DateTime(year);
    final locale = Localizations.localeOf(context).toString();

    final isEnabled = selectableMonthYearPredicate == null
        ? year >= firstDate.year && year <= lastDate.year
        : selectableMonthYearPredicate!(date);
    final isSelected = year == selectedDate.year;

    final now = DateTime.now();
    final isThisYear = year == now.year;

    return _Button(
      label: DateFormat.y(locale).format(date),
      isEnabled: isEnabled,
      isHighlighted: isThisYear,
      isSelected: isSelected,
      onPressed: () => onYearSelected(DateTime(date.year)),
    );
  }
}

class _Button extends StatelessWidget {
  // ------------------------------- CONSTRUCTORS ------------------------------
  const _Button({
    required this.label,
    required this.isEnabled,
    required this.isHighlighted,
    required this.isSelected,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  // ---------------------------------- FIELDS ---------------------------------
  final String label;
  final bool isEnabled;
  final bool isHighlighted;
  final bool isSelected;
  final void Function() onPressed;

  // --------------------------------- METHODS ---------------------------------
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final buttonBackground = isSelected ? colorScheme.secondary : null;
    final buttonText = isSelected
        ? colorScheme.onSecondary
        : isHighlighted
        ? colorScheme.secondary
        : colorScheme.onSurface;

    return TextButton(
      onPressed: isEnabled ? onPressed : null,
      style: TextButton.styleFrom(
        backgroundColor: buttonBackground,
        primary: buttonText,
        onSurface: buttonText,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        textStyle: TextStyle(color: buttonText),
      ),
      child: Text(label),
    );
  }
}


