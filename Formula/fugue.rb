class Fugue < Formula
  desc "Fast F#/.NET AOT terminal coding agent — 40ms cold start, 46MB single binary"
  homepage "https://github.com/korat-ai/fugue"
  version "0.1.0"

  on_macos do
    on_arm do
      url "https://github.com/korat-ai/fugue/releases/download/v#{version}/fugue-#{version}-osx-arm64.tar.gz"
      # sha256 is updated automatically by the release workflow via `brew bump-formula-pr`
      sha256 "2c3028dd32d19ff4f7ab6fa1e3ae3ce452a046a1951d8648e351f7aa43fe7d90"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/korat-ai/fugue/releases/download/v#{version}/fugue-#{version}-linux-x64.tar.gz"
      sha256 "1366bb33903e76fbf6124aaf2466cbaa7bdb84a36d49c60b0279fc7a578feab6"
    end
  end

  # No dependencies — native AOT binary embeds the .NET runtime.

  def install
    bin.install "fugue"
  end

  def caveats
    <<~EOS
      Configure your provider before first use:

        fugue config set provider anthropic
        fugue config set api-key  <your-key>   # or set ANTHROPIC_API_KEY in your shell

      For OpenAI-compatible endpoints (LM Studio, Ollama, etc.):

        fugue config set provider openai
        fugue config set api-key  <your-key>
        fugue config set base-url http://localhost:1234/v1

      Run `fugue --help` for all options.
    EOS
  end

  test do
    assert_match "fugue", shell_output("#{bin}/fugue --version")
  end
end
