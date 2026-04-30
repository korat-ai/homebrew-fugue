class Fugue < Formula
  desc "Fast F#/.NET AOT terminal coding agent — 40ms cold start, 46MB single binary"
  homepage "https://github.com/korat-ai/fugue"
  version "0.1.0"

  on_macos do
    on_arm do
      url "https://github.com/korat-ai/fugue/releases/download/v#{version}/fugue-#{version}-osx-arm64.tar.gz"
      # sha256 is updated automatically by the release workflow via `brew bump-formula-pr`
      sha256 "616d22a4dd176036382a14a89ebd11d16cf9a3a7bb9e7799bbfb85496e1d1a3c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/korat-ai/fugue/releases/download/v#{version}/fugue-#{version}-linux-x64.tar.gz"
      sha256 "1ddbd783ec5a108462c4679daa47c171e6ac321fa01ef39758b5eb247b733518"
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
