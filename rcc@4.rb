require File.dirname(__FILE__) + "/lib/qtformula.rb"

class RccAT4 < QtFormula
  desc "Resource compiler for Qt 4"
  
  setup_qt_formula ["qt-bootstrap"], "src/tools/rcc"
end
