require File.dirname(__FILE__) + "/lib/qtformula.rb"

class QtBootstrapAT4 < QtFormula
  desc "Bootstrap for Qt 4"
  
  def qt_build_and_install(args)
    system "make"
    lib.install "libbootstrap.a"
  end
  
  setup_qt_formula [], "src/tools/bootstrap"
end
