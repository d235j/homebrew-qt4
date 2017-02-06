class QtScriptAT4 < Formula
  desc "Core library for Qt 4"
  homepage "https://www.qt.io/"
  url "https://download.qt.io/official_releases/qt/4.8/4.8.7/qt-everywhere-opensource-src-4.8.7.tar.gz"
  mirror "https://www.mirrorservice.org/sites/download.qt-project.org/official_releases/qt/4.8/4.8.7/qt-everywhere-opensource-src-4.8.7.tar.gz"
  sha256 "e2882295097e47fe089f8ac741a95fef47e0a73a3f3cdf21b56990638f626ea0"

  head "https://code.qt.io/qt/qt.git", :branch => "4.8"
  
  depends_on "cartr/qt4/qt-corelib@4"
  depends_on "cartr/qt4/moc@4"

  def install
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
    ]

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

    ln_s Formula["cartr/qt4/moc@4"].prefix/"bin/moc", "bin/moc"
    ENV.append "LDFLAGS", "-F#{Formula["cartr/qt4/qt-corelib@4"].prefix/'lib'}"
    system "./configure", *args
    Dir.chdir('src/script')
    system "make"
    ENV.j1
    system "make", "install"

    # Some config scripts will only find Qt in a "Frameworks" folder
    frameworks.install_symlink Dir["#{lib}/*.framework"]

    # The pkg-config files installed suggest that headers can be found in the
    # `include` directory. Make this so by creating symlinks from `include` to
    # the Frameworks' Headers folders.
    Pathname.glob("#{lib}/*.framework/Headers") do |path|
      include.install_symlink path => path.parent.basename(".framework")
    end
  end

  def caveats; <<-EOS.undent
    We agreed to the Qt opensource license for you.
    If this is unacceptable you should uninstall.
    EOS
  end
end
