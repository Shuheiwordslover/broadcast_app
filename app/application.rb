module Workspace
  class Application < Rails::Application
.省略
.
.
#おまじない開始
    config.autoload_paths += Dir[Rails.root.join('app', 'uploaders')]
#おまじない終わり
  end
end
