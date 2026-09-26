class Moreover < Formula
  desc "Pager for readers who can't press space: cursor-based, non-interactive pagination for LLMs, agents, and scripts"
  homepage "https://github.com/jlumbroso/moreover"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jlumbroso/moreover/releases/download/v0.3.0/moreover-aarch64-apple-darwin.tar.xz"
      sha256 "9f5f48bdb91780f604194f0039d232757ace5086037afa7c3f1c2f59681527b9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jlumbroso/moreover/releases/download/v0.3.0/moreover-x86_64-apple-darwin.tar.xz"
      sha256 "83de9525cf7ac91fb3a5ffb898f03cead7428485cbed56414fe6abb8c1cabc12"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jlumbroso/moreover/releases/download/v0.3.0/moreover-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c9a1182d87828237aa7960a56a8453a5970894e0982e98b48cdc7fd8f4546bf9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jlumbroso/moreover/releases/download/v0.3.0/moreover-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0b39f1c15d2544ecf75983b48f6640936e95a9f0f924cdd8c4dce1f5bceebab6"
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
