class Podshare < Formula
  desc "Share a coding-agent session, with its files, as an encrypted pod someone else can resume"
  homepage "https://github.com/noclipper/podshare"
  version "0.4.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/noclipper/podshare/releases/download/v0.4.5/podshare-aarch64-apple-darwin.tar.xz"
      sha256 "1fbc9c7f8548f4cab0a9a1e9eae486a0059d560e45721c271dc630dd87d64e9e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/noclipper/podshare/releases/download/v0.4.5/podshare-x86_64-apple-darwin.tar.xz"
      sha256 "923d1e09ae0bf7561ac4d12801bde06af6afb54f0bdf86a531b66f710177b529"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/noclipper/podshare/releases/download/v0.4.5/podshare-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "32ac3a9995bf8983f4f778100dade61c0d14b4f3c0cae30c74ae7430462b6c64"
    end
    if Hardware::CPU.intel?
      url "https://github.com/noclipper/podshare/releases/download/v0.4.5/podshare-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2a6df4a77072db61461e455656de10c3e0851eb94e31f7dc3e446726db277d7a"
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
