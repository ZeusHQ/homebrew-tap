class Zproxy < Formula
    desc "A a zero-configuration ReverseProxy for Turborepos that automagically proxies all http and websocket requests from local domains to their respective localhost:port url."
    homepage "https://github.com/zeushq/zproxy-go"
    url "https://github.com/ZeusHQ/zproxy-go/archive/refs/tags/v1.0.4.tar.gz"
    sha256 "c72e6ea415c2d6af2289884584c5e6f9db641a84b46d40657aebbb358f82cff5"
  
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