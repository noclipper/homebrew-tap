class Podshare < Formula
  desc "Share a coding-agent session, with its files, as an encrypted pod someone else can resume"
  homepage "https://github.com/noclipper/podshare"
  version "0.4.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/noclipper/podshare/releases/download/v0.4.4/podshare-aarch64-apple-darwin.tar.xz"
      sha256 "c30aa2dd4d81f88116c9a254d67b590de2a54e040247104c8a38eae1787a60a2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/noclipper/podshare/releases/download/v0.4.4/podshare-x86_64-apple-darwin.tar.xz"
      sha256 "9f2342fa586f7ea12c1f70cea746bb412bbdda3b2e54483322d9d40b90fd08d0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/noclipper/podshare/releases/download/v0.4.4/podshare-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "92d72281562e5a30e3aea916e49724165736072cf1d317093670b666ede0850f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/noclipper/podshare/releases/download/v0.4.4/podshare-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "68f5c6c4c56495334f0905c93c40916911a8dafa23ef17f876a6c1574346add5"
    end
  end
  license "FSL-1.1-ALv2"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
      bin.install "podshare"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "podshare"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "podshare"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "podshare"
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
