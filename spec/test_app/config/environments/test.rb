# The test environment is used exclusively to run your application's
# test suite. You never need to work with it otherwise. Remember that
# your test database is "scratch space" for the test suite and is wiped
# and recreated between test runs. Don't rely on the data there!

Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true

  # Raises error for missing translations.
  if Gem::Version.new(Rails.version) < Gem::Version.new('6.1')
    config.action_view.raise_on_missing_translations = true
  else
    config.i18n.raise_on_missing_translations = true
  end

  if ActiveModel::Type::Boolean.new.cast(ENV['RAILS_LOG_TO_STDOUT'])
    logger = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end
end

# SELECT "good_jobs".* FROM "good_jobs" WHERE "good_jobs"."id" IN (WITH "rows" AS MATERIALIZED ( SELECT "good_jobs"."id", "good_jobs"."active_job_id" FROM "good_jobs" WHERE "good_jobs"."finished_at" IS NULL AND ("good_jobs"."scheduled_at" <= '2022-10-19 19:42:25.550285' OR "good_jobs"."scheduled_at" IS NULL) ORDER BY priority DESC NULLS LAST, created_at ASC ) SELECT "rows"."id" FROM "rows" WHERE pg_try_advisory_lock(('x' || substr(md5('good_jobs' || '-' || "rows"."active_job_id"::text), 1, 16))::bit(64)::bigint) LIMIT $1) ORDER BY priority DESC NULLS LAST, created_at ASC  [["LIMIT", 1]]
