require 'open3'

def doit(i, n)
  map = [
    "",
    "https://core.honestbee.com/api/brands?countryCode=TW&page=1&page_size=48&serviceType=groceries",
    "https://core.honestbee.com/api/stores/#{n}/directory",
    "https://core.honestbee.com/api/departments/#{n}?page=1&pageSize=20&sort=ranking",
  ]

  url = map[i]
  cmd = %(curl -sSl -H "Accept: application/vnd.honestbee+json;version=2" -H "Accept-Language: zh-TW" #{url})
  res, s = Open3.capture2e(cmd)
  s.success? || raise(res)
  res
end