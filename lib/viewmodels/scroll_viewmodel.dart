import 'package:flutter/material.dart';

class ScrollViewModel extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  
  final Map<String, GlobalKey> sectionKeys = {
    'About': GlobalKey(),
    'Skills': GlobalKey(),
    'Projects': GlobalKey(),
    'Experience': GlobalKey(),
    'YouTube': GlobalKey(),
    'Teaching': GlobalKey(),
    'Contact': GlobalKey(),
    'Hero': GlobalKey(),
  };

  bool _isNavbarScrolled = false;
  String _activeSection = 'Hero';

  bool get isNavbarScrolled => _isNavbarScrolled;
  String get activeSection => _activeSection;

  ScrollViewModel() {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.offset > 50 && !_isNavbarScrolled) {
      _isNavbarScrolled = true;
      notifyListeners();
    } else if (scrollController.offset <= 50 && _isNavbarScrolled) {
      _isNavbarScrolled = false;
      notifyListeners();
    }
    
    _updateActiveSection();
  }

  void _updateActiveSection() {
    for (var entry in sectionKeys.entries) {
      final key = entry.value;
      final context = key.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero).dy;
        // If the section is near the top of the viewport
        if (position >= -200 && position <= 200) {
          if (_activeSection != entry.key) {
            _activeSection = entry.key;
            notifyListeners();
          }
          break;
        }
      }
    }
  }

  void scrollToSection(String sectionName) {
    final key = sectionKeys[sectionName];
    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
      _activeSection = sectionName;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }
}
