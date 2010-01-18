#require 'rake/clean'

#CLEAN.include('*.o')
#CLOBBER.include('hello')

#task :default => ["hello"]

#SRC = FileList['*.c']
#OBJ = SRC.ext('o')

#rule '.o' => '.c' do |t|
#  sh "cc -c -o #{t.name} #{t.source}"
#end

#file "hello" => OBJ do
#  sh "cc -o hello #{OBJ}"
#end

# File dependencies go here ...
#file 'main.o' => ['main.c', 'greet.h']
#file 'greet.o' => ['greet.c']


def project_file(root_dir='.')
  Find.find(root_dir) do |f|
    if f =~ /\.xcodeproj$/
      return f
    end
  end
  nil
end

def xcodebuild
  "xcodebuild -project #{project_file}"
end

desc 'Build the default target using the default configuration'
task :build do |t|
  puts %x{
    #{xcodebuild} |
    grep -v "note: This view overlaps one of its siblings ."
  }
end

task :default => [ :build ]