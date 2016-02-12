require "language/go"

class Logasaurus < Formula
  desc "Logasurous (loga command) is a command line utility that queries elasticsearch in realtime, so you can tail logs just like you used to."
  homepage "https://github.com/malnick/logasaurus"
  head "https://github.com/malnick/logasaurus.git"
  url "https://github.com/malnick/logasaurus/archive/0.0.12.tar.gz"
  sha1 "81e3704544f40a3f02d83861fffb3f33a53ed4ec"
  version "0.0.12"

  depends_on "go" => :build

  bottle do
    cellar :any_skip_relocation
    revision 1
#     sha256 "c7f115393c78e32d2073843330e3ab199e721c58d7f322aa9f9dd49dcaade82a" => :el_capitan
#     sha256 "2e7fe1da197114a7e3398c21a39e6731396233e9c45bb5526bf0bdf63d0ae15e" => :yosemite
#     sha256 "e4dd84c4b011dea5f9e0872f95eaaa5491543bc47e0db0fd35a294dd81cb5f39" => :mavericks
  end

  go_resource "gopkg.in/yaml.v2" do
    url "https://gopkg.in/yaml.v2.git"
  end

  go_resource "github.com/mgutz/ansi" do
    url "https://github.com/mgutz/ansi.git"
  end

  go_resource "github.com/Sirupsen/logrus" do
    url "https://github.com/Sirupsen/logrus.git"
  end

  def install
    ENV["GOPATH"] = buildpath

    mkdir_p buildpath/"src/github.com/malnick/"
    ln_sf buildpath, buildpath/"src/github.com/malnick/logasaurus"
    Language::Go.stage_deps resources, buildpath/"src"

    system "go", "build", "-o", "loga", "."
    bin.install "loga"
  end

  # Run the test with `brew test logasaurus`
  test do
    system bin/"loga", "--help"
  end
end
