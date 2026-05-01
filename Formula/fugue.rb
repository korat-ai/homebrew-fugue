class Fugue < Formula
  desc "Fast F#/.NET AOT terminal coding agent — 40ms cold start, 46MB single binary"
  homepage "https://github.com/korat-ai/fugue"
  version "0.3.0"

  on_macos do
    on_arm do
      url "https://github.com/korat-ai/fugue/releases/download/v#{version}/fugue-#{version}-osx-arm64.tar.gz"
      # sha256 is updated automatically by the release workflow via `brew bump-formula-pr`
      sha256 "88e9b71cf558d1077b130b6b2db9c3fdc9bcd434010b85b7992c5a00886bc070"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/korat-ai/fugue/releases/download/v#{version}/fugue-#{version}-linux-x64.tar.gz"
      sha256 "4c6acaadb55563d8ef352a6020e8d129f31c8637e831f5277f1039f43bab7154"
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
