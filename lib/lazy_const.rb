module LazyConst

  CACHE = {}

  def lazy_const(name, &block)
    raise Error("lazy_const requires a block") unless block_given?
    LazyConst::CACHE["#{self.name}.#{name}"] = nil
    define_singleton_method name do
      LazyConst::CACHE["#{self.name}.#{name}"] ||= block.call
    end
  end

  def self.preload
    self.clear
    LazyConst::CACHE.keys.each do |class_dot_name|
      klass, name = class_dot_name.split('.')
      m = klass.constantize.send name.to_sym
    end
  end

  def self.clear
    LazyConst::CACHE.keys.each do |k|
      LazyConst::CACHE[k] = nil
    end
  end

end

