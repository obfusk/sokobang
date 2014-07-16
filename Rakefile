desc 'Run specs'
task :spec do
  sh 'jasmine-node --coffee spec/'
end

desc 'Run specs verbosely'
task 'spec:verbose' do
  sh 'jasmine-node --coffee --verbose spec/'
end

desc 'Run specs verbosely, view w/ less'
task 'spec:less' do
  sh 'jasmine-node --coffee --verbose spec/ | less -R'
end

desc 'Generate docs'
task :docs do
  sh 'docco -o doc src/*.coffee'
end

desc 'Cleanup'
task :clean do
  sh 'rm -rf doc/ node_modules/ src/*.js'
end

desc 'Update Pages'
task :pages do
  sh 'rake clean && rake docs'
  sh 'git checkout gh-pages'
  sh 'rake cpdocs'
  sh 'git add .'
  sh 'git status'
  puts 'press enter to continue ...'; $stdin.readline
  sh 'git commit -m ...'
  sh 'git checkout master'
end
