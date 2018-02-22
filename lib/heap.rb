class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    self.store = []
    self.prc = prc || Proc.new { |el1, el2| el1 <=> el2 }
  end

  def count
    store.length
  end

  def extract
  end

  def peek
  end

  def push(val)
  end

  public
  def self.child_indices(len, parent_index)
    [2 * parent_index + 1, 2 * parent_index + 2].select {|idx| idx < len}
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    child_indices(len, parent_idx)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    return array if child_idx == 0
    parent_idx = parent_index(child_idx)
    if prc.call(array[child_idx], array[parent_idx]) >= 0
      return array
    else
      array[child_idx], array[parent_idx] =  array[parent_idx], array[child_idx]
      heapify_up(array, parent_idx, len, &prc)
    end
  end
end
