hash_enabled = Rearmed.enabled_patches[:hash] == true

Hash.class_eval do
  if !{}.respond_to?(:compact) && (hash_enabled || Rearmed.dig(Rearmed.enabled_patches, :hash, :compact))
    def compact
      Rearmed.hash_compact(self)
    end

    def compact!
      self.reject!{|_, value| value.nil?}
    end
  end

  if !{}.respond_to?(:dig) && (hash_enabled || Rearmed.dig(Rearmed.enabled_patches, :hash, :dig))
    def dig(*args)
      Rearmed.dig(self, *args)
    end
  end

  if hash_enabled || Rearmed.dig(Rearmed.enabled_patches, :hash, :join)
    def join(delimiter=', ', &block)
      if block_given?
        Rearmed.hash_join(self, delimiter, &block)
      else
        Rearmed.hash_join(self, delimiter)
      end
    end
  end

  if hash_enabled || Rearmed.dig(Rearmed.enabled_patches, :hash, :only)
    def only(*keys)
      Rearmed.hash_only(self, *keys)
    end

    def only!(*keys)
      keys.map!{ |key| convert_key(key) } if respond_to?(:convert_key, true)
      omit = only(*self.keys - keys)
      hash = only(*keys)
      replace(hash)
      omit
    end
  end

  if hash_enabled || Rearmed.dig(Rearmed.enabled_patches, :hash, :to_struct)
    def to_struct
      Rearmed.hash_to_struct(self)
    end
  end
end
