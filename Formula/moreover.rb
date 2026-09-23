class Moreover < Formula
  desc "A pager for readers who can't press space — cursor-based, non-interactive pagination for LLMs, agents, and scripts."
  homepage "https://github.com/jlumbroso/moreover"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jlumbroso/moreover/releases/download/v0.2.0/moreover-aarch64-apple-darwin.tar.xz"
      sha256 "888bc0308cbf9a46518ecc28e5f5492dea561399383bb7f93cd7b33b4f6aa8e5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jlumbroso/moreover/releases/download/v0.2.0/moreover-x86_64-apple-darwin.tar.xz"
      sha256 "1ba36d83d8669ed7a8fa30563cf78a742f7ae543f2d8f2fc688cfdbfe4dc7299"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jlumbroso/moreover/releases/download/v0.2.0/moreover-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "069536d86ef11f92d1a16dd3a12eb41896b35ac55f709344443c8997dc0fc341"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jlumbroso/moreover/releases/download/v0.2.0/moreover-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d9ade8180ab3d270731211b21b05532f1b78c4bed0f763fa001fbe063dbef87c"
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
