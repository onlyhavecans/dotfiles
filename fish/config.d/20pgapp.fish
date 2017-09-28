set -l pg_app /Applications/Postgres.app/Contents/Versions/latest/bin
if test -d $pg_app
  append_path $pg_app
end
