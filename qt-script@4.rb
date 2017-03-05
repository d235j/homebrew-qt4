require File.dirname(__FILE__) + "/lib/qtformula.rb"

class QtScriptAT4 < QtFormula
  desc "JavaScript engine for Qt"
  
  setup_qt_formula ["qt-corelib"], "src/script", ["--enable-script"]
end
