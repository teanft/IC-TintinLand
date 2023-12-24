import Int "mo:base/Int";
import Array "mo:base/Array";
import Order "mo:base/Order";

actor {

  // Qsort an array of integers.
  public query func qsort(xs : [Int]) : async [Int] {
    return sortBy(xs, Int.compare);
  };

  type Order = Order.Order;

  // Sort the elements of an array using the given comparison function.
  func sortBy<X>(xs : [X], f : (X, X) -> Order) : [X] {
    let n = xs.size();
    if (n < 2) {
      return xs;
    } else {
      let result = Array.thaw<X>(xs);
      quicksort<X>(result, 0, n - 1, f);
      return Array.freeze<X>(result);
    };
  };

  private func quicksort<X>(
    xs : [var X],
    l : Int,
    r : Int,
    f : (X, X) -> Order,
  ) {
    if (l < r) {
      var i = l;
      var j = r;
      var swap = xs[0];
      let pivot = xs[Int.abs(l + r) / 2];
      while (i <= j) {
        while (Order.isLess(f(xs[Int.abs(i)], pivot))) {
          i += 1;
        };
        while (Order.isGreater(f(xs[Int.abs(j)], pivot))) {
          j -= 1;
        };
        if (i <= j) {
          swap := xs[Int.abs(i)];
          xs[Int.abs(i)] := xs[Int.abs(j)];
          xs[Int.abs(j)] := swap;
          i += 1;
          j -= 1;
        };
      };
      if (l < j) {
        quicksort<X>(xs, l, j, f);
      };
      if (i < r) {
        quicksort<X>(xs, i, r, f);
      };
    };
  };
};
