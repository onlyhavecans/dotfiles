function jpwine -w wine --description "wine with jp env"
  env LC_ALL=ja_JP.UTF-8 wine $argv
end
