require File.dirname(__FILE__) + "/lib/qtformula.rb"

class QtCorelibAT4 < QtFormula
  desc "Core library for Qt 4"
  
  depends_on "cartr/qt4/moc@4"
  
  # Backport of Qt5 patch to fix an issue with null bytes in QSetting strings.
  patch do
    url "https://raw.githubusercontent.com/cartr/homebrew-qt4/41669527a2aac6aeb8a5eeb58f440d3f3498910a/patches/qsetting-nulls.patch"
    sha256 "0deb4cd107853b1cc0800e48bb36b3d5682dc4a2a29eb34a6d032ac4ffe32ec3"
  end
  
  setup_qt_formula [], "src/corelib"
end
