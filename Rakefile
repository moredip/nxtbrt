require 'microstatic/rake'

desc "deploy to www.nxtbrt.com"
Microstatic::Rake.s3_deploy_task(:deploy) do |task|
  task.source_dir = File.expand_path("../public",__FILE__)
  task.bucket_name = "www.nxtbrt.com"
end
