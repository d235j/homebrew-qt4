require File.dirname(__FILE__) + "/lib/qtformula.rb"

class UicAT4 < QtFormula
  desc "User interface compiler for Qt 4"
  
  setup_qt_formula [], "src/tools/uic"
end
