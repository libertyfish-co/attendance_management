class Range
    include Comparable
  
    def <=>(other)
      self.begin <=> other.begin
    end
  
    def self.overlap?(ranges)
      edges = ranges.sort.flat_map { |range| [range.begin, range.end] }
      edges != edges.sort.uniq
    end
  end