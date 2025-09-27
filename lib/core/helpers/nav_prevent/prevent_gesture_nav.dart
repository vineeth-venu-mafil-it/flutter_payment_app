import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:js' as js;

void preventBackNavigation() {
  if (kIsWeb) {
    _injectPreventionScript();
  }
}
void _injectPreventionScript() {
  const jsCode = '''
(function() {
// Prevent back navigation
history.pushState(null, null, document.URL);
window.addEventListener('popstate', function(event) {
history.pushState(null, null, document.URL);
});

// Only prevent horizontal wheel events that would cause navigation
// but allow them for scrollable elements
document.addEventListener('wheel', function(e) {
// Only prevent if it's primarily horizontal AND we're at the edge of the page
if (Math.abs(e.deltaX) > Math.abs(e.deltaY)) {
const atLeftEdge = window.scrollX === 0;
const atRightEdge = window.scrollX + window.innerWidth >= document.documentElement.scrollWidth;

// Only prevent if we're at the edge and trying to scroll beyond
if ((e.deltaX > 0 && atLeftEdge) || (e.deltaX < 0 && atRightEdge)) {
e.preventDefault();
}
// Otherwise allow horizontal scrolling within content
}
}, { passive: false });
})();
''';

  try {
    js.context.callMethod('eval', [jsCode]);
  } catch (e){};


}


