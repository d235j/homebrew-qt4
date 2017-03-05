require File.dirname(__FILE__) + "/lib/qtformula.rb"

class QtGuiAT4 < QtFormula
  desc "The GUI part of Qt 4"
  
  # Backport of Qt5 commit to fix the fatal build error with Xcode 7, SDK 10.11.
  # https://code.qt.io/cgit/qt/qtbase.git/commit/?id=b06304e164ba47351fa292662c1e6383c081b5ca
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/480b7142c4e2ae07de6028f672695eb927a34875/qt/el-capitan.patch"
    sha256 "c8a0fa819c8012a7cb70e902abb7133fc05235881ce230235d93719c47650c4e"
  end
  
  setup_qt_formula ["qt-corelib", "rcc", "uic"], "src/gui", ["--enable-gui"]
end
