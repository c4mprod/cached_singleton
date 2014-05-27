lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rack/test'
require 'minitest/autorun'
require 'cached_singleton'

class FakeModel
  def self.after_commit(f)
  end

  def self.transaction
    yield
  end

  def self.connection
    FakeConnection.new
  end

  def self.create
  end

  def self.first
  end

  def try(s)
  end

  def self.table_name
    'table_name'
  end

  include CachedSingleton
end

class FakeConnection
  def execute(r)
  end
end

class FakeCache
  class << self
    def read(k)
    end

    def write(k)
    end

    def delete(k)
    end
  end
end

class CachedSingletonTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def test_singleton_cache_key
    assert_equal FakeModel.singleton_cache_key, '/FakeModel'
  end

  def test_cache
    CachedSingleton.default_cache_strategy = FakeCache
    assert_equal FakeModel.cache, FakeCache
  end

  def test_single_instance_from_cache
    CachedSingleton.default_cache_strategy = FakeCache
    FakeCache.stub :read, FakeModel.new do
      assert_same FakeModel.instance, FakeModel.instance
    end
  end

  def test_single_instance_from_db
    CachedSingleton.default_cache_strategy = FakeCache
    FakeModel.stub :first, FakeModel.new do
        assert_same FakeModel.instance, FakeModel.instance
    end
  end

end