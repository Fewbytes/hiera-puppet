class Hiera
  class Scope
    attr_reader :real

    def initialize(real)
      @real = real
    end

    def [](key)
      if key == "calling_class"
        ans = @real.scope_path.find  {|c| c.source.type == :hostclass }.source.name
      elsif key == "calling_module"
        ans = @real.source.module_name
      else
        ans = @real.lookupvar(key)
      end

      # damn you puppet visual basic style variables.
      return nil if ans == ""
      return ans
    end

    def include?(key)
      return true if ["calling_class", "calling_module"].include?(key)

      return @real.lookupvar(key) != ""
    end

    def catalog
      @real.catalog
    end

    def resource
      @real.resource
    end

    def compiler
      @real.compiler
    end
  end
end

