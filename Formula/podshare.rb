class Podshare < Formula
  desc "Share a coding-agent session, with its files, as an encrypted pod someone else can resume"
  homepage "https://github.com/noclipper/podshare"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/noclipper/podshare/releases/download/v0.2.0/podshare-aarch64-apple-darwin.tar.xz"
      sha256 "bf4fd19b09675fdf17afc6c2e7b9b069f52c8361e579eb49fac147a20d4a3d56"
    end
    if Hardware::CPU.intel?
      url "https://github.com/noclipper/podshare/releases/download/v0.2.0/podshare-x86_64-apple-darwin.tar.xz"
      sha256 "c7b812cff6bdbae383e80fb345766c7590bc8e4c77ca4f7e507750ccd2fef172"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/noclipper/podshare/releases/download/v0.2.0/podshare-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3995d70aeaa10f4b702ed6b48b535b1d888ecc036af41f2543c6979955a0927f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/noclipper/podshare/releases/download/v0.2.0/podshare-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "096b72a3b5aa46e04ed59b1e5b4780d57d4504a505e528ad74c5eccb98a49f1c"
    end
  end
  license "FSL-1.1-ALv2"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
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
