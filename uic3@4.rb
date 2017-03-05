require File.dirname(__FILE__) + "/lib/qtformula.rb"

class Uic3AT4 < QtFormula
  desc "Old user interface compiler for Qt 4"
  
  setup_qt_formula [], "src/tools/uic3"
end
