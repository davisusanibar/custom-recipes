class Protobuf < Formula
  desc "Protocol buffers (Google's data interchange format)"
  homepage "https://github.com/protocolbuffers/protobuf/"
  url "https://github.com/protocolbuffers/protobuf/releases/download/v3.17.3/protobuf-all-3.17.3.tar.gz"
  sha256 "77ad26d3f65222fd96ccc18b055632b0bfedf295cb748b712a98ba1ac0b704b2"
  license "BSD-3-Clause"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any,                 arm64_monterey: "a467da7231471d7913ed291e83852e1ca950db86d142b2a67e0839743dc132b7"
    sha256 cellar: :any,                 arm64_big_sur:  "188863a706dd31a59ce0f4bdcf7d77d46e681ed8e72a8ab9ba28e771b52b58fd"
    sha256 cellar: :any,                 monterey:       "ca9840b58a314543c0f45490e6a543eb330eb772f0db385ef005d82b6b169047"
    sha256 cellar: :any,                 big_sur:        "a6e39ca1c9418561aa2e576a62c86fe11674b81c922a8f610c75aa9211646863"
    sha256 cellar: :any,                 catalina:       "5cc145bfca99db8fbe89d8b24394297bde7075aaa3d564cd24478c5762563ef6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7c3e53cb5448c38183693262da84e5e100a11c3d08de6b5088ed2d1a7f00e106"
  end

  head do
    url "https://github.com/protocolbuffers/protobuf.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "six"

  uses_from_macos "zlib"

  def install
    # Don't build in debug mode. See:
    # https://github.com/Homebrew/homebrew/issues/9279
    # https://github.com/protocolbuffers/protobuf/blob/5c24564811c08772d090305be36fae82d8f12bbe/configure.ac#L61
    ENV.prepend "CXXFLAGS", "-DNDEBUG"
    ENV.cxx11

    system "./autogen.sh" if build.head?
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--with-zlib"
    system "make", "install"
  end
end
