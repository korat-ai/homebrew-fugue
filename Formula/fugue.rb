class Fugue < Formula
  desc "Fast F#/.NET AOT terminal coding agent — 40ms cold start, 46MB single binary"
  homepage "https://github.com/korat-ai/fugue"
  version "0.2.1"

  on_macos do
    on_arm do
      url "https://github.com/korat-ai/fugue/releases/download/v#{version}/fugue-#{version}-osx-arm64.tar.gz"
      # sha256 is updated automatically by the release workflow via `brew bump-formula-pr`
      sha256 "9066d924cc979b4469a291f44d41499f0cb8ac0809bb19da5a7ad28f56e38dfa"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/korat-ai/fugue/releases/download/v#{version}/fugue-#{version}-linux-x64.tar.gz"
      sha256 "8cbb63fe0b4bbd41b224b8f73f3cc04a8230273a9b76ba92aacb984613fa06d4"
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
