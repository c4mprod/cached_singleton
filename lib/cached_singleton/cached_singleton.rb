require 'cached_singleton/version'

module CachedSingleton
  @@cache_strategy = nil

  def self.default_cache_strategy=(cache_strategy)
    @@cache_strategy = cache_strategy
  end

  def self.default_cache_strategy
    unless @@cache_strategy
      raise RuntimeError.new('default cache strategy not set')
    end
    @@cache_strategy
  end

  def self.included(model)
    model.class_eval do

      class << self
        def cache
          CachedSingleton.default_cache_strategy
        end

        def singleton_cache_key
          "/#{self.name}"
        end

        def instance
          # Fetch in cache
          m = self.cache.read(singleton_cache_key)
          return m if m

          # Get it in from the DB or create it
          transaction do
            # We ensure no other process is trying to SELECT OR INSERT the same record by locking
            # the entire table (read + write) during the transaction
            connection.execute("LOCK TABLE #{table_name} IN EXCLUSIVE MODE")
            m = first || create
          end

          # Save it in cache if it's in the DB
          self.cache.write(singleton_cache_key, m) if m.try(:persisted?)

          m
        end
      end

      after_commit :expire_cache
    end
  end

  def expire_cache
    self.class.cache.delete(self.class.singleton_cache_key) if (!new_record? || destroyed?)
  end
end