git_archive_plugin = self

namespace :git_archive do
  desc 'Copy repo to releases'
  task :create_release do
    git_archive_plugin.archive_repository do
      git_archive_plugin.git_archive_to_temp_file

      on release_roles :all do
        git_archive_plugin.release
      end
    end
  end

  desc 'Determine the revision that will be deployed'
  task :set_current_revision do
  end
end
