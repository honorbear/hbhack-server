require 'open3'

module HonestBee
  module API
    class Products
      PREFIX = 'https://core.honestbee.com/api'

      class << self
        def retrieve(department_id, params = {})
          params[:page] ||= 1
          params[:pageSize] ||= 20
          params[:sort] ||= 'ranking'

          url = "#{PREFIX}/departments/#{department_id}?#{params.to_param}"
          puts "GET #{url}"
          request(url)
        end

        private

        def request(url)
          cmd = %(curl -sSl -H "Accept: application/vnd.honestbee+json;version=2" -H "Accept-Language: zh-TW" '#{url}')
          response, status = Open3.capture2e(cmd)
          status.success? || raise(response)
          JSON.parse(response)
        end
      end
    end
  end
end

# version 1
def doit(i, n = 0)
  map = [
    "https://core.honestbee.com/api/stores/#{n}",
    "https://core.honestbee.com/api/brands?countryCode=TW&page=1&page_size=55&serviceType=groceries",
    "https://core.honestbee.com/api/stores/#{n}/directory",
    "https://core.honestbee.com/api/departments/#{n}?page=1&pageSize=20&sort=ranking",
  ]

  url = map[i]
  cmd = %(curl -sSl -H "Accept: application/vnd.honestbee+json;version=2" -H "Accept-Language: zh-TW" #{url})
  res, s = Open3.capture2e(cmd)
  s.success? || raise(res)
  JSON.parse(res)
end
