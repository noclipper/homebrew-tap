class Podshare < Formula
  desc "Share a coding-agent session, with its files, as an encrypted pod someone else can resume"
  homepage "https://github.com/noclipper/podshare"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/noclipper/podshare/releases/download/v0.4.0/podshare-aarch64-apple-darwin.tar.xz"
      sha256 "1974602bab37eed7a1783fb59b28fd44c04da36eb7f1fab9336c335b209b3d81"
    end
    if Hardware::CPU.intel?
      url "https://github.com/noclipper/podshare/releases/download/v0.4.0/podshare-x86_64-apple-darwin.tar.xz"
      sha256 "571b488bc53b0bdc66b81c091967510e3afae7998f416c94c16357ead43ed1e7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/noclipper/podshare/releases/download/v0.4.0/podshare-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a6f416214bcd5e11a83788692ea3c6871a36f2ae65982edd59d490df5d4bcb6e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/noclipper/podshare/releases/download/v0.4.0/podshare-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a96cda402a01b9bb76b50c76279326d6f37b445af7093762984b52dfea28ab18"
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
