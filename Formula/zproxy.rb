class ZProxy < Formula
    desc "A a zero-configuration ReverseProxy for Turborepos that automagically proxies all http and websocket requests from local domains to their respective localhost:port url."
    homepage "https://github.com/zeushq/zproxy"
    url "https://github.com/zeushq/zproxy/archive/v1.0.2.tar.gz"
    sha256 "a2f77edfb44d3de5a683ee32d1550b404cbf62ea6d2d46ea6f86a0ab9317d39e"
  
    depends_on "go"
  
    def install
      ENV["GOPATH"] = buildpath
      ENV["GO111MODULE"] = "on"
      ENV["GOFLAGS"] = "-mod=vendor"
      ENV["PATH"] = "#{ENV["PATH"]}:#{buildpath}/bin"
      (buildpath/"src/github.com/zeushq/zproxy").install buildpath.children
      cd "src/github.com/zeushq/zproxy" do
        system "go", "build", "-o", bin/"zproxy", "."
      end
    end
  
    test do
      assert_match /Usage of zproxy/, shell_output("#{bin}/zproxy -h", 0)
    end
end