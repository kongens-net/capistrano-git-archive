require 'tempfile'
require 'capistrano/scm/plugin'

module Capistrano
  module GitArchive
    # SCM plugin for capistrano
    # uses a local clone and uploads a tar archive to the server
    class SCM < ::Capistrano::SCM::Plugin
      # set default values
      def set_defaults
      end

      # define plugin tasks
      def define_tasks
        eval_rakefile File.expand_path('../tasks/git_archive.rake', __FILE__)
      end

      # register capistrano hooks
      def register_hooks
        after  'deploy:new_release_path',     'git_archive:create_release'
        before 'deploy:set_current_revision', 'git_archive:set_current_revision'
      end

      def archive_repository(&block)
        block.call
      ensure
        temp_file.close
        temp_file.unlink
      end

      def git_archive_to_temp_file
        `git archive --remote=#{fetch(:repo_url)} --output=#{temp_file.path} #{fetch(:branch, 'master')}`
      end


      # Upload and extract release
      #
      # @return void
      def release
        remote_archive_path = File.join(fetch(:deploy_to), File.basename(temp_file.path))

        backend.execute :mkdir, '-p', release_path
        backend.upload!(temp_file.path, remote_archive_path)
        backend.execute(:tar, '-f', remote_archive_path, '-x', '-C', release_path)
        backend.execute(:rm, '-f', remote_archive_path)
      end

      def temp_file
        @temp_file ||= Tempfile.new([fetch(:application), '.tar.gz'])
      end
    end
  end
end
