module Tasks
  module Helper
    def connection(url)
      Faraday::Connection.new(:url => url) do |builder|
        ## URLをエンコードする
        builder.use Faraday::Request::UrlEncoded
        ## ログを標準出力に出したい時(本番はコメントアウトでいいかも)
        builder.use Faraday::Response::Logger
        ## アダプター選択（選択肢は他にもあり）
        builder.use Faraday::Adapter::NetHttp
      end
    end
  end
end
