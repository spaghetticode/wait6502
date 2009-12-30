module ActsAs
  module Permalink
    def acts_as_permalink(method)
      alias to_param_orig to_param
      define_method :to_param do
        [id, self.send(method).parameterize].join('-')
      end
    end
  end
end