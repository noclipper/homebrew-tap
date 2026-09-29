class Podshare < Formula
  desc "Share a coding-agent session, with its files, as an encrypted pod someone else can resume"
  homepage "https://github.com/noclipper/podshare"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/noclipper/podshare/releases/download/v0.5.1/podshare-aarch64-apple-darwin.tar.xz"
      sha256 "79d7dc87b7dd66a1af5b26288be890cf2e0861d2c016d99ea1364abe5fbcbd7a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/noclipper/podshare/releases/download/v0.5.1/podshare-x86_64-apple-darwin.tar.xz"
      sha256 "6d64ec2cb9fab0b4220e06f5549c9c39355bca835e1480f6a6565cf217ed1bf8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/noclipper/podshare/releases/download/v0.5.1/podshare-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e7c29e6c4aaa5556f328011e0cc9372aa85808eb9a9127d9065acd363c0c033f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/noclipper/podshare/releases/download/v0.5.1/podshare-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "91b3589c28d295a50216c075b476651853a842b598213fc5fcabac7a4bb81478"
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
