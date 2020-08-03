module ActiveRecord
  class Base
    # Validate that the the objects in +collection+ are unique
    # when compared against all their non-blank +attrs+. If not
    # add +message+ to the base errors.
    def validate_uniqueness_of_in_memory(collection, attrs, message)
      duplicates = []
      hashes = collection.inject({}) do |hash, record|
        key = attrs.map {|a| record.send(a).to_s }.join
        key = record.object_id if key.blank? || record.marked_for_destruction?
        duplicates.push(record) if hash[key].present?
        hash[key] = record unless hash[key]
        hash
      end

      duplicates.each do |obj|
        obj.errors.add(attrs.join, message)
      end

      association = collection.class.to_s.split('::').first.pluralize.downcase
      self.errors.add(association, message) if collection.length > hashes.length
    end
  end
end
