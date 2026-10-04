class Moreover < Formula
  desc "Pager for readers who can't press space: cursor-based, non-interactive pagination for LLMs, agents, and scripts"
  homepage "https://github.com/jlumbroso/moreover"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jlumbroso/moreover/releases/download/v0.4.0/moreover-aarch64-apple-darwin.tar.xz"
      sha256 "49983e7ce22ade2d03488d80f8ba17802a88a3d5ac3657346d6f326b43711d6d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jlumbroso/moreover/releases/download/v0.4.0/moreover-x86_64-apple-darwin.tar.xz"
      sha256 "35f4094e95ec3fe4049a356dff8ff54a7ace235d5d7991a24128bb1670e7a8bc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jlumbroso/moreover/releases/download/v0.4.0/moreover-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6cfa9907d633b54d6c8859edb5aec07ff1c0baa549e5538b9ac5bb44a5149c96"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jlumbroso/moreover/releases/download/v0.4.0/moreover-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "11835cf4cdaf9d6993435d7709aa645e44b2f901d08a79a628932db2cf05d506"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "moreover"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "moreover"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "moreover"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "moreover"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
