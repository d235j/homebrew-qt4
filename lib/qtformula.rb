class QtFormula < Formula
  def qt_build_and_install(args)
    system "make"
    ENV.j1
    system "make", "install"
  end
  
  def self.setup_qt_formula(qt_deps, qt_buildpath, qt_configure_args=[])
    homepage "https://www.qt.io/"
    url "https://download.qt.io/official_releases/qt/4.8/4.8.7/qt-everywhere-opensource-src-4.8.7.tar.gz"
    mirror "https://www.mirrorservice.org/sites/download.qt-project.org/official_releases/qt/4.8/4.8.7/qt-everywhere-opensource-src-4.8.7.tar.gz"
    sha256 "e2882295097e47fe089f8ac741a95fef47e0a73a3f3cdf21b56990638f626ea0"

    head "https://code.qt.io/qt/qt.git", :branch => "4.8"

    qt_deps.each do |dep|
      depends_on "cartr/qt4/#{dep}@4"
    end
    
    define_method("install") do
      args = %W[
        -prefix #{prefix}
        -release
        -opensource
        -confirm-license
        -fast
        -system-zlib
        -nomake demos
        -nomake examples
        -cocoa
        --no-gui
        --no-script
        --no-scripttools
        --no-phonon
        --no-multimedia
        --no-svg
        --no-webkit
        --no-declarative
      ]
      qt_configure_args.each do |arg|
        args << arg
      end
      if ENV.compiler == :clang
        args << "-platform"

        if MacOS.version >= :mavericks
          args << "unsupported/macx-clang-libc++"
        else
          args << "unsupported/macx-clang"
        end
      end

      if MacOS.prefer_64_bit?
        args << "-arch" << "x86_64"
      else
        args << "-arch" << "x86"
      end

      if Formula["cartr/qt4/moc@4"].installed?
        ln_s Formula["cartr/qt4/moc@4"].prefix/"bin/moc", "bin/moc"
      end
      if Formula["cartr/qt4/uic@4"].installed?
        ln_s Formula["cartr/qt4/uic@4"].prefix/"bin/uic", "bin/uic"
      end
      if Formula["cartr/qt4/rcc@4"].installed?
        ln_s Formula["cartr/qt4/rcc@4"].prefix/"bin/rcc", "bin/rcc"
      end
      qt_deps.each do |dep|
        ENV.append "LDFLAGS", "-F#{Formula["cartr/qt4/#{dep}@4"].prefix/'lib'}"
      end
      system "./configure", *args
      Dir.chdir(qt_buildpath)
      qt_build_and_install args

      # Some config scripts will only find Qt in a "Frameworks" folder
      frameworks.install_symlink Dir["#{lib}/*.framework"]

      # The pkg-config files installed suggest that headers can be found in the
      # `include` directory. Make this so by creating symlinks from `include` to
      # the Frameworks' Headers folders.
      Pathname.glob("#{lib}/*.framework/Headers") do |path|
        include.install_symlink path => path.parent.basename(".framework")
      end
    end
  end

  def caveats; <<-EOS.undent
    We agreed to the Qt opensource license for you.
    If this is unacceptable you should uninstall.
    EOS
  end
end
