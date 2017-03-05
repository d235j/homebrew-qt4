require File.dirname(__FILE__) + "/lib/qtformula.rb"

class MocAT4 < QtFormula
  desc "C++ preprocessor for Qt 4"
  
  setup_qt_formula ["qt-bootstrap"], "src/tools/moc"
end
