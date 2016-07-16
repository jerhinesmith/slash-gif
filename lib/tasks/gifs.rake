namespace :gifs do
  desc 'Check the validity of all existing gifs'
  task clean: :environment do
    dryrun = ENV['DRY_RUN'] == 'false' ? false : true
    log = ActiveSupport::Logger.new('log/rake.log')
    log.info "[gifs:clean] Task started at #{Time.now}"
    log.info("Running in dry run mode:") if dryrun

    invalid = []
    Gif.find_each do |gif|
      if gif.available?
        log << '.'
      else
        log << 'F'
        invalid << gif
      end
    end

    log.info("\n")
    invalid.each do |gif|
      log.info("Destroying: #{"#{gif.id} - #{gif.url}"}")
      gif.destroy unless dryrun
    end
    log.info("Destroyed #{invalid.length} gif(s)")
    log.info "To delete invalid records:\n  rake gifs:clean DRY_RUN=false\n" if dryrun
    log.close
  end
end
