class MinuteJob < ApplicationJob
  ExpectedError = Class.new(StandardError)
  DeadError = Class.new(StandardError)

  include GoodJob::ActiveJobExtensions::Concurrency
  good_job_control_concurrency_with(
    total_limit: 1,
    key: -> do
      interval = 1.minute
      rounded_seconds = (arguments.first.to_i / interval.to_i) * interval.to_i
      rounded = Time.zone.at(rounded_seconds)
      "minute-job-#{rounded.to_i}"
    end,
  )

  discard_on GoodJob::ActiveJobExtensions::Concurrency::ConcurrencyExceededError

  retry_on(DeadError, attempts: 3) { nil }

  def perform(_date)
    puts 'starting cron'
    sleep(45)
    puts 'finished cron'
  end
end
