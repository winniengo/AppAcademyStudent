class Flash
  def initialize(req)
    # flash retrieve its contents from a cookie
    cookie = req.cookies['_rails_lite_app_flash']

    @flash_now = cookie ? JSON.parse(cookie) : {} # set flash to flash now
    @flash = {} # reset flash
  end

  def [](key)
    @flash_now[key.to_sym] || @flash[key]
  end

  def []=(key, val)
    @flash[key] = val
  end

  def now # access by 'flash.now'
    @flash_now
  end

  def store_flash(res)
    res.set_cookie('_rails_lite_app_flash',
      { value: @flash.to_json, path: "/"})
  end
end
