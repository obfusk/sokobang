# --                                                            ; {{{1
#
# File        : sokobang.rb
# Maintainer  : Felix C. Stegerman <flx@obfusk.net>
# Date        : 2014-07-16
#
# Copyright   : Copyright (C) 2014  Felix C. Stegerman
# Licence     : GPLv3+
#
# --                                                            ; }}}1

require 'coffee-script'
require 'haml'
require 'sinatra/base'

class Sokobang < Sinatra::Base

  SCRIPTS = %w{
    /js/jquery.min.js
    /js/underscore.min.js
    /__coffee__/bigbang.js
    /__coffee__/sokobang.js
    /__coffee__/start.js
  }

  get '/' do
    redirect '/sokobang'
  end

  get '/sokobang' do
    haml :sokobang
  end

  get '/__coffee__/:name.js' do |name|
    content_type 'text/javascript'
    coffee :"coffee/#{name}"
  end

end

# vim: set tw=70 sw=2 sts=2 et fdm=marker :
