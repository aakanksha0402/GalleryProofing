 @dir = "/Users/c224/Documents/sites/galleryproof/GalleryProof/"

 worker_processes 2
 working_directory @dir

 timeout 80


 listen "192.168.1.224:3000", :backlog => 64


 pid "#{@dir}/tmp/pids/unicorn.pid"


 stderr_path "#{@dir}/log/unicorn.stderr.log"
 stdout_path "#{@dir}/log/unicorn.stdout.log"
