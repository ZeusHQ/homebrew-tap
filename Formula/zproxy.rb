class Zproxy < Formula
    desc "A a zero-configuration ReverseProxy for Turborepos that automagically proxies all http and websocket requests from local domains to their respective localhost:port url."
    homepage "https://github.com/zeushq/zproxy-go"
    url "https://github.com/ZeusHQ/zproxy-go/archive/refs/tags/v1.0.3.tar.gz"
    sha256 "3c31b3e85ba018d64e243e3aa834d554494301a9aa5cf54bab68fe4242b41cc2"
  
    depends_on "go"
  
    def install
      ENV["GOPATH"] = buildpath
      ENV["GO111MODULE"] = "on"
      ENV["GOFLAGS"] = "-mod=vendor"
      ENV["PATH"] = "#{ENV["PATH"]}:#{buildpath}/bin"
      (buildpath/"src/github.com/zeushq/zproxy-go").install buildpath.children
      cd "src/github.com/zeushq/zproxy-go" do
        system "go", "mod", "vendor"
        system "go", "build", "-o", bin/"zproxy", "."
      end
    end
  
    test do
      assert_match /Usage of zproxy/, shell_output("#{bin}/zproxy -h", 0)
    end
end