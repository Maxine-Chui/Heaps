class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    prc = prc || Proc.new { |el1, el2| el1 <=> el2 }
  end

  def count
    @store.length
  end

  def extract
    raise "no element to extract" if count == 0
    val = @store[0]

    if count > 1
      @store[0] = @store.pop
      self.class.heapify_down(@store, 0, self.count, &prc)
    else
      store.pop
    end

    val
  end

  def peek
    raise "no element to peek" if count == 0
    @store[0]
  end

  def push(val)
    @store << val
    self.class.heapify_up(@store, self.count - 1, self.count, &prc)
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
    children_idx = child_indices(len, parent_idx)
    children = children_idx.map { |el| array[el] }

    if children.all? { |child| prc.call(array[parent_idx], child) <= 0 }
      return array
    end

    swap_idx = nil
    if children.length == 1
      swap_idx = children_idx[0]
    else
      swap_idx =
      prc.call(children[0], children[1]) == -1 ? children_idx[0] : children_idx[1]
    end

    array[parent_idx], array[swap_idx] = array[swap_idx], array[parent_idx]
    heapify_down(array, swap_idx, len, &prc)

  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    return array if child_idx == 0
    parent_idx = parent_index(child_idx)

    if prc.call(array[child_idx], array[parent_idx]) >= 0
      return array
    else
      array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
      heapify_up(array, parent_idx, len, &prc)
    end
  end
end
